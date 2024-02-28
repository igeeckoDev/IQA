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
		
		<cfquery name="updateContacts" datasource="Corporate">
		UPDATE AuditSchedule
		SET
		
		Email = '#getLastYear.Email#',
		Email2 = '#getLastYear.Email2#'
		
		WHERE xGUID = #xGUID#
		</cfquery>
	<cfelse>
		No Previous Audit<br>
		Existing: #getContacts.Email#<Br>
		Existing: #getContacts.Email2#<Br><br>
	</cfif>	
</cfoutput>

<a href="AuditPlanning.cfm?Year=#URL.Year#">Go to Planning to continue</a>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->