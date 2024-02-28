<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Auditor List - Assign Auditor - Request New Auditors - Search Results">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY NAME="QEmpLookup" datasource="OracleNet">
SELECT first_n_middle, last_name, preferred_name, employee_email, employee_number as EmpNo, Location_Code as Location, Department_Number as Department
FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
WHERE UPPER(last_name) LIKE UPPER('#form.last_name#%')
ORDER BY last_name, first_n_middle
</CFQUERY>

<cfif QEmpLookup.recordcount eq 1>
	<cfif len(QEmpLookup.preferred_name)>
		<cfset v_name = #QEmpLookup.preferred_name# & " " & #QEmpLookup.last_name# >
	<cfelse>
		<cfset v_name = #QEmpLookup.first_n_middle# & " " & #QEmpLookup.last_name# >
	</cfif>
	<cfset v_email = #QEmpLookup.employee_email#>
	<cfset Location = #QEmpLookup.Location#>
	<Cfset Department = #QEmpLookup.Department#>
    <cfset EmpNo = #QEmpLookup.Employee_Number#>
	<cfset qresult = 1>
<cfelseif QEmpLookup.recordcount gt 1>
	<cfset v_name = ''>
	<cfset v_email = ''>
	<cfset qresult = 2>
<cfelse>
  <cfset v_name = ''>
  <cfset v_email = ''>
  <cfset qresult = 0>
</cfif>

<cfif qresult eq 0>
	<cfoutput>
    There were no direct matches to Last Name = <b>#form.last_name#</b>.<br><br>
	<a href="TechnicalAudits_AssignAuditor_Request_Search.cfm?#CGI.Query_String#">Search</a> again.
    </cfoutput>
<cfelseif qresult eq 1>
	Results:<br>
	<cfoutput>
	- #v_name#, #Location#, #Department# <a href="TechnicalAudits_AssignAuditor_Request_Action.cfm?Auditor=#v_name#&EmpNo=#EmpNo#&Email=#v_Email#&Location=#Location#&Department=#Department#&#CGI.Query_String#">[select]</a><br>
	</cfoutput>
<cfelseif qresult eq 2>
	<table border="1" cellpadding="1">
	<tr>
	<td class="sched-title" width="200">Name</td>
	<td class="sched-title" width="250">Email</td>
	<td class="sched-title" width="150">Location</td>
	<td class="sched-title" width="100">&nbsp;</td>
	</tr>
	<cfoutput query="QEmpLookup">
	<tr>
	<td class="blog-content">#first_n_middle# #last_name#</td>
	<td class="blog-content">#employee_email#</td>
	<td class="blog-content">#location#<br />#Department#</td>
	<td class="blog-content"><a href="TechnicalAudits_AssignAuditor_Request_Action.cfm?Auditor=#v_name#&EmNo=#EmpNo#&Email=#v_Email#&Location=#Location#&Department=#Department#&#CGI.Query_String#">Add Auditor</a></td>
	</tr>
	</cfoutput>
	</table>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->