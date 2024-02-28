<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Laboratory Technical Audit - Add Auditors - Search Results">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY NAME="QEmpLookup" datasource="OracleNet">
SELECT first_n_middle, last_name, preferred_name, employee_email, Location_Code
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
	<cfset Location = #QEmpLookup.Location_Code#>
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
	There were no direct matches to Last Name = <cfoutput><b>#form.last_name#</b></cfoutput>.<br><br>
	<a href="LTA_Auditors2.cfm">Search</a> again.	
<cfelseif qresult eq 1>
	Results:<br>
	<cfoutput>
	- #v_name#, #Location# (#v_email#) <a href="LTA_Auditors_Add.cfm?Auditor=#v_name#&Email=#v_Email#&Location=#Location#">[select]</a><br>
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
	<td class="blog-content">#location_code#</td>
	<td class="blog-content"><a href="LTA_Auditors_Add.cfm?Auditor=#first_n_middle# #last_name#&Email=#employee_email#&Location=#Location_code#">Add Auditor</a></td>
	</tr>
	</cfoutput>
	</table>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->