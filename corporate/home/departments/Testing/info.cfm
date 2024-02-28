<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Information Request">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>

<script language="JavaScript">
function validateForm()
{
	// check name 
     if (document.NewInfo.Name.value == "") {
          alert("Please provide your name.");
          return false;
     } 
	 
	// check date
     if (document.NewInfo.Posted.value == "") {
          alert("Please provide the date.");
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

function ValidatePosted(){
	var dt=document.NewInfo.Posted
    if (dt.value != '') {
        if (isDate(dt.value)==false){
            dt.focus()
            return false
        }
    }    
    return true;
}
 
</script>			

<form name = "NewInfo" action = "info_submit.cfm" method = "post" onSubmit="return validateForm();">
						  
<b>Facilities Director & Regional Quality Managers,</b><br><br>

This notification is sent to request updates on facility changes and/or quality system impacting changes.  We would appreciate a response within 5 days. If you have any questions, please contact the Audit Program manager.<br><br>

<a href="info_output.cfm">View</a> past Information Request data.<br><br>

<b>Name:</b><br>
<SELECT NAME="Name">
	<OPTION Value="" SELECTED>	
	<OPTION VALUE="Werner Haab">Werner Haab			
	<OPTION VALUE="Volker Kotscha">Volker Kotscha
	<OPTION VALUE="Rod Morton">Rod Morton
	<OPTION VALUE="Debbie Modra">Debbie Modra		
	<OPTION VALUE="Keith Mowry">Keith Mowry
	<OPTION VALUE="Gunsimar Paintal">Gunsimar Paintal
	<OPTION VALUE="Martin Wang">Martin Wang
	<OPTION VALUE="Thomas Kestner">Thomas Kestner
	<OPTION VALUE="Gururaj R">Gururaj R
	<OPTION VALUE="KT Kim">KT Kim	
	<OPTION VALUE="Renata Carrazedo">Renata Carrazedo	
</SELECT><br><br>

Date: (mm/dd/yyyy)<br>
<input type="text" name="Posted" value=""><br><br>

<b>Facilities (and RQM's if info known):</b><br><br>
Are there any planned moves of facilities or lab areas this quarter?<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="Moves" Value="No Comments">No Comments</textarea><br><br>

Are there any new facilities being opened this quarter?<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="NewFacilities" Value="No Comments">No Comments</textarea><br><br>

<b>RQM's</b><br><br>
Are there any changes to your regions that may impact the Quality Management System? (eg. new functions added or deleted, major process changes, organizational changes, etc)<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="Changes" Value="No Comments">No Comments</textarea><br><br>

Are there any areas not yet scheduled that you recommend scheduling?<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="Scheduling" Value="No Comments">No Comments</textarea><br><br>

<INPUT TYPE="submit" VALUE="Send" class="textbox"></P>
</FORM>					  					  
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->