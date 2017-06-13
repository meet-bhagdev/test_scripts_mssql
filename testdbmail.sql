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
