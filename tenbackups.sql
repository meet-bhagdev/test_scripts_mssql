 CREATE DATABASE DB1
 GO
  
 USE DB1
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO

USE [msdb]
GO
EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB1', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB1', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB1', @step_name=N'BackupDB1', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB1] TO  DISK = N''C:\var\opt\mssql\data\DB1Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB1'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB1', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO

 CREATE DATABASE DB2
 GO
  
 USE DB2
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO

EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB2', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB2', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB2', @step_name=N'BackupDB2', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB2] TO  DISK = N''C:\var\opt\mssql\data\DB2Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB2'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB2', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO

 CREATE DATABASE DB3
 GO
  
 USE DB3
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO

EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB3', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB3', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB3', @step_name=N'BackupDB3', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB3] TO  DISK = N''C:\var\opt\mssql\data\DB3Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB3'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB3', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO
 CREATE DATABASE DB4
 GO
  
 USE DB4
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO

EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB4', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB4', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB4', @step_name=N'BackupDB4', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB4] TO  DISK = N''C:\var\opt\mssql\data\DB4Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB4'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB4', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO
 CREATE DATABASE DB5
 GO
  
 USE DB5
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO

EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB5', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB5', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB5', @step_name=N'BackupDB5', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB5] TO  DISK = N''C:\var\opt\mssql\data\DB5Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB5'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB5', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO

 CREATE DATABASE DB6
 GO
  
 USE DB6
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO

EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB6', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB6', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB6', @step_name=N'BackupDB6', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB6] TO  DISK = N''C:\var\opt\mssql\data\DB6Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB6'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB6', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO
 CREATE DATABASE DB7
 GO
  
 USE DB7
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO

EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB7', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB7', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB7', @step_name=N'BackupDB7', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB7] TO  DISK = N''C:\var\opt\mssql\data\DB7Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB7'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB7', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO
 CREATE DATABASE DB8
 GO
  
 USE DB8
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO

EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB8', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB8', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB8', @step_name=N'BackupDB8', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB8] TO  DISK = N''C:\var\opt\mssql\data\DB8Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB8'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB8', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO
 CREATE DATABASE DB9
 GO
  
 USE DB9
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO

EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB9', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB9', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB9', @step_name=N'BackupDB9', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB9] TO  DISK = N''C:\var\opt\mssql\data\DB9Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB9'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB9', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO
 CREATE DATABASE DB10
 GO
  
 USE DB10
 GO
 -- Create a table 
 CREATE TABLE TestData(id int)
 GO
  
 -- Insert sample data
 INSERT INTO TestData(id) VALUES(1)
 INSERT INTO TestData(id) VALUES(2)
 GO


EXEC  msdb.dbo.sp_add_job @job_name=N'BackupDB10', @enabled=1, @notify_level_eventlog=0, @notify_level_email=2, @notify_level_netsend=2, 
		@notify_level_page=2, @delete_level=0, @category_name=N'[Uncategorized (Local)]', @owner_login_name=N'sa'
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'BackupDB10', @server_name = N'VMENN-HEL'
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'BackupDB10', @step_name=N'BackupDB10', @step_id=1, @cmdexec_success_code=0, 
		@on_success_action=1, @on_fail_action=2, @retry_attempts=0, @retry_interval=0, @os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE [DB10] TO  DISK = N''C:\var\opt\mssql\data\DB10Backup.bak'' WITH FORMAT, INIT,  MEDIANAME = N''BackupDB10'',  NAME = N''Northwind-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10',
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_update_job @job_name=N'BackupDB10', @enabled=1, @start_step_id=1, @notify_level_eventlog=0, @notify_level_email=2, 
		@notify_level_netsend=2, @notify_level_page=2, @delete_level=0, @description=N'', @category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @notify_email_operator_name=N'', @notify_netsend_operator_name=N'', @notify_page_operator_name=N''
GO
