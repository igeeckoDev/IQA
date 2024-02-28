<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - View All Report Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM TechnicalAudits_ReportFiles
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
ORDER BY ID DESC
</cfquery>


<Table border="1">
<tr>
	<th align="center">Step</th>
    <th align="center">Date Posted</th>
    <th align="center">Posted By</th>
    <th align="center">Link to File</th>
</tr>

<cfset flagName = "">

<cfoutput query="getFile">
<cfif flagName neq Flag_CurrentStep>
<tr>
    <CFQUERY maxrows="1" BLOCKFACTOR="100" NAME="getLatest" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT *
    FROM TechnicalAudits_ReportFiles
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND Flag_CurrentStep = '#Flag_CurrentStep#'
    ORDER BY ID DESC
    </cfquery>
   
	<cfloop query="getLatest">
    <td>#Flag_CurrentStep#</td>
    <td>#Dateformat(DatePosted, "mm/dd/yyyy")#</td>
    <td>#PostedBy#</td>
    <td><A href="TechAuditReports/#AuditYear#-#AuditID#/#ReportFileName#">Link</A></td>
	</cfloop>
</tr>
    
<cfset flagName = "#Flag_CurrentStep#">
</cfif>
</cfoutput>
</Table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->