<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Update Audit Contacts from Previous Year">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="getContacts" datasource="Corporate">
SELECT xGUID, ID, Year_, Email, Email2, lastYear
FROM AuditSchedule
WHERE Year_ = #URL.Year#
AND AuditedBy = 'IQA'
ORDER BY ID
</cfquery>

<cfoutput query="getContacts">
#Year_#-#ID# (#xGUID#)<br>
	<cfif len(lastYear)>
		<cfquery name="getLastYear" datasource="Corporate">
		SELECT xGUID, ID, Year_, Email, Email2
		FROM AuditSchedule
		WHERE xGUID = #lastYear#
		</cfquery>

		#getLastYear.Year_#-#getLastYear.ID# (#getLastYear.xGUID#)<br>
		#getLastYear.Email#<br>
		#getLastYear.Email2#<br><br>
		
		<!---
		<cfquery name="updateContacts" datasource="Corporate">
		UPDATE AuditSchedule
		SET
		
		Email = '#getLastYear.Email#',
		Email2 = '#getLastYear.Email2#'
		
		WHERE xGUID = #xGUID#
		</cfquery>
		--->
	<cfelse>
		No Previous Audit<br>
		Existing: #getContacts.Email#<Br>
		Existing: #getContacts.Email2#<Br><br>
	</cfif>	
</cfoutput>

If no errors are returned on this page, select the link below to complete the action:<Br>
<cfoutput>
	<a href="_AuditSchedule_UpdateContactsFromCompletedAuditYear_ConfirmAction.cfm?Year=#URL.Year#"><b>Confirm Contact Updates</b></a>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->