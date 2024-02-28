<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="getAuditsFromSchedule" datasource="Corporate" blockfactor="100">
SELECT StartDate, EndDate, xGUID, Year_, ID
FROM Corporate.AuditSchedule
WHERE
Year_ = 2014
AND AuditedBy = 'IQA'
AND (Status IS NULL OR status = 'Deleted')
ORDER BY xGUID
</cfquery>

<cfset variables.totalWorkingDays = 0>

<cfoutput query="getAuditsFromSchedule">
	<cfset variables.totalWorkingDays = 0>

	<cfif len(startDate) AND len(endDate)>
		<cfloop from="#startdate#" to="#enddate#" index="i">
		<!--- excludes saturday and sunday --->
		    <cfif dayOfWeek(i) GTE 2 AND dayOfWeek(i) LTE 6>
		       <cfset variables.totalWorkingDays = variables.totalWorkingDays + 1>
		    </cfif>
		</cfloop>

		#Year_#-#ID# (#xGUID#) #variables.totalWorkingdays#<br>

		<cfquery name="getAuditDays" datasource="Corporate" blockfactor="100">
		SELECT xGUID, Year_, ID, lastYear
		FROM Corporate.AuditSchedule
		WHERE lastYear = #xGUID#
		</cfquery>

		<cfif getAuditDays.recordCount GT 0>
			#getauditDays.Year_#-#getauditDays.ID# xGUID - #getauditDays.xGUID# lastYear = #getAuditDays.LastYear#<Br>
			#startDate# #endDate#<br><br>

			<CFQUERY BLOCKFACTOR="100" NAME="InsertAudits" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			UPDATE UL06046.AuditSchedule_Planning
			SET AuditDays = #variables.totalWorkingDays#
			WHERE xGUID = #getAuditDays.xGUID#
			</CFQUERY>
		<Cfelse>
			No Audit - Do nothing<br><br>
		</cfif>
	<Cfelse>
		#Year_#-#ID# (#xGUID#)<br>
		No Dates Listed<br><br>
	</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->