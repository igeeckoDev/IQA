<cfif NOT isDefined("URL.Year")>
	<cfset URL.Year = curYear>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Data Acceptance Program (DAP) Audit Schedule - #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfinclude template="#IQADir#cfscript_queryStringRemoveItem.cfm">
<cfset qs = cgi.query_string>

<b>View Year</b>
<cfoutput>
	<cfloop from=2015 to=#nextYear# index=i>
		 - <a href="#CGI.ScriptName#?Year=#i#">#i#</a>&nbsp;
	</cfloop><br><Br>

<!---
<b>Export Audit Schedule</b><br>
<a href="DAPAudit_ExportToExcel.cfm?Year=#URL.Year#">Export</a> #URL.Year# Audit Schedule to Excel<br><br>
--->
</cfoutput>

<cfoutput>
<cfset newURL = queryStringDeleteVar("Month", qs)>

<b>Month</b>: <cfif isDefined("URL.Month")><b>#monthAsString(url.Month)#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
<SELECT NAME="MonthJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Month Below
	<option value="javascript:document.location.reload();">
		<cfloop index="i" from="1" to="12">
			<OPTION VALUE="#CGI.ScriptName#?#newURL#&Month=#i#">#MonthAsString(i)#</OPTION>
		</cfloop>
</SELECT><br><br>

<cfset newURL = queryStringDeleteVar("AuditType2", qs)>

<b>Audit Type</b>: <cfif isDefined("URL.AuditType2")><b>#URL.AuditType2#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Audit Type Below
	<option value="javascript:document.location.reload();">

	<Option value="#CGI.ScriptName#?#newURL#">:: View All Audit Types</Option>
	<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Annual">Annual</Option>
	<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Gap Assessment">Gap Assessment</Option>
	<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Initial">Initial</Option>
	<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Scope Expansion">Scope Expansion</Option>
</select><br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
SELECT *
FROM AuditorList
WHERE (Status = 'Active' OR Status = 'In Training')
AND DAPAuditor = 'Yes'
ORDER BY Auditor
</CFQUERY>

<Cfoutput>
<cfset newURL = queryStringDeleteVar("Auditor", qs)>

<b>Auditor</b>: <cfif isDefined("URL.Auditor")><b>#URL.Auditor#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
</Cfoutput>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Auditor Below
	<option value="javascript:document.location.reload();">
	<cfoutput>
		<Option value="#CGI.ScriptName#?#newURl#">:: View All Auditors</Option>
	</cfoutput>
	<cfoutput query="Auditor">
		<Option value="#CGI.ScriptName#?#newURl#&Auditor=#Auditor#">#Auditor#</Option>
	</cfoutput>
</select><br><br>

<CFQUERY BLOCKFACTOR="100" name="Regions" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DISTINCT REGION
FROM DAPClient
WHERE 1 = 1
<cfif isDefined("URL.Status")>
	AND Status = '#URL.Status#'
</cfif>
ORDER BY Region
</cfquery>

<Cfoutput>
<cfset newURL = queryStringDeleteVar("Region", qs)>

<b>Region</b>: <cfif isDefined("URL.Region")><b>#URL.Region#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
</Cfoutput>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Office Below
	<option value="javascript:document.location.reload();">
	<cfoutput>
		<Option value="#CGI.ScriptName#?#newURl#">:: View All Regions</Option>
	</cfoutput>
	<cfoutput query="Regions">
		<Option value="#CGI.ScriptName#?#newURl#&Region=#Region#">#Region#</Option>
	</cfoutput>
