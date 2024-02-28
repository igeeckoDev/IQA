<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
	SELECT OfficeName FROM IQAtbloffices
	ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Month" Datasource="Corporate">
	SELECT * FROM Month
	ORDER BY ID
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="AuditType" Datasource="Corporate">
	SELECT AuditType FROM AuditType
	WHERE AuditType <> 'SMT'
	ORDER BY AuditType
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
	SELECT Auditor, Status FROM AuditorList
	WHERE Status = 'Active'
	ORDER BY LastName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="ExternalLocation" Datasource="Corporate">
	SELECT ExternalLocation FROM ExternalLocation
	ORDER BY ExternalLocation
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="KP" Datasource="Corporate">
	SELECT KP FROM KP
	ORDER BY KP
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RD">
SELECT RD.ID, RD.KPID, RD.RDNumber, RD.RD, KP.KP, KP.ID FROM RD, KP
WHERE KP.ID = RD.KPID 
ORDER BY KP.KP, RD.RD
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Add Audit">
<cfinclude template="SOP.cfm">

<!--- / --->		
		
<script language="JavaScript">
function validateForm()
{
	// check name
	 if (document.Audit.Year.value == ""){
		alert ("Please enter a year.");
		return false;
	 }

     if (document.Audit.Month.value == '- None -') {
          alert("Please provide the month.");
          return false;
     }
 
     if (document.Audit.LeadAuditor.value == "") {
          alert("Please provide the lead auditor.");
          return false;
     } 
	 
	 if (document.Audit.AuditType.value == '- None -') {
          alert("Please provide the type of audit.");
          return false;
     } 

	 if (document.Audit.OfficeName.value == '- None -' & document.Audit.ExternalLocation.value == '- None -') {
          alert("Please provide a location.");
          return false;
     } 
 	
	 if (document.Audit.OfficeName.value !== '- None -' & document.Audit.ExternalLocation.value !== '- None -') {
          alert("Please provide only one location.");
          return false;
     } 	
	 
	 if (document.Audit.OfficeName.value !== '- None -' & document.Audit.AuditArea.value == "") {
          alert("Please provide an Audit Area for this internal audit.");
          return false;
     }	 
	 
	 if (document.Audit.ExternalLocation.value !== '- None -' & document.Audit.AuditArea.value !== "") {
          alert("Please do not type an Audit Area for a Third Party Audit.");
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

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.user_access_level is "SU" or SESSION.Auth.user_access_level is "Admin">	
						  
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="addnew.cfm" onSubmit="return validateForm();">

Audit Year: (required)<br>
<INPUT TYPE="TEXT" NAME="Year" VALUE=""><br><br>

Month Scheduled: (required)<br>
<SELECT NAME="Month">
		<OPTION value="- None -" SELECTED>- None -
<CFOUTPUT QUERY="Month">
		<OPTION VALUE="#ID#">#Month#
</CFOUTPUT>
</SELECT>
<br><br>

Lead Auditor: (required)<br>
<SELECT NAME="LeadAuditor">
		<OPTION value="- None -" SELECTED>- None -
<CFOUTPUT QUERY="Auditor">
		<OPTION VALUE="#Auditor#">#Auditor#
</CFOUTPUT>
</SELECT>
<br><br>

Auditor:<br>
<SELECT NAME="Auditor" multiple="multiple">
	<OPTION VALUE="- None -" SELECTED>- None -
<CFOUTPUT QUERY="Auditor">
		<OPTION VALUE="#Auditor#">#Auditor#
</CFOUTPUT>
</SELECT>
<br><br>

Type of Audit: (required)<br>
<SELECT NAME="AuditType" multiple="multiple">
		<OPTION value="- None -" SELECTED>- None -
<CFOUTPUT QUERY="AuditType">
		<OPTION VALUE="#AuditType#">#AuditType#
</CFOUTPUT>
</SELECT>

<br><br>
Location: (Internal) 
<br>
<SELECT NAME="OfficeName">
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT>
<br><br>

Area(s) to be Audited: (required for all internal audits)<br>
<INPUT TYPE="Text" NAME="AuditArea" size="75" VALUE=""><br><br>

Primary Contact (email addresses, internal audits only)<br>
- Audit notification will be sent to this person or persons (commas between the addresses)<br>
<INPUT TYPE="Text" NAME="Email" size="75" VALUE=""><br><br>

Location: (External) 
<br>
<SELECT NAME="ExternalLocation">
<CFOUTPUT QUERY="ExternalLocation">
		<OPTION VALUE="#ExternalLocation#">#ExternalLocation#
</CFOUTPUT>
</SELECT>
<br><br>

Key Processes:
<br>
<SELECT NAME="KP" multiple="multiple">
	<OPTION VALUE="- None -" SELECTED>- None -
<CFOUTPUT QUERY="KP">
		<OPTION VALUE="#KP#">#KP#
</CFOUTPUT>
</SELECT>
<br><br>

Reference Documents:
<br>

<cfset KPHolder = ""> 
<SELECT NAME="RD" multiple="multiple" size="8">
<option value="- None -" SELECTED>- None -
<option> 
<CFOUTPUT Query="RD"> 
<cfif KPHolder IS NOT KPID> 
<cfIf KPHolder is NOT "">
<option>
</cfif>
<option>#KP#
</cfif>
<OPTION VALUE="#RD#">&nbsp;&nbsp;- #RD# (#RDNumber#)
<cfset KPHolder = KPID> 
</CFOUTPUT>
</SELECT>
<br><br>

Scope:<br>
<textarea WRAP="PHYSICAL" ROWS="2" COLS="70" NAME="Scope" Value=""></textarea><br><br>
Notes:<br>
<textarea WRAP="PHYSICAL" ROWS="2" COLS="70" NAME="Notes" Value=""></textarea><br><br>

Start Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="StartDate" VALUE="" onChange="return ValidateSDate()"><br><br>
End Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="EndDate" VALUE="" onChange="return ValidateEDate()"><br><br>

<INPUT TYPE="Submit" value="Submit Update">

</FORM>			  
	


<CFELSE>	

Go away.

</CFIF>	
</cflock>					  
 <!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->

