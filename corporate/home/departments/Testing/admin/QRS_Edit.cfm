<CFQUERY BLOCKFACTOR="100" NAME="Edit" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE ID = #URL.ID#
	AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Month" Datasource="Corporate">
	SELECT * FROM Month
	ORDER BY alphaID
</cfquery>

	<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
	SELECT * FROM IQAtblOffices
	WHERE Exist <> 'No'
	ORDER BY OfficeName
	</cfquery>
	
	<CFQUERY BLOCKFACTOR="100" NAME="QRSAuditor" Datasource="Corporate">
	SELECT * FROM QRSAuditor
	ORDER BY Auditor
	</cfquery>
	
<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>
		
		
<script language="JavaScript">
function validateForm()
{
	// check name

	 if (document.Audit.Scope.value == '') {
          alert("Please provide the DMS File Number.");
          return false;
     }	
 
	return true;
}

/**
 * DHTML date validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */
// Declaring valid date character, minimum year and maximum year
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strMonth=dtStr.substring(0,pos1)
	var strDay=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	var aCharExists = 0
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)

	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date")
		return false
	}
return true
}

function ValidateSDate(){
	var dt=document.Audit.StartDate
    if (dt.value != '') {
        if (isDate(dt.value)==false){
            dt.focus()
            return false
        }
    }    
    return true;
}
 
function ValidateEDate(){
	var dt=document.Audit.EndDate
    if (dt.value != '') {
        if (isDate(dt.value)==false){
            dt.focus()
            return false
        }
    }    
    return true;
}

</script>			

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>
</head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<!-- Begin UL Net Header -->
<cfoutput><SCRIPT language=JavaScript src="#Request.header#"></script></cfoutput>
<!-- End UL Net Header--> 
	
		<div align="left">
			<table width="756" border="0" cellpadding="0" cellspacing="0" bgcolor="#cecece" class="table-main">
			<tr>
			<td>
			<div align="center">
			<table class="table-main" width="675" border="0" cellspacing="0" cellpadding="0" bgcolor="#cecece">
				<tr>
					<td class="table-bookend-top">&nbsp;</td>
				</tr>
				<tr>
					<td class="table-masthead" align="right" valign="middle"><div align="center">&nbsp;</div></td>

				</tr>
				<tr>
					
              <td class="table-menu" valign="top"><div align="center">&nbsp;</div></td>
				</tr>
				<tr>

					
              <td height="925" class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td height="927" valign="top" class="content-column-left"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-date"><p align="center">Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  	<cfinclude template="adminmenu.cfm">
                          </td>
                          <td></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-title"><p align="left"><br>
                              Edit Audit - QRS</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
		
<cfoutput query="Edit">

			  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="QRS_edit_Submit.cfm?ID=#URL.ID#&Year=#Year#" onSubmit="return validateForm();">

Audit: #Year#-#ID#-QRS<br><br>

Type of Audit: #AuditType#<br>
<SELECT NAME="AuditType">
	<OPTION VALUE="#AuditType#" SELECTED>NoChanges
	<OPTION VALUE="Accreditation">Accreditation
	<OPTION VALUE="EMS">EMS
	<OPTION VALUE="QMS">QMS											
</SELECT>
<br><br>

Site being Audited: #OfficeName#<br>
<SELECT NAME="OfficeName">
		<OPTION VALUE="#OfficeName#" SELECTED>NoChanges
		<OPTION value="Field Services">Field Services
</cfoutput>		
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

<cfoutput query="Edit">
Auditor: #Auditor#<br>
<SELECT NAME="Auditor">
		<OPTION VALUE="#Auditor#">NoChanges
</cfoutput>
<CFOUTPUT QUERY="QRSAuditor">
		<OPTION VALUE="#Auditor#">#Auditor#
</CFOUTPUT>
</SELECT><br><br>

<cfoutput query="Edit">
Primary Contact(s): #Email#<br>
<INPUT TYPE="TEXT" NAME="Email" VALUE="#Email#" size="80"><br><br>

Start Date: #DateFormat(StartDate, 'mm/dd/yyyy')#<br>
End Date: #DateFormat(EndDate, 'mm/dd/yyyy')#<br><br>

Scope/Report<br>
DMS File Number: #Scope#<br>
<INPUT TYPE="Text" NAME="Scope" VALUE="#Scope#"><br><br>
</cfoutput>

<INPUT TYPE="Submit" value="Save and Continue">

</FORM>		
		  
 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

