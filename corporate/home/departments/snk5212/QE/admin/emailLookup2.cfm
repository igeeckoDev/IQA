<cfoutput>
	<link href="#REQUEST.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<div class="Blog-Title">
Email Address Verification
</div><br>

<cfset myArray = ArrayNew(1)>

<cfif isDefined("Form.LastName")>
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email 
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE UPPER(last_name) LIKE UPPER('#form.lastname#%')
	ORDER BY First_n_middle
	</CFQUERY>
    
<cfoutput query="NameLookup">
<div class="Blog-Content">
Name: #last_name#, #first_n_middle#<br>
Email: #employee_email#<br>
<!---<a href="EmailLookup_Add.cfm?email=#employee_email#">Add to List</a><br>--->
</div>
</cfoutput>

<div class="Blog-Content">
<a href="EmailLookup2.cfm">Search Again</a>
</div>

<cfelse>
<table>
<tr>
<td class="blog-content">
	<cfform name="EmailLookup" action="#CGI.SCRIPT_NAME#" method="post">

	Last Name:<Br>
	<cfinput size="40" name="LastName" required="yes" Message="Please Enter Last Name" type="text"><br><br>
	
	<input type="submit" value="Submit">
	</cfform>
	
* Please be patient after submitting the search. Results may take 5-10 to appear.
</td>
</tr>
</table>
</cfif>