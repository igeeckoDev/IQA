<cfif NOT isDefined("URL.Year")>
	<cfset url.year = #curyear#>
	<cfset year = #curyear#>
</cfif>

<!--- The superlocation for Ise/Tokyo has changed for 2012: prior to this (2011 and before), the superlocation ID was 16 and the locations included were ise/tokyo/yokohama. for 2012+, the superlocation id is 102 and the locations included are ise/tokyo. This is an issue in the code below, see line 1015 for 'fix' --->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="#url.year# OSHA SNAP Coverage">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
Select Year:
<cfloop index="i" from="2010" to="#nextYear#">
	<cfif i eq url.year>
    	<b>#i#</b>
    <cfelse>
    	<cfif i lte 2012>
			<a href="DAP_SNAP_Coverage.cfm?Year=#i#">[ #i# ]</a>
		<cfelseif i eq curyear>
        	<a href="DAP_SNAP_Coverage2013_currentYear.cfm?Year=#i#">[ #i# ]</a>
		<cfelseif i GT 2012>
			<a href="DAP_SNAP_Coverage2013.cfm?Year=#i#">[ #i# ]</a>
        </cfif>
	</cfif>
</cfloop><br /><br />

<!--- get current month to set audit assignments variable "Half" for link below --->
<cfif curMonth LTE 6>
	<cfset Half = 1>
<cfelseif curMonth GTE 7>
	<cfset Half = 2>
</cfif>

<a href="DAP_SNAP_Audits.cfm?Year=#URL.Year#&Half=#Half#">Manage/View</a> OSHA SNAP Audit Assignments<br />
<a href="DAP_SNAP_Data.cfm?Year=#URL.Year#">View</a> OSHA SNAP Data - CARs, SR's, etc<br>
<a href="SNAP.cfm">View</a> OSHA SNAP Matrix<br /><br />

<b>Legend</b><br>
<img src="#IQADir#/images/red.jpg" border="0"> - Audit Cancelled<br>
<img src="#IQADir#/images/yellow.jpg" border="0"> - OSHA SNAP Records Not Entered<br>
<img src="#IQADir#/images/green.jpg" border="0"> - OSHA SNAP Records Complete<br>
<img src="#IQADir#/images/blue.jpg" border="0"> - OSHA SNAP Records Entered, not Complete<br><br>

1. Click on Green Status [<img src="#IQADir#/images/green.jpg" border="0">] below to view OSHA SNAP Records for a specific Site<br>
2. DAP 1 (in Jan-June column) and DAP 2 (in July-Dec column) indicate that OSHA SNAP records were gathered via Desk Audit.<br><br>

<!---
<u>Note for 2016 SNAP Audits</u><br>
For the follwing sites:<br>
 - UL International-Singapore Private Limited (Solaris South Tower)<br>
 - UL Japan, Inc. Shonan<br><br>

There was no UL Mark Project activity in 2015, therefore no SNAP Audit will be conducted in 2016. There are staff with active Technical Competencies
at these sites. IQA will check quarterly to verify that no UL Mark Project activity is being conducted. If UL Mark Project activity occurs, a SNAP
audit will be added to the schedule.<br>--->

</cfoutput>

<!--- query to obtain the DAP 1 and DAP 2 audits for the current year --->
<CFQUERY BLOCKFACTOR="100" name="DAPAudit1" Datasource="Corporate">
SELECT ID, Year_, Month
FROM AuditSchedule
WHERE Area = 'SNAP/Data Acceptance Program (1)'
AND Year_ = #url.year#
</CFQUERY>

<!--- query to obtain the DAP 1 and DAP 2 audits for the current year --->
<CFQUERY BLOCKFACTOR="100" name="DAPAudit2" Datasource="Corporate">
SELECT ID, Year_, Month
FROM AuditSchedule
WHERE Area = 'SNAP/Data Acceptance Program (2)'
AND Year_ = #url.year#
</CFQUERY>

<!--- set variable for audit ID --->
<cfoutput query="DAPAudit1">
	<cfset IDDAP1 = #ID#>
</cfoutput>

<!--- set variable for audit ID --->
<cfoutput query="DAPAudit2">
	<cfset IDDAP2 = #ID#>
</cfoutput>

<!--- current year only??? --->
<!--- select ACTIVE and PHYSICAL (not corporate, global, field services, etc) Sites, not including Super Locations --->
<CFQUERY BLOCKFACTOR="100" name="Locations" Datasource="Corporate">
SELECT OfficeName as Office, ID as OfficeID
FROM IQAtblOffices
WHERE Exist = 'Yes'
ORDER BY OfficeName
</cfquery>

<br>
<!--- create the table --->
<table border=1 style="border-collapse: collapse;">
<!--- define the rows in the table header --->
<tr class="blog-title" align="center" valign="top">
	<td align="center">Office Name</td>
	<td align="center">Audit Number</td>
	<td align="center">Area</td>
	<td colspan="2" align="center">Jan-June</td><!--- DAP Audit 1 --->
	<td colspan="2" align="center">July-Dec</td><!--- DAP Audit 2 --->
</tr>

<!--- ouput the Locations Query - we are going to run queries INSIDE this output to find multiple audits and check for super location audits, etc, as defined below --->
<cfoutput query="Locations">
	<!--- Look for Active or Cancelled (deleted) 'Processes' and 'Processes and Labs' audits for this Location --->
	<CFQUERY BLOCKFACTOR="100" name="Audits" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT Corporate.AuditSchedule.Year_, Corporate.AuditSchedule.ID, Corporate.AuditSchedule.AuditArea, Corporate.AuditSchedule.Area, Corporate.AuditSchedule.LeadAuditor, Corporate.AuditSchedule.Month,
	Corporate.AuditSchedule.OfficeName, Corporate.AuditSchedule.Status, Corporate.AuditSchedule.RescheduleNextYear, UL06046.xSNAPData.AuditOfficeNameID

	FROM Corporate.AuditSchedule, UL06046.xSNAPData, Corporate.IQAtblOffices

	WHERE UL06046.xSNAPData.AuditOfficeNameID = Corporate.IQAtblOffices.ID
	AND Corporate.AuditSchedule.OfficeName = Corporate.IQATblOffices.OfficeName
	AND Corporate.AuditSchedule.OfficeName = '#Office#'
	AND Corporate.AuditSchedule.Year_ = #url.year#
	AND  UL06046.xSNAPData.AuditYear = #url.year#
	AND Corporate.AuditSchedule.AuditedBy = 'IQA'
	AND Corporate.AuditSchedule.AuditType2 = 'Local Function'
	AND (Corporate.AuditSchedule.Status IS NULL OR Corporate.AuditSchedule.Status = 'Deleted')
	AND (Corporate.AuditSchedule.Area = 'Processes' OR Corporate.AuditSchedule.Area = 'Processes and Labs')

	GROUP BY UL06046.xSNAPData.AuditOfficeNameID, Corporate.AuditSchedule.Year_, Corporate.AuditSchedule.ID, Corporate.AuditSchedule.AuditArea, Corporate.AuditSchedule.Area, Corporate.AuditSchedule.LeadAuditor, Corporate.AuditSchedule.Month,
	Corporate.AuditSchedule.OfficeName, Corporate.AuditSchedule.Status, Corporate.AuditSchedule.RescheduleNextYear
	</CFQUERY>

<!--- If There is ONE audit returned in the Audits query for the location --->
<cfif Audits.Recordcount GT 0>
<cfloop query="Audits">
<tr class="blog-content" align="left" valign="top">
	<!--- Output Office Name, the audit, and the area --->
	<td>#Locations.Office#</td>
	<td><a href="auditdetails.cfm?Year=#Year_#&ID=#ID#">#Year_#-#ID#</a></td>
	<td>#Area#</td>
	<!--- output here if the audit is January-June --->
	<cfif Month lte 6>
		<!--- Handle cancelled/deleted audits here. status=deleted is a CANCELLED AUDIT--->
        <!--- also handle rescheduled for next year audits --->

		<!--- Show Month of Scheduled Audit. --->
		<td align="center">
			#MonthAsString(Month)#
		</td>
		<!--- Check the status of SNAP Data for this audit --->
		<td align="center">
			<!--- check to see if the SNAP Data for this audit is complete/finalized/entered --->
			<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #ID#
			AND AuditYear = #Year_#
			AND AuditOfficeNameID = #Locations.OfficeID#
			AND Status = 'Complete'
			</cfquery>

			<!--- see if its entered, if it isn't complete --->
			<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #ID#
			AND AuditYear = #Year_#
			AND AuditOfficeNameID = #Locations.OfficeID#
			</cfquery>

			<cfif Year_ gte 2011>
				<cfset RecordQuantity = 9>
			<cfelseif Year_ eq 2010>
                <cfif Month gte 9>
                    <cfset RecordQuantity = 8>
                <cfelseif Month lt 9>
                    <cfset RecordQuantity = 7>
                </cfif>
            </CFIF>

			<!--- if all seven records are entered and flagged complete. link provided to review data --->
			<cfif Complete.RecordCount EQ RecordQuantity>
            	<A href="DAP_SNAP_Review.cfm?ID=#ID#&Year=#Year_#&OfficeID=#Locations.OfficeID#">
					<img src="#IQARootDir#/images/green.jpg" border="0">
				</A>
			<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered. link provided to review what has been entered so far --->
			<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
				<A href="DAP_SNAP_Review.cfm?ID=#ID#&Year=#Year_#&OfficeID=#Locations.OfficeID#">
					<img src="#IQARootDir#/images/blue.jpg" border="0">
				</A>
			<!--- no records have been entered. auditor handles entering this. --->
			<cfelseif Entered.RecordCount EQ 0>
				<img src="#IQARootDir#/images/yellow.jpg" border="0">
			</cfif>
		</td>

	<!--- if the audit is in the second half of the year -
	check for DAP audit #1 records for the first half of the year --->
	<cfelseif Month gt 6>
	<td colspan="2" align="center">
		<!--- check to see if the SNAP Data for DAP 1 for this office is complete/finalized --->
		<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Status FROM xSNAPDATA
		WHERE AuditID = #IDDAP1#
		AND AuditYear = #url.year#
		AND AuditOfficeNameID = #Locations.OfficeID#
		AND Status = 'Complete'
		</cfquery>

		<!--- see if its entered, if it isn't complete (for DAP 1) --->
		<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Status FROM xSNAPDATA
		WHERE AuditID = #IDDAP1#
		AND AuditYear = #url.year#
		AND AuditOfficeNameID = #Locations.OfficeID#
		</cfquery>

		<cfif url.year gte 2011>
            <cfset RecordQuantity = 9>
        <cfelseif url.year eq 2010>
            <cfset RecordQuantity = 7>
        </CFIF>

        <!--- if all seven records are entered and flagged complete. link provided to review data --->
		<cfif Complete.RecordCount EQ RecordQuantity>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#Locations.OfficeID#">
				DAP 1: <img src="#IQARootDir#/images/green.jpg" border="0">
			</A>
		<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered. link provided to review what has been entered so far --->
		<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#Locations.OfficeID#">
				DAP 1: <img src="#IQARootDir#/images/blue.jpg" border="0">
			</A>
		<!--- no records have been entered. link provided to enter data since this is DAP 1 and not a Site Audit --->
		<cfelseif Entered.RecordCount EQ 0>
			<cfif Status eq "deleted" OR RescheduleNextYear eq "Yes">
            	<img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                <a href="AuditDetails.cfm?ID=#ID#&Year=#Year_#">View Notes</a>
            <cfelse>
            	<a href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#Locations.OfficeID#">DAP 1: Add</a>
			</cfif>
		</cfif>
	</td>
	<!--- END OF January-June Check --->
	</cfif>
	<!--- output here if the audit is July-December --->
	<cfif Month gt 6>
		<!--- Show Month of Scheduled Audit --->
		<td align="center">
			#MonthAsString(Month)#
		</td>
		<!--- Check the status of SNAP Data for this audit --->
		<td align="center">
			<!--- check to see if the SNAP Data for this audit is complete/finalized/entered --->
			<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #Audits.ID#
			AND AuditYear = #Audits.Year_#
			AND AuditOfficeNameID = #Locations.OfficeID#
			AND Status = 'Complete'
			</cfquery>

			<!--- see if its entered, if it isn't complete --->
			<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #ID#
			AND AuditYear = #Year_#
			AND AuditOfficeNameID = #Locations.OfficeID#
			</cfquery>

			<cfif Year_ gte 2011>
                <cfset RecordQuantity = 9>
            <cfelseif Year_ eq 2010>
                <cfif Month gte 9>
                    <cfset RecordQuantity = 8>
                <cfelseif Month lt 9>
                    <cfset RecordQuantity = 7>
                </cfif>
            </CFIF>

			<!--- if all seven records are entered and flagged complete. link provided to review data --->
			<cfif Complete.RecordCount EQ RecordQuantity>
				<A href="DAP_SNAP_Review.cfm?ID=#ID#&Year=#url.year#&OfficeID=#Locations.OfficeID#">
					<img src="#IQARootDir#/images/green.jpg" border="0">
				</A>
			<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered.
				link provided to review what has been entered so far --->
			<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
				<A href="DAP_SNAP_Review.cfm?ID=#ID#&Year=#url.year#&OfficeID=#Locations.OfficeID#">
					<img src="#IQARootDir#/images/blue.jpg" border="0">
				</A>
			<!--- no records have been entered. link provided to enter data
				since this is DAP 1 and not a Site Audit --->
			<cfelseif Entered.RecordCount EQ 0>
				<img src="#IQARootDir#/images/yellow.jpg" border="0">
			</cfif>
		</td>

	<!--- if the audit is in the first half of the year -
	check for DAP audit #2 records for the second half of the year --->
	<cfelseif Month lte 6>
	<td colspan="2" align="center">
		<!--- check to see if the SNAP Data for DAP 2 for this office is completed/finalized/entered --->
		<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Status FROM xSNAPDATA
		WHERE AuditID = #IDDAP2#
		AND AuditYear = #url.year#
		AND AuditOfficeNameID = #Locations.OfficeID#
		AND Status = 'Complete'
		</CFQUERY>

		<!--- see if its enetered, if it isn't complete (for DAP 2) --->
		<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Status FROM xSNAPDATA
		WHERE AuditID = #IDDAP2#
		AND AuditYear = #url.year#
		AND AuditOfficeNameID = #Locations.OfficeID#
		</CFQUERY>

		<cfif url.year gte 2011>
            <cfset RecordQuantity = 9>
        <cfelseif url.year eq 2010>
            <cfset RecordQuantity = 8>
        </CFIF>

		<!--- if all seven records are entered and flagged complete --->
		<!--- link provided to review data --->
		<cfif Complete.RecordCount EQ RecordQuantity>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#Locations.OfficeID#">
				DAP 2: <img src="#IQARootDir#/images/green.jpg" border="0">
			</A>
		<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered --->
		<!--- link provided to review what has been entered so far --->
		<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#Locations.OfficeID#">
				DAP 2: <img src="#IQARootDir#/images/blue.jpg" border="0">
			</A>
		<!--- no records have been entered. auditor handles entering this --->
		<cfelseif Entered.RecordCount EQ 0>
			<cfif Audits.Status eq "deleted" OR Audits.RescheduleNextYear eq "Yes">
            	<img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                <a href="AuditDetails.cfm?ID=#ID#&Year=#Year_#">View Notes</a>
            <cfelse>
            	<a href="DAP_SNAP_Add.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#Locations.OfficeID#">DAP 2: Add</a>
			</cfif>
		</cfif>
	</td>
	</cfif>
</tr>
</cfloop>
</cfif>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->