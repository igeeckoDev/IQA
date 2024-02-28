<cfoutput>
<link href="#Request.CSS#" rel="stylesheet" media="screen">

<div class="Blog-Title">
<b>#URL.Role# - Employee Lookup</b>
</div><br>
</cfoutput>

<cfif isDefined("Form.Submit")>
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT first_n_middle, last_name, preferred_name, employee_email, department_number, location_code
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE 
	<cfif len(Form.EmployeeNumber)>
    	employee_number = '#form.EmployeeNumber#'
    <cfelse>
        UPPER(last_name) LIKE UPPER('#form.lastname#%')
		<cfif len(form.firstname)>
            AND (Upper(first_n_middle) LIKE UPPER('#form.firstname#%')
            OR Upper(preferred_name) LIKE UPPER('#form.firstname#%'))
	    </cfif>
    </cfif>
    ORDER BY First_n_middle
	</CFQUERY>
    
    <div class="Blog-Content">
	<cfoutput>
	<b>Search Terms</b><Br />
        <cfif len(Form.EmployeeNumber)>
            <u>Employee Number</u>: #Form.EmployeeNumber#<br />
        <cfelseif len(Form.LastName)>
            <u>Last Name</u>: #Form.LastName#<br />
            <cfif len(Form.FirstName)>
                <u>First Name/Preferred Name</u>: #Form.FirstName#<br />
            </cfif>        
        </cfif>
    </cfoutput>

    <cfif NameLookup.recordCount eq 0>
    	No Results Found<br />
    <cfelse>
    	<cfoutput>
	        #NameLookup.RecordCount# Record(s) Found
        </cfoutput><br /><Br />
    
    <cfset i = 1>
    
    <cfoutput>
    <form 
    	action="#url.PageName#?#cgi.QUERY_STRING#"
        method="post" 
        name="uploadnew"
        target="doUpLoadProc" 
        onsubmit="setTimeout('self.close()',500)">
        
        <input name="Role" value="#url.Role#" type="hidden" />
	</cfoutput>
    
        <cfoutput query="NameLookup">
        Name: #first_n_middle# <cfif len(preferred_name)>(#preferred_name#)</cfif> #last_name#<br>
        Email: #employee_email#<br>
        <u>Department Number</u>: #department_number#<br />
        <u>Location Code</u>: #Location_Code#<Br />
        
        <label for="box#i#">Select #URL.Role#</label>  
        <input name="Selection" id="box#i#" value="#first_n_middle# #last_name#!#Location_Code#!#Department_Number#!#Employee_Email#" type="radio" checked /> 
        
        <br><br />
        <cfset i = i+1>
        </cfoutput>
        
        <cfoutput>
	    <input name="Select" type="submit" value="Select #URL.Role#">
        </cfoutput>
    </form>
    <br />
    </cfif>
    </div>
    
    <div class="Blog-Content">
    <cfoutput>
	    <a href="#CGI.Script_name#?#CGI.QUERY_STRING#">Search Again</a>
    </cfoutput>
    </div>

<cfelse>

<script 
	type="text/javascript">
	function validateLookupForm()
	{
	var x=document.forms["EmailLookup"]["LastName"].value;
	var y=document.forms["EmailLookup"]["EmployeeNumber"].value;
	if ((x==null || x=="") && (y==null || y==""))
	  {
	  alert("Last Name OR Employee Number must be entered");
	  return false;
	  }
	}
</script>

<table>
<tr>
<td class="blog-content">
Please be patient after submitting the search. Results may take 5-10 to appear.<br /><br />

<cfoutput>
If the person is no longer employed, go <a href="TechnicalAudits_Roles_AddDetails.cfm?#CGI.QUERY_STRING#"><b>here</b></a>.<br /><br />
</cfoutput>

	<form name="EmailLookup" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post" onsubmit="return validateLookupForm()">
	First Name: (Optional)<Br>
	<input size="40" name="FirstName" type="text"><br>
    Refine the search by entering the <u>first letter of the first name for common last names</u>.<br /><br>

	Last Name: (Minimum three letters)<Br>
	<input size="40" name="LastName" type="text"><br><br>
    
    Employee Number: (All five digits required)<br />
	<input size="20" name="EmployeeNumber" maxlength="5" type="text"><br><br>

    Note - Last Name OR Employee Number required.<br /><Br />
    
    If both fields are filled out, the search will return results for nast name ONLY<br /><br />
    
	<input type="Submit" value="Submit" name="Submit">
	</form>	
</td>
</tr>
</table>
</cfif>