<cffile 
	action="copy" 
	source="#request.applicationFolder#\Corpdb\iqa\IQADB.mdb"
	destination="#request.applicationFolder#\corporate\home\departments\snk5212\BackupDB\IQA\IQADB.mdb" >

<cffile 
	action="rename" 
	source="#request.applicationFolder#\corporate\home\departments\snk5212\BackupDB\IQA\IQADB.mdb"
	destination="#request.applicationFolder#\corporate\home\departments\snk5212\BackupDB\IQA\IQADB_#Month#_#Day#_#Year#_AM.mdb" >
	
<cflog application="no" 
	file="iqaBackups" 
	text="Back up file #request.applicationFolder#\corporate\home\departments\snk5212\BackupDB\IQA\IQADB_#Month#_#Day#_#Year#_AM.mdb created" 
	type="Information">