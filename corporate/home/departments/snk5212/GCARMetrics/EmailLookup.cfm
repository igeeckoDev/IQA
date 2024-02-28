<cfoutput>
	<link href="cr_style.css" rel="stylesheet" media="screen">
</cfoutput>

<div class="Blog-Title">
<b>Email Address Lookup</b>
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
    
    <cfoutput>
    <form 
    	action="#url.PageName#?#cgi.QUERY_STRING#"
        method="post" 
        name="uploadnew"
        target="doUpLoadProc" 
        onsubmit="setTimeout('self.close()',500)">
	</cfoutput>    

        <cfoutput query="NameLookup">
        Name: #first_n_middle# #last_name#<br>
        Email: #employee_email# 
        <input name="Owner" value="#employee_email#" type="checkbox" />
        <br><br />
        <cfset i = i+1>
        </cfoutput>
        
	    <input name="Select" type="submit" value="Save Owner">
    </form>
    </div><br />
    
    <div class="Blog-Content">
    <cfoutput>
	    <a href="EmailLookup.cfm?#CGI.QUERY_STRING#">Search Again</a>
    </cfoutput>
    </div>

<cfelse>
<table>
<tr>
<td class="blog-content">
	<cfform name="EmailLookup" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post">

	Last Name:<Br>
	<cfinput size="40" name="LastName" required="yes" Message="Please Enter Last Name - at least 3 characters" type="text"><br><br>
	
	<input type="submit" value="Find Email Address">
	</cfform><br /><br />
	
* Please be patient after submitting the search. Results may take 5-10 to appear.
</td>
</tr>
</table>
</cfif>