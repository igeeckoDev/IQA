<cfset Month = #Dateformat(now(), 'mm')#>
<cfset Day = #Dateformat(now(), 'dd')#>
<cfset Year = #Dateformat(now(), 'yyyy')#>

<cffile 
	action="copy" 
	source="d:\webserver\Corpdb\iqa\IQADB.mdb"
	destination="d:\webserver\corporate\home\departments\snk5212\BackupDB\IQADB.mdb" >

<cffile 
	action="rename" 
	source="d:\webserver\corporate\home\departments\snk5212\BackupDB\IQADB.mdb"
	destination="d:\webserver\corporate\home\departments\snk5212\BackupDB\IQADB_#Month#_#Day#_#Year#_Manual.mdb">

<cflog application="no" 
	file="iqaBackups" 
	text="Manual Backup - snk5212\BackupDB\IQADB_#Month#_#Day#_#Year#_Manual.mdb created" 
	type="Information">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
<link rel="stylesheet" type="text/css" href="http://#CGI.Server_Name#/header/ulnetheader.css" />
</head>

<body>
<cfoutput>
<p>Database Backed up.<br>
Back up file d:\webserver\corporate\home\departments\snk5212\iqa\BackupDB\IQADB_#Month#_#Day#_#Year#.mdb created.</p>
</cfoutput>
<br><br>

<p><a href="../BackupDB/directory_listing.cfm">View Database Archive</a></p>

</body>
</html>
