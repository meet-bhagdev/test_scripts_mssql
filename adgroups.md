## Step 1: Join host to AD domain
Numerous tools exist to help you join the host machine to your AD domain. This walkthrough uses **[realmd](https://www.freedesktop.org/software/realmd/docs/guide-active-directory-join.html)**, a popular open source package. If you haven't already, install both the realmd and Kerberos client packages on the 
    
    sudo yum install realmd krb5-workstation
    

### Example DNS configuration: RHEL
Edit the `/etc/sysconfig/network-scripts/ifcfg-eth0` file (or other interface config file as appropriate) so that your AD domain controller's IP address is listed as a DNS server:

 ```/etc/sysconfig/network-scripts/ifcfg-eth0
<...>
PEERDNS=no
DNS1=**<AD domain controller IP address>**
```
After editing this file, restart the network service:
```bash
sudo systemctl restart network
```
Now check that your `/etc/resolv.conf` file contains a line like the following:  
```Code  
nameserver **<AD domain controller IP address>**
```  

### Join the domain
Once you've confirmed that your DNS is configured properly, join the domain by running the command below. You'll need to authenticate using an AD account that has sufficient privileges in AD to join a new machine to the domain. 
Specifically, this command will create a new computer account in AD, create the `/etc/krb5.keytab` host keytab file, and configure the domain in `/etc/sssd/sssd.conf`:
```bash  									
sudo realm join contoso.com -U 'user@CONTOSO.COM' -v
<...>
 * Successfully enrolled machine in realm
```    

>  [!NOTE]  
>   If you see an error, "Necessary packages are not installed," then you should install those packages using your Linux distribution's package manager before running the `realm join` command again. 
>  
>  If you receive an error, "Insufficient permissions to join the domain," then you will need to check with a domain administrator that you have sufficient permissions to join Linux machines to your domain.

 
Verify that you can now gather information about a user from the domain, and that you can acquire a Kerberos ticket as that user. 

We will use **id**, **[kinit](https://web.mit.edu/kerberos/krb5-1.12/doc/user/user_commands/kinit.html)** and **[klist](https://web.mit.edu/kerberos/krb5-1.12/doc/user/user_commands/klist.html)** commands for this.

```bash  
id user@contoso.com
uid=1348601103(user@contoso.com) gid=1348600513(domain group@contoso.com) groups=1348600513(domain group@contoso.com)

kinit user@CONTOSO.COM
Password for user@CONTOSO.COM:

klist
Ticket cache: FILE:/tmp/krb5cc_1000
Default principal: user@CONTOSO.COM
<...>
```   

>  [!NOTE]  
>   If `id user@contoso.com` returns, "No such user," make sure that the SSSD service started successfully by running the command `sudo systemctl status sssd`. If the service is running and you still see the "No such user" error, try enabling verbose logging for SSSD. For more information, see the Red Hat documentation for [Troubleshooting SSSD](https://access.redhat.com/documentation/Red_Hat_Enterprise_Linux/7/html/System-Level_Authentication_Guide/trouble.html#SSSD-Troubleshooting).  
>  
>  If `kinit user@CONTOSO.COM` returns, "KDC reply did not match expectations while getting initial credentials," make sure you specified the realm in uppercase.

For more information, see the Red Hat documentation for [Discovering and Joining Identity Domains](https://access.redhat.com/documentation/Red_Hat_Enterprise_Linux/7/html/Windows_Integration_Guide/realmd-domain.html). 


## Step 2: Setup your domain controller 

>  [!NOTE]  
>  In the next steps we will use your [fully qualified domain name](https://en.wikipedia.org/wiki/Fully_qualified_domain_name). If you are on **Azure**, you will have to **[create one](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/portal-create-fqdn)** before you proceed. 

On your domain controller, run the [New-ADUser](https://technet.microsoft.com/library/ee617253.aspx) PowerShell command to create a new AD user with a password that never expires. This example names the account "mssql," but the account name can be anything you like. You will be prompted to enter a new password for the account:  
```PowerShell  	
Import-Module ActiveDirectory

New-ADUser mssql -AccountPassword (Read-Host -AsSecureString "Enter Password") -PasswordNeverExpires $true -Enabled $true
```   


>  [!NOTE]  
>  It is a security best practice to have a dedicated AD account for SQL Server, so that SQL Server's credentials aren't shared with other services using the same account. However, you can reuse an existing AD account if you prefer, if you know the account's password (required to generate a keytab file in the next step).

Now set the ServicePrincipalName (SPN) for this account using the `setspn.exe` tool. The SPN must be formatted exactly as specified in the following example: You can find the fully qualified domain name of the host machine by running `hostname --all-fqdns` on the host, and the TCP port should be 1433 unless you have configured to use a different port number.  

Next use ktpass to generate a keytab file.

```PowerShell   
setspn -A MSSQLSvc/**<fully qualified domain name of host machine>**:**<tcp port>** mssql
ktpass /princ <hostname>$@<DOMAINREALM> /out mssql.keytab /mapuser DOMAINREALM\hostname$ /pass * /crypto All
# Example: ktpass /princ meetrhel$@KUNALTESTAD.COM /out mssql.keytab /mapuser KUNALTESTAD\meetrhel$ /pass * /crypto All
```   
Now move the keytab over to your SQL Server Linux machine using scp. Once copied move it to the following folder

    /var/opt/mssql/secrets/

## Step 3: Create AD group and add your user to the group

Use the Active Directory UI for this

## Step 4: Modify the keytab file

First, check the Key Version Number (kvno) for the AD account created in the previous step. Usually it will be 2, but it could be another integer if you changed the account's password multiple times. On the SQL Server host machine, run the following:

kinit user@CONTOSO.COM
kvno MSSQLSvc/**<fully qualified domain name of host machine>**:**<tcp port>**@<REALMNAME>

Now create a keytab file for the AD user you created in the previous step. To do so we will use **[ktutil](https://web.mit.edu/kerberos/krb5-1.12/doc/admin/admin_commands/ktutil.html)**. When prompted, enter the password for that AD account. 
```bash  
sudo ktutil

ktutil: addent -password -p MSSQLSvc/**<fully qualified domain name of host machine>**:**<tcp port>**@CONTOSO.COM -k **<kvno from above>** -e aes256-cts-hmac-sha1-96

ktutil: addent -password -p MSSQLSvc/**<fully qualified domain name of host machine>**:**<tcp port>**@CONTOSO.COM -k **<kvno from above>** -e rc4-hmac

ktutil: wkt /var/opt/mssql/secrets/mssql.keytab

quit
```  

>  [!NOTE]  
>  The ktutil tool does not validate the password, so make sure you enter it correctly.

Anyone with access to this `keytab` file can impersonate on the domain, so make sure you restrict access to the file such that only the `mssql` account has read access:  
```bash  
sudo chown mssql:mssql /var/opt/mssql/secrets/mssql.keytab
sudo chmod 400 /var/opt/mssql/secrets/mssql.keytab
```  
Next, configure to use this `keytab` file for Kerberos authentication:  
```bash  
sudo /opt/mssql/bin/mssql-conf set network.kerberoskeytabfile /var/opt/mssql/secrets/mssql.keytab
sudo systemctl restart mssql-server
```  

## Step 4: Create AD-based logins in Transact-SQL  
Connect to and create a new, AD-based login:  
```Transact-SQL  
CREATE LOGIN [CONTOSO\groupuser] FROM WINDOWS;
#Assumption that you have a group called groupuser in your domain 
```   

Verify that the login is now listed in the [sys.server_principals](/sql/relational-databases/system-catalog-views/sys-server-principals-transact-sql.mc) system catalog view:  
```Transact-SQL  
SELECT name FROM sys.server_principals;
```  

## Step 5: Connect to using AD Authentication  
Log in to a client machine using your domain credentials. Now you can connect to without reentering your password, by using AD Authentication. If you create a login for an AD group, any AD user who is a member of that group can connect in the same way.  
The specific connection string parameter for clients to use AD Authentication depends on which driver you are using. A few examples are below.  

## Examples  
### Example 1: `sqlcmd` on a domain-joined Linux client  


Make sure you've installed the [mssql-tools](sql-server-linux-setup-tools.md) package, then connect using `sqlcmd` without specifying any credentials:  
```bash  
sqlcmd -S mssql.contoso.com
```  
