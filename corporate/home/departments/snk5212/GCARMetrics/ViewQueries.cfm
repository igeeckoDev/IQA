<cfif isDefined("URL.EmpNo")>
	<cfset Form.EmpNo = "#URL.EmpNo#">
</cfif>

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Saved Reports">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>CAR Administrator Reports</b><br>
FAQ 36 - <a href="qManagementChain.cfm">Exclude from Management Escalation Chain Report</a><br>
Observations - Root Cause Category - <a href="qObservations_RootCauseCategory.cfm">View Report</a><br><br>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Saved" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM GCAR_Metrics_SavedQueries
WHERE ID <> 0
<cfif Form.EmpNo neq "All">
AND EmpID = '#Form.EmpNo#'
</cfif>
ORDER BY DateSaved DESC
</CFQUERY>

<cfoutput>
<u>Employee ID</u>: #Form.EmpNo#<br><br>
</cfoutput>

<cfif Saved.RecordCount eq 0>

	<cfif Form.EmpNo neq "All">
		There are no saved reports for <cfoutput>#form.EmpNo#.</cfoutput>
	<cfelse>
		There are no saved reports.
	</cfif><br><Br>

<cfelse>
<table border="1" style="border-collapse: collapse;">
<tr align="center">
	<cfif Form.EmpNo eq "All">
	<th>Employee ID</td>
	</cfif>
	<th>Report Name</td>
	<th>Date Saved</td>
	<th>View Report</td>
</tr>
<cfoutput query="Saved">
<tr class="blog-content" align="center">
	<cfif Form.EmpNo eq "All">
	<td>#EmpID#</td>
	</cfif>
	<td align="left">#Title#</td>
	<td>#dateformat(DateSaved, "mmmm dd, yyyy")#</td>
	<td align="center"><a href="#PageName#?#QueryString#"><img src="#SiteDir#SiteImages/table_row.png" align="absmiddle" border="0"></a></td>
</tr>
</cfoutput>
</table>
</cfif>

<!--- #dateformat(DateSaved, "mm/dd/yyyy")# #timeformat(DateSaved, "hh:mm:ss tt")# --->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->