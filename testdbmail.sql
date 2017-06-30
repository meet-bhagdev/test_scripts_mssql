
-- Below are a few basic steps to enable DBMail, create account, create profile, add operator to SQLAgent and add notifications to a job. 

-- Note that you need to add the default profile to mssql.config: 

    mssql-conf set sqlagent.databasemailprofile default 
    
-- or via an environment variable: 

    MSSQL_AGENT_EMAIL_PROFILE=default 
  
-- In the scripts below, you need to have some email accounts available and an SMTP server to which you can login (or which allows anonymous authentication). Hope this works. Let me know if there are problems. 
  
USE master 
GO 
sp_configure 'show advanced options',1 
GO 
RECONFIGURE WITH OVERRIDE 
GO 
sp_configure 'Database Mail XPs', 1 
GO 
RECONFIGURE  
GO  

-- Create new account
EXECUTE msdb.dbo.sysmail_add_account_sp
@account_name = 'SQLAlerts',
@description = 'Account for Automated DBA Notifications',
@email_address = 'sqlagenttest@gmail.com',
@replyto_address = 'sqlagenttest@gmail.com',
@display_name = 'SQL Agent',
@mailserver_name = 'smtp.gmail.com',
@port = 587,
@enable_ssl = 1,
@username = 'sqlagenttest@gmail.com',
@password = '<password>'
GO

-- Create default profile
EXECUTE msdb.dbo.sysmail_add_profile_sp
@profile_name = 'default',
@description = 'Profile for sending Automated DBA Notifications'
GO

-- Let anyone send mail 
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
@profile_name = 'default',
@principal_name = 'public',
@is_default = 1 ;

-- Add account to profile
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'default',  
    @account_name = 'SQLAlerts',  
    @sequence_number = 1 ; 


-- Send test email
EXECUTE msdb.dbo.sp_send_dbmail
@profile_name = 'default',
@recipients = 'meetbhagdev@gmail.com',
@Subject = 'Testing DBMail',
@Body = 'This message is a test for DBMail'
GO


//set db mail profile using mssql-conf
sudo /opt/mssql/bin/mssql-conf set sqlagent.databasemailprofile default

-- Set up an operator for SQLAgent job notifications
EXEC msdb.dbo.sp_add_operator
@name=N'JobAdmins', 
@enabled=1,
@email_address=N'meetbhagdev@gmail.com', 
@category_name=N'[Uncategorized]'
GO

-- Send email when 'Agent Test Job’ succeeds
EXEC msdb.dbo.sp_update_job
@job_name='Agent Test Job',
@notify_level_email=1,
@notify_email_operator_name=N'JobAdmins'
GO
