<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
INSERT INTO IQADB_ACCESS "ACCESS" (AccessLevel)
VALUES ('#FORM.AccessLevel#')
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT * From  IQADB_ACCESS  "ACCESS" 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
<link rel="stylesheet" type="text/css" href="http://#CGI.SERVER_NAME#/header/ulnetheader.css" />
</head>

<body>
<CFOUTPUT>
<b>#FORM.Accesslevel#</b> added to table.
</CFOUTPUT>
<br><br>

Table Contents:<br>
<CFOUTPUT query="Query2">
#accesslevel#<br>
</CFOUTPUT>


</body>
</html>
