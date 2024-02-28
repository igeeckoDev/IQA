<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - View Audits Simple (FOR TESTING)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY Name="Audits" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
From 
	TechnicalAudits_AuditSchedule
WHERE 
	AuditType2 = '#URL.Type#'
    AND Year_ = #URl.Year#
    AND Status IS NULL
ORDER 
	BY Year_, Month, ID
</CFQUERY>

<cfoutput>
Currently Viewing: <b>#url.Year# #URL.Type#</b> Technical Audits<br />
Switch Audit Type: 
	<cfif url.Type eq "Full">
        [Full] [<A href="TechnicalAudits_viewAudits.cfm?Year=#URL.Year#&Type=In-Process">In-Process</A>]
    <cfelseif url.Type eq "In-Process">
        [<A href="TechnicalAudits_viewAudits.cfm?Year=#URL.Year#&Type=Full">Full</A>] [In-Process]
    <cfelse>
        [<A href="TechnicalAudits_viewAudits.cfm?Year=#URL.Year#&Type=Full">Full</A>] [<A href="TechnicalAudits_viewAudits.cfm?Year=#URL.Year#&Type=In-Process">In-Process</A>]
    </cfif><br /><br />
    
Select Year:<br>
<SELECT NAME="YearJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Year Below
		<option value="javascript:document.location.reload();">
<cfloop index="i" to="2015" from="2011">
		<OPTION VALUE="#CGI.SCRIPT_NAME#?&type=#URL.TYPE#&year=#i#">#i#
</cfloop>
</SELECT><br /><br />

</cfoutput>

<cfset YearHolder = "">
<cfset MonthHolder = "">
<cfset AuditID = "">

<cfif Audits.Recordcount GT 0>

<table border="1" width="800">
<tr valign="top">
	<th>Audit Identifier</th>
    <th>Project Number</th>
    <th>Region</th>
    <th>Site</th>
    <th>Industry</th>
    <th>Audit Details Status</th>
    <th>Audit Type</th>
    <th>Request Type</th>
    <th>Audit Due Date</th>
    <th>Current Step</th>
    <th>View History</th>
</tr>

<cfoutput query="Audits">
	<cfif Audits.currentRow MOD 10 eq 0>
    <tr valign="top">
        <th>Audit Identifier</th>
        <th>Project Number</th>
        <th>Region</th>
        <th>Site</th>
        <th>Industry</th>
        <th>Audit Details Status</th>
        <th>Audit Type</th>
        <th>Request Type</th>
        <th>Audit Due Date</th>
        <th>Current Step</th>
        <th>View History</th>
    </tr>
	</cfif>

<cfif URL.Type eq "Full">
	<cfset showMonth = "Quarter #Month#">
	<cfset columnLabel = "Quarter">
<cfelseif URL.Type eq "In-Process">
	<cfset showMonth = "#MonthAsString(Month)#">
    <cfset columnLabel = "Month">
</cfif>

<cfif NOT len(YearHolder) OR YearHolder eq Year_>
    <cfif NOT len(MonthHolder) OR MonthHolder NEQ Month>
    <tr>
        <td colspan="11">
            <b>#showMonth#</b>
        </td>
    </tr>
    </cfif>
</cfif>

<!--- build audit identifier --->
<cfif len(Auditor) AND len(AuditorManager)>
    <cfif AuditType2 eq "Full">
        <cfset AuditTypeID = "F">
    <cfelse>
        <cfset AuditTypeID = "P">
    </cfif>

    <cfif RequestType eq "Test">
    	<cfset RequestTypeID = "T">
    <cfelse>
    	<cfset RequestTypeID = "N">
    </cfif>

	<cfset AuditorLoc = #right(AuditorDept, 3)#>

    <cfset ReviewLoc = #right(ProjectHandlerDept, 3)#>

    <cfset AuditID = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#">
</cfif>

<tr valign="top">
<td>
<cfif len(AuditID)>
	<a href="TechnicalAudits_AuditDetails.cfm?ID=#ID#&Year=#Year_#">#AuditID#</a>
<cfelse>
	<a href="TechnicalAudits_AuditDetails.cfm?ID=#ID#&Year=#Year_#">#year_#-#ID#</a> [Incomplete]
</cfif>
</td>

<td><cfif len(ProjectNumber)>#ProjectNumber#<cfelse>N/A</cfif></td>
<td>#Region#</td>
<td>#OfficeName#</td>
<td>#Industry#</td>
<td><cfif Approved eq "Yes">Audit Details Completed<cfelse><font class="warning">Audit Details Incomplete</font></cfif></td>
<td>#AuditType2#</td>
<td>#RequestType#</td>
<td><cfif len(AuditDueDate)>#dateformat(AuditDueDate, "mm/dd/yyyy")#<cfelse>N/A</cfif></td>
<td>#Flag_CurrentStep#</td>
<td><a href="TechnicalAudits_AuditDetails_viewHistory.cfm?ID=#ID#&Year=#Year_#">View History</a></td>
</tr>

<cfset YearHolder = Year_>
<cfset MonthHolder = Month>
<cfset AuditID = "">
</cfoutput>
</table><br />

<u>Note</u>: [Incomplete] indicates some audit information has not yet been provided.<br /><br /> 

<cfelse>
	No Audits Found<br /><br />
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->