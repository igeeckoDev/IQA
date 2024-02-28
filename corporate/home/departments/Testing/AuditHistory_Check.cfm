<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit History Check">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- get the audit details for the xGUID selected --->
<cfquery name="History" datasource="Corporate" blockfactor="100">
SELECT
	xGUID
FROM
	AuditSchedule
WHERE
	AuditedBy = 'IQA'
	AND Year_ = 2015
ORDER BY
	xGUID
</cfquery>

<cfloop query="History">
	<cfquery name="FindID" datasource="Corporate" blockfactor="100">
	SELECT
		Year_, ID, Status, Area, OfficeName, AuditArea, RescheduleNextYear, xGUID, lastYear
	FROM
		AuditSchedule
	WHERE
		xGUID = #xGUID#
	</cfquery>

	<cfoutput query="FindID">
		<hr><Br><br>
		<b>#xGUID#</b><br>
		<!--- Year #Year_# - rowID #xGUID# - ReferalID <cfif len(lastYear)>#lastYear#<cfelse>None</cfif><Br>--->
		<a href="auditdetails.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#-IQA</a><br>
		#OfficeName# - #Area#
		<cfif Area eq "Laboratories" AND Year_ LTE 2015>
			<br>#AuditArea#
		</cfif>
		<cfif RescheduleNextYear eq "Yes">
			<cfset RescheduleYear = #year_# + 1><Br>(Rescheduled for #RescheduleYear#)
		</cfif>
		<cfif Status is "deleted" OR Status is "Deleted">
			<br>Cancelled
		</cfif>
		<br><br>
	</cfoutput>

	<!--- loop through the audit schedule to find reference IDs (last year field) and identify the audits using the xGUID field --->
	<!--- the loop continues until there is no referring ID in a row --->
	<cfloop condition="len(findID.lastYear)">
		<cfquery name="findID" datasource="Corporate" blockfactor="100">
		SELECT
			Year_, ID, Status, Area, OfficeName, AuditArea, RescheduleNextYear, xGUID, lastYear
		FROM
			AuditSchedule
		WHERE
			xGUID = #FindID.lastYear#
		</cfquery>

		<cfoutput query="findID">
			<!--- Year #Year_# - rowID #xGUID# - ReferalID <cfif len(lastYear)>#lastYear#<cfelse>None</cfif><Br>--->
			<a href="auditdetails.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#-IQA</a><br>
			#OfficeName# - #Area#
			<cfif Area eq "Laboratories" AND Year_ LTE 2015>
				<br>#AuditArea#
			</cfif>
			<cfif RescheduleNextYear eq "Yes">
				<cfset RescheduleYear = #year_# + 1><Br>(Rescheduled for #RescheduleYear#)
			</cfif>
			<cfif Status is "deleted" OR Status is "Deleted">
				<br>Cancelled
			</cfif>
			<br><br>
		</cfoutput>
	</cfloop>
</cfloop>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->