</select><br><br>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#" NAME="viewAudits">
	SELECT
		DAP_AuditSchedule.*,
		DAPClient.ID as clientID, DAPClient.ClientName, DAPClient.AnniversaryDate, DAPClient.DAFileNumber, DAPClient.Region

	FROM
		DAP_AuditSchedule, DAPClient

	WHERE
		DAP_AuditSchedule.Year_ = #URL.Year#
		AND (DAP_AuditSchedule.Status IS NULL OR DAP_AuditSchedule.Status = 'Deleted')
		<cfif isDefined("URL.Auditor")>
			AND DAP_AuditSchedule.LeadAuditor = '#URL.Auditor#'
		</cfif>
		<cfif isDefined("URL.Region")>
			AND DAPClient.Region = '#URL.Region#'
		</cfif>
		<cfif isDefined("URL.AuditType2")>
			AND DAP_AuditSchedule.AuditType2 = '#URL.AuditType2#'
		</cfif>
		<cfif isDefined("Month")>
			AND DAP_AuditSchedule.Month = #URL.Month#
		</cfif>
		AND DAP_AuditSchedule.DAPClient_ID = DAPClient.ID

	ORDER BY
		Month, ClientName
</cfquery>

<cfset MonthHolder="">

<table border="1" width="1000" style="border-collapse: collapse;">
	<tr>
		<th>Audit Number</th>
		<th>Month / Audit Dates</th>
		<th>Audit Type</th>
		<th>Client Name</th>
		<th>Auditor</th>
		<th>Anniversary Date</th>
		<th>Actions</th>
	</tr>

	<cfset i = 1>

	<cfoutput query="viewAudits">

	<cfif MonthHolder IS NOT Month>
	<tr>
		<th colspan="7" align="left">#MonthAsString(Month)#</th>
	</tr>
	</cfif>

	<tr valign="top">
		<td>
			<A href="DAPAudit_Details.cfm?rowID=#xGUID#">#Year_#-#ID#-DAP</a>
		</td>
		<td>
			<cfif NOT len(StartDate) AND NOT len(EndDate)>#MonthAsString(Month)#<br><br></cfif>

			<!--- uses incDates.cfc --->
			<cfinvoke
				component="IQA.Components.incDates"
			    returnvariable="DateOutput"
			    method="incDates">

				<cfif len(StartDate)>
			        <cfinvokeargument name="StartDate" value="#StartDate#">
			    <cfelse>
			        <cfinvokeargument name="StartDate" value="">
			    </cfif>

				<cfif len(EndDate)>
			        <cfinvokeargument name="EndDate" value="#EndDate#">
			    <cfelse>
			        <cfinvokeargument name="EndDate" value="">
			    </cfif>

			    <cfinvokeargument name="Status" value="#Status#">
			    <cfinvokeargument name="RescheduleNextYear" value="No">
			</cfinvoke>

			<!--- output of incDates.cfc --->
			#DateOutput#
			<br /><br />

			<!--- only show for active audits --->
			<cfif NOT len(Status)>
				<u>Audit Days</u>:<br>
				<cfif len(AuditDays)>
					#AuditDays#
				<cfelse>
					None Listed
				</cfif>
			</cfif>
		</td>
		<td>#AuditType2#</td>
		<td>#ClientName#</td>
		<td><u>Auditor</u><br>- #LeadAuditor#</td>
		<td>#dateformat(AnniversaryDate, "mm/dd/yyyy")#</td>
		<td width="150">
			<!---
			<CFIF SESSION.Auth.accesslevel is "SU"
				 OR SESSION.Auth.UserName is "Ziemnick"
				 OR SESSION.Auth.UserName is "Aoyagi"
				 OR SESSION.Auth.Name eq viewAudits.LeadAuditor>
				:: <a href="DAPAudit_Edit.cfm?rowID=#xGUID#">Edit</a><br>
			</cfif>
			---->

			:: <A href="DAPAudit_Details.cfm?rowID=#xGUID#">Audit Details</a><br>

			<!---
			:: <a href="#IQADir#AuditHistory.cfm?xGUID=#xGUID#">Audit History</a><br><br>
			--->

			<cfset RescheduleNextYear = "No">
			<cfset Report = "">

			<!--- Status --->
			<br>
			<cfinclude template="#IQADir#status_colors_AS.cfm"><Br><br>

			<cfif len(Notes)><u>Notes</u>:<br>#Notes#</cfif>
		</td>
	</tr>

	<cfset MonthHolder = Month>
	</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->