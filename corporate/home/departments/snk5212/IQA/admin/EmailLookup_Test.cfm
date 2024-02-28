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
	ORDER BY First_n_middle
	</CFQUERY>
    
    <cfset i = 1>
    <div class="Blog-Content">
    <form 
    	action="SendEmail.cfm"
        method="post" 
        name="uploadnew"
        target="doUpLoadProc" 
        onsubmit="setTimeout('self.close()',500)">
        
        <cfoutput query="NameLookup">
        Name: #last_name#, #first_n_middle#<br>
        Email: #employee_email# <input name="Send#url.ID#" value="#employee_email#" type="checkbox" /><br>
        <cfset i = i+1>
        </cfoutput>
        
	    <input name="submit" type="submit" value="submit">
    </form>
    </div>
    
    <div class="Blog-Content">
    <a href="EmailLookup.cfm">Search Again</a>
    </div>

<cfelse>
<table>
<tr>
<td class="blog-content">
	<cfform name="EmailLookup" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post">

	Last Name:<Br>
	<cfinput size="40" name="LastName" required="yes" Message="Please Enter Last Name" type="text"><br><br>
	
	<input type="submit" value="Submit">
	</cfform>
	
* Please be patient after submitting the search. Results may take 5-10 to appear.
</td>
</tr>
</table>
</cfif>