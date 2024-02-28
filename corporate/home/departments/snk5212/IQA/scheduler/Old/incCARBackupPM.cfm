<cffile 
	action="copy" 
	source="d:\webserver\Corpdb\CAR\CAR.mdb"
	destination="d:\webserver\corporate\home\departments\snk5212\BackupDB\CAR\CAR.mdb" >

<cffile 
	action="rename" 
	source="d:\webserver\corporate\home\departments\snk5212\BackupDB\CAR\CAR.mdb"
	destination="d:\webserver\corporate\home\departments\snk5212\BackupDB\CAR\CAR_#Month#_#Day#_#Year#_PM.mdb" >
	
<cflog application="no" 
	file="CARBackups" 
	text="Back up file d:\webserver\corporate\home\departments\snk5212\BackupDB\CAR\CAR_#Month#_#Day#_#Year#_PM.mdb created" 
	type="Information">