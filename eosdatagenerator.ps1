<#
   To run this, put your SQL Server instance names in a text file and run the following command: .\eosdatagenerator.ps1 -SQLServerList "C:\PowerShell\ServerInstances.txt"
#>


param([string]$SQLServerList=$(Throw `
"Paramater missing: -SQLServerList ConfigGroup"))


Function Get-CPUInfo{
    [CmdletBinding()]
    Param(
    [parameter(Mandatory = $TRUE,ValueFromPipeline = $TRUE)]   [String] $ServerName

    )

    Process{
    
            # Get Default SQL Server instance's Edition
            $sqlconn = new-object System.Data.SqlClient.SqlConnection(`
                        "server=$ServerName;Trusted_Connection=true");
            $query = "SELECT SERVERPROPERTY('Edition') AS Edition, SERVERPROPERTY('MachineName') AS MachineName, SERVERPROPERTY('productversion') as Version, SERVERPROPERTY ('productlevel') as ProductLevel;"

            $sqlconn.Open()
            $sqlcmd = new-object System.Data.SqlClient.SqlCommand ($query, $sqlconn);
            $sqlcmd.CommandTimeout = 0;
            $dr = $sqlcmd.ExecuteReader();

            while ($dr.Read()) { 
             $SQLEdition = $dr.GetValue(0); 
             $MachineName = $dr.GetValue(1);
             $Version = $dr.GetValue(2);
             $ProductLevel = $dr.GetValue(3)

            }
            $Version = $Version.Substring(0,4);
            $SQLEdition = $SQLEdition.split(' ')[0];

            If ($Version -eq "10.0"){
                $OutVersion = 'SQL Server 2008'}
            Elseif ($Version -eq "10.5"){
                $OutVersion = 'SQL Server 2008R2'}
            Elseif ($Version -eq "11.0"){
                $OutVersion = 'SQL Server 2012'} 
            Elseif ($Version -eq "12.0"){
                $OutVersion = 'SQL Server 2014'}
            Elseif ($Version -eq "13.0"){
                $OutVersion = 'SQL Server 2016'}  
            Elseif ($Version -eq "14.0"){
                $OutVersion = 'SQL Server 2017'} 
            Elseif ($Version -eq "15.0"){
                $OutVersion = 'SQL Server 2019'}   
            Else {
                $OutVersion = 'Unknown'}

            $Version = $OutVersion
            $dr.Close()
            $sqlconn.Close()

   
            #Get processors information            
            $CPU=Get-WmiObject -ComputerName $MachineName -class Win32_Processor
            #Get Computer model information
            $OS_Info=Get-WmiObject -ComputerName $MachineName -class Win32_ComputerSystem
            
     
           #Reset number of cores and use count for the CPUs counting
           $CPUs = 0
           $Cores = 0
           
           foreach($Processor in $CPU){

           $CPUs = $CPUs+1   
           
           #count the total number of cores         
           $Cores = $Cores+$Processor.NumberOfCores
        
          } 
           
           $InfoRecord = New-Object -TypeName PSObject -Property @{
                    Name = $ServerName;
                    Model = $OS_Info.Model;
                    Cores = $Cores;
                    Edition = $SQLEdition;
                    Version = $Version;
                    ProductLevel = $ProductLevel;

    }
 
    


   Write-Output $InfoRecord
          }
}

#loop through the server list and get information about CPUs, Cores and Default instance edition
Get-Content $SQLServerList | Foreach-Object {Get-CPUInfo $_ }|Format-Table -AutoSize Server, Model, Edition, TotalCores, Version, ProductLevel
