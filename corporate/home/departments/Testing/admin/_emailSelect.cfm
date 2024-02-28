<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600" maxrows="75">
SELECT employee_email 
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
ORDER BY Employee_Email
</CFQUERY>

<cfform name="InputTypeTextAutosuggestTest" method="post" action="#cgi.script_name#">
<b>Type Email Address</b><br />
Start typing the email address and select from the available options<Br>

<cfinput 
	name="Name" 
	type="text" 
	autosuggest="#ValueList(NameLookup.Employee_Email)#">
<br /><br />

<cfinput 
	name="SubmitName" 
	type="submit" 
	value="Submit">
</cfform>