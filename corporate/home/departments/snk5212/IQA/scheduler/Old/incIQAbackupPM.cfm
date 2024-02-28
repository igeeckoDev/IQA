<cffile 
	action="copy" 
	source="d:\webserver\Corpdb\iqa\IQADB.mdb"
	destination="d:\webserver\corporate\home\departments\snk5212\BackupDB\IQA\IQADB.mdb" >

<cffile 
	action="rename" 
	source="d:\webserver\corporate\home\departments\snk5212\BackupDB\IQA\IQADB.mdb"
	destination="d:\webserver\corporate\home\departments\snk5212\BackupDB\IQA\IQADB_#Month#_#Day#_#Year#_PM.mdb" >
	
<cflog application="no" 
	file="iqaBackups" 
	text="Back up file d:\webserver\corporate\home\departments\snk5212\BackupDB\IQA\IQADB_#Month#_#Day#_#Year#_PM.mdb created" 
	type="Information">