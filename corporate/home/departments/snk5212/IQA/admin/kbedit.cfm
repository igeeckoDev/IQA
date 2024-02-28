<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KB">
SELECT * FROM KB
WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KBTopics">
SELECT * FROM KBTopics
ORDER BY KBTopics
</CFQUERY>

<!--- Start of Page File --->
<cfset subTitle = "Quality Engineering Knowledge Base - Edit Item">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<script language="JavaScript">
function validateForm()
{
	// check name
	 if (document.AddArticle.Posted.value == ""){
		alert ("Please enter the date posted.");
		return false;
	 }

     if (document.AddArticle.Author.value == "") {
          alert("Please provide the Author's name.");
          return false;
     }
 
     if (document.AddArticle.Subject.value == "") {
          alert("Please provide the subject.");
          return false;
     } 
	 
	 if (document.AddArticle.Details.value == "") {
          alert("Please provide the content of the article.");
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

function ValidateDate(){
	var dt=document.AddArticle.Posted
    if (dt.value != '') {
        if (isDate(dt.value)==false){
            dt.focus()
            return false
        }
    }    
    return true;
}

</script>					
						
<cfinclude template="KBMenu.cfm">				  
						  
<br><br>						  

<b>Knowledge Base - Add new Article</b>
<br><br>		
				  
<CFOUTPUT QUERY="KB">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddArticle" action="kbedit_update.cfm?ID=#ID#" onSubmit="return validateForm();">

Choose Main Topic:<br>
<SELECT NAME="KBTopics">
		<OPTION VALUE="#KBTopics#">#KBTopics#
</SELECT>
<br><br>

Author:<br>
#Author#
<input name="Author" type="hidden" value="#Author#">
<br><br>

Added By:<br>
#Added#
<input name="Author" type="hidden" value="#Added#">
<br><br>

Posted:<br>
<input name="Posted" type="Text" size="30" value="#Posted#" onChange="return ValidateDate()">
<br><br>

Subject:<br>
<input name="Subject" type="Text" size="70" value="#Subject#">
<br><br>

<cfset selValue = "#KB.CAR#">
CAR Process/Database Related?<br>
Yes <input type="radio" name="CAR" value="Yes" #iif(selValue eq 'Yes', de('Checked'), de(''))#>
No <input type="radio" name="CAR" value="No" #iif(selValue eq 'No', de('Checked'), de(''))#><br><br>

Details:<br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="Details" Value="">#Details#</textarea>
<br><br>

Attach a File:<br>
<input name="File" type="File" size="50">
<br><br>

Send Email Notification of Changes Made:<Br />
Yes <input type="radio" name="Notify" Value="Yes" checked="checked" /> No <input type="radio" name="Notify" Value="No" /><Br /><br />

<input name="submit" type="submit" value="Submit"> 
</form>
</CFOUTPUT>
						  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->