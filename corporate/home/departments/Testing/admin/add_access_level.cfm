<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
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
<script language="JavaScript">
function validateForm()
{
	// check name
	 if (document.Audit.accesslevel.value == ""){
		alert ("Please enter a new access level.");
		return false;
	 }

	return true;
}
</script>

Table Contents:<br>
<CFOUTPUT query="Query2">
#accesslevel#<br>
</CFOUTPUT>

<br><br>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="addnew_access_level.cfm" onSubmit="return validateForm();">

<INPUT TYPE="TEXT" NAME="accesslevel" VALUE=""><br><br>

<INPUT TYPE="Submit" value="Submit Update">
</FORM>

</body>
</html>
