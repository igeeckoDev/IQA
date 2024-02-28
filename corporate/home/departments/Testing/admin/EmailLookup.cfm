<!---
<HEAD>
<SCRIPT LANGUAGE="JavaScript">
<!-- Original:  Pankaj Mittal (pankajm@writeme.com) -->
<!-- Web Site:  http://www.fortunecity.com/lavendar/lavender/21 -->

<!-- This script and many more are available free online at -->
<!-- The JavaScript Source!! http://javascript.internet.com -->

<!-- Begin
function small_window(myurl) {
var newWindow;
var props = 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=300,height=200';
newWindow = window.open(myurl, "Add_from_Src_to_Dest", props);
}
// Adds the list of selected items selected in the child
// window to its list. It is called by child window to do so.  
function addToParentList(sourceList) {
destinationList = window.document.forms[0].parentList;
for(var count = destinationList.options.length - 1; count >= 0; count--) {
destinationList.options[count] = null;
}
for(var i = 0; i < sourceList.options.length; i++) {
if (sourceList.options[i] != null)
destinationList.options[i] = new Option(sourceList.options[i].text, sourceList.options[i].value );
   }
}
// Marks all the items as selected for the submit button.  
function selectList(sourceList) {
sourceList = window.document.forms[0].parentList;
for(var i = 0; i < sourceList.options.length; i++) {
if (sourceList.options[i] != null)
sourceList.options[i].selected = true;
}
return true;
}

// Deletes the selected items of supplied list.
function deleteSelectedItemsFromList(sourceList) {
var maxCnt = sourceList.options.length;
for(var i = maxCnt - 1; i >= 0; i--) {
if ((sourceList.options[i] != null) && (sourceList.options[i].selected == true)) {
sourceList.options[i] = null;
      }
   }
}
//  End -->
</script>
</HEAD>
--->

<cfoutput>
	<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<div class="Blog-Title">
Email Address Verification
</div><br>

<cfif isDefined("Form.LastName")>
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE UPPER(last_name) LIKE UPPER('#form.lastname#%')
    <cfif len(form.firstname)>
        AND (Upper(first_n_middle) LIKE UPPER('#form.firstname#%')
        OR Upper(preferred_name) LIKE UPPER('#form.firstname#%'))
    </cfif>
    ORDER BY First_n_middle
	</CFQUERY>
    
<cfoutput query="NameLookup">
<div class="Blog-Content">
Name: #last_name#, #first_n_middle# <cfif len(preferred_name)>(#preferred_name#)</cfif><br>
Email: #employee_email#<br>
</div>
</cfoutput>

<div class="Blog-Content">
<a href="EmailLookup.cfm">Search Again</a>
</div>

<cfelse>
<table>
<tr>
<td class="blog-content">
	<cfform name="EmailLookup" action="#CGI.SCRIPT_NAME#" method="post">

	First Name: (Optional)<Br>
	<cfinput size="40" name="FirstName" required="no" type="text"><br>
    * - Note - Refine the search by entering the first letter of the first name for common last names.<br /><br>

	Last Name: (Required)<Br>
	<cfinput size="40" name="LastName" required="yes" Message="Please Enter Last Name" type="text"><br><br>
	
	<input type="submit" value="Submit">
	</cfform>
	
* Please be patient after submitting the search. Results may take 5-10 seconds to appear. Common last names may take 30-60 seconds.
</td>
</tr>
</table>
</cfif>