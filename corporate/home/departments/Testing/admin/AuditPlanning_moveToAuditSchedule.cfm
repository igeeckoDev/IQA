<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning Publish to Audit Schedule - #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<u>Instructions</u>: Scroll to the bottom of the page to check for errors. If there are zero errors, select the "Publish Schedule" link that will appear below the Error count. This checks the consistentcy of the Schedule and Planning Tables.<br><br>

<CFQUERY BLOCKFACTOR="100" name="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT xGUID, Year_, ID, AuditType2, OfficeName, Area, AuditArea, Month, Desk, SME, 
Status, CancelFile, BusinessUnit, AuditDays, LeadAuditor, Auditor, AuditorInTraining, NotesToLeadAuditor

FROM UL06046.AuditSchedule_Planning

WHERE Year_ = #URL.Year#
AND AuditedBY = 'IQA'

ORDER BY ID
</cfquery>

<cfoutput query="Audit">
	<u>Planning</u><br>
	xGUID = #xGUID#<br>
	#Year_#-#ID#<br /><Br>

	<cfquery name="check" datasource="Corporate">
	SELECT xGUID FROM AuditSchedule
	WHERE xGUID = #xGUID#
	</cfquery>

	<cfset Error = 0>

	<u>Schedule Check</u><br>
	<cfloop query="check">
		#xGUID#<br>
		<cfif xGUID eq Audit.xGUID>
			OK
			<cfset Error = Error>
		<cfelse>
			<font class="warning">NOT OK</font>
			<cfset Error = Error + 1>
		</cfif>
	</cfloop>
	<br><Br>
</cfoutput>

<cfoutput>
Errors: #Error#<br>
<cfif Error eq 0>
	<a href="AuditPlanning_moveToAuditSchedule_ConfirmAction.cfm?Year=#URL.Year#"><b>Publish Schedule</b></a>
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->