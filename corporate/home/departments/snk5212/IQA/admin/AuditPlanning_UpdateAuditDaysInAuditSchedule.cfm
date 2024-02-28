<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="getAuditsFromSchedule" datasource="Corporate" blockfactor="100">
SELECT StartDate, EndDate, xGUID, Year_, ID
FROM Corporate.AuditSchedule
WHERE Year_ >= 2012
AND AuditedBy = 'IQA'
AND (Status IS NULL)
AND (RescheduleStatus = 'No' OR RescheduleStatus IS NULL)
AND StartDate IS NOT NULL
AND EndDate IS NOT NULL
ORDER BY xGUID
</cfquery>

<cfset variables.totalWorkingDays = 0>

<cfoutput query="getAuditsFromSchedule">
	<cfset variables.totalWorkingDays = 0>

	<cfloop from="#startdate#" to="#enddate#" index="i">
	<!--- excludes saturday and sunday --->
	    <cfif dayOfWeek(i) GTE 2 AND dayOfWeek(i) LTE 6>
	       <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
	    </cfif>
	</cfloop>

	#Year_#-#ID# (#xGUID#)<br>
	Audit Days: #variables.totalWorkingdays#<br>
	#startDate#<br>
	#endDate#<br><br>

<!---
	<CFQUERY BLOCKFACTOR="100" NAME="InsertAudits" Datasource="Corporate">
	UPDATE AuditSchedule
	SET AuditDays = #variables.totalWorkingDays#
	WHERE xGUID = #xGUID#
	</CFQUERY>
--->
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->