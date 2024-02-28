<cfoutput>
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<div class="Blog-Title">
<b>Email Address Lookup</b>
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
        Name: #first_n_middle# <cfif len(preferred_name)>(#preferred_name#)</cfif> #last_name#<br>
        Email: #employee_email#<br> 
        Select: <input name="SQM" value="#employee_email#" type="checkbox" />
        <br><br />
        <cfset i = i+1>
        </cfoutput>
        
	    <input name="Select" type="submit" value="Select Employee">
    </form>
    </div><br />
    
    <div class="Blog-Content">
    <cfoutput>
	    <a href="TechnicalAudits_EmailLookup.cfm?#CGI.QUERY_STRING#">Search Again</a>
    </cfoutput>
    </div>

<cfelse>
<table>
<tr>
<td class="blog-content">  
	<cfform name="EmailLookup" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post">

	First Name: (Optional)<Br>
	<cfinput size="40" name="FirstName" required="no" type="text"><br>
    * - Note - Refine the search by entering the first letter of the first name for common last names.<br /><br>

	Last Name: (Required)<Br>
	<cfinput size="40" name="LastName" required="yes" Message="Please Enter Last Name" type="text"><br><br>
	
	<input type="submit" value="Find Email Address">
	</cfform>
	
* Please be patient after submitting the search. Results may take 5-10 to appear.
</td>
</tr>
</table>
</cfif>