<cffile 
	action="copy" 
	source="#request.applicationFolder#\Corpdb\CAR\CAR.mdb"
	destination="#request.applicationFolder#\corporate\home\departments\snk5212\BackupDB\CAR\CAR.mdb" >

<cffile 
	action="rename" 
	source="#request.applicationFolder#\corporate\home\departments\snk5212\BackupDB\CAR\CAR.mdb"
	destination="#request.applicationFolder#\corporate\home\departments\snk5212\BackupDB\CAR\CAR_#Month#_#Day#_#Year#_AM.mdb" >
	
<cflog application="no" 
	file="CARBackups" 
	text="Back up file #request.applicationFolder#\corporate\home\departments\snk5212\BackupDB\CAR\CAR_#Month#_#Day#_#Year#_AM.mdb created" 
	type="Information">