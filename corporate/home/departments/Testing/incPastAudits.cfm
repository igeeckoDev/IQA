<!--- Last Year's Audit --->
<cfif len(Plan.lastYear)>
	<cfquery name="AuditInfo" datasource="Corporate" blockfactor="100">
	SELECT
		Year_, ID, Month, xGUID
	FROM
		AuditSchedule
	WHERE
		xGUID = #Plan.lastYear#
	</cfquery>

	<b>Audit History</b><br>
	<cfoutput query="AuditInfo">
		<cfif Plan.Year_ GTE 2006>
			<u>Previous Audit</u> - <a href="auditDetails.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#-IQA</a> (#MonthAsString(Month)#)<br>
		</cfif>
	<u>Full Audit History</u> - <a href="#IQADir#AuditHistory.cfm?xGUID=#Plan.xGUID#">View</a> Full Audit History<br><br>
	</cfoutput>
</cfif>

<!---
<!--- Past Audits --->
<b>Audit History</b><br />
<cfquery name="AuditInfo" datasource="Corporate" blockfactor="100">
SELECT
	Area, AuditType2, OfficeName, AuditArea, Month, ID
FROM
	AuditSchedule
WHERE
    Year_ = #url.year#
    AND ID = #url.ID#
</cfquery>

<Cfoutput query="AuditInfo">
    <cfquery name="check" datasource="Corporate" blockfactor="100">
    SELECT Month, ID, Year_, LeadAuditor, RescheduleNextYear, AuditArea, Area, AuditType2
    FROM AuditSchedule
    WHERE AuditedBy = 'IQA'
    AND (Status IS NULL OR Status = 'Deleted')
    AND Area = '#Area#'
    AND AuditType2 = '#AuditType2#'
    AND OfficeName = '#OfficeName#'
    <!---AND AuditArea = '#AuditArea#'--->
    AND Approved = 'Yes'
    AND Year_ < #url.year#
    ORDER BY Year_ DESC, Month
    </cfquery>

    <cfif check.RecordCount GT 0>
        <cfloop query="check">
            <a href="auditDetails.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#-IQA</a> (#MonthAsString(Month)#)
            <cfif auditType2 eq "Local Function">
				<cfif Area neq "Processes" AND Area neq "Processes and Labs">
                    #AuditArea#
                </cfif>
			</cfif>
            <cfif RescheduleNextYear eq "Yes"> <cfset nextYear = #year_# + 1>(Rescheduled for #nextYear#)</cfif><br />
        </cfloop><br />
	<cfelse>
    	No Audits Found<Br /><br />
    </cfif>
</Cfoutput>

<!--- Future Audits --->
<b>Current and Future Audits Scheduled</b><br />
<Cfoutput query="AuditInfo">
    <cfquery name="checkFuture" datasource="Corporate" blockfactor="100">
    SELECT Month, ID, Year_, LeadAuditor, RescheduleNextYear, AuditArea, Area, AuditType2
    FROM AuditSchedule
    WHERE AuditedBy = 'IQA'
    AND (Status IS NULL OR Status = 'Deleted')
    AND Area = '#Area#'
    AND AuditType2 = '#AuditType2#'
    AND OfficeName = '#OfficeName#'
    <!---AND AuditArea = '#AuditArea#'--->
	AND Approved = 'Yes'
    AND Year_ >= #url.year#
    ORDER BY Year_, Month
    </cfquery>

    <cfif checkFuture.RecordCount GT 0>
        <cfloop query="checkFuture">
        	<cfif Year_ eq #URL.Year#>
            	<cfif ID NEQ #URL.ID#>
                    <a href="auditDetails.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#-IQA</a> (#MonthAsString(Month)#)
					<cfif auditType2 eq "Local Function">
                        <cfif Area neq "Processes" AND Area neq "Processes and Labs">
                            #AuditArea#
                        </cfif>
                    </cfif>
                    <cfif RescheduleNextYear eq "Yes"> <cfset nextYear = #year_# + 1>(Rescheduled for #nextYear#)</cfif><br />
				</cfif>
			<cfelse>
                <a href="auditDetails.cfm?ID=#ID#&Year=#Year_#">#Year_#-#ID#-IQA</a> (#MonthAsString(Month)#)
				<cfif auditType2 eq "Local Function">
                    <cfif Area neq "Processes" AND Area neq "Processes and Labs">
                        #AuditArea#
                    </cfif>
                </cfif>
                <cfif RescheduleNextYear eq "Yes"> <cfset nextYear = #year_# + 1>(Rescheduled for #nextYear#)</cfif><br />
            </cfif>
        </cfloop><br />
	<cfelse>
    	No Audits Found<Br /><br />
    </cfif>
</Cfoutput>
--->