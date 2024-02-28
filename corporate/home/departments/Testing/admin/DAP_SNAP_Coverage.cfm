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

<b><a href="DAP_SNAP_Audits.cfm?Year=#URL.Year#&Half=#Half#">Manage/View</a></b> OSHA SNAP Audit Assignments<br />
<b><a href="DAP_SNAP_Data.cfm?Year=#URL.Year#">View</a></b> OSHA SNAP Data - CARs, SR's, etc<br><br />

<b>Legend</b><br>
<img src="#IQADir#/images/red.jpg" border="0"> - Audit Cancelled<br>
<img src="#IQADir#/images/yellow.jpg" border="0"> - OSHA SNAP Records Not Entered<br>
<img src="#IQADir#/images/green.jpg" border="0"> - OSHA SNAP Records Complete<br>
<img src="#IQADir#/images/blue.jpg" border="0"> - OSHA SNAP Records Entered, not Complete<br><br>

1. Click on Green Status [<img src="#IQADir#/images/green.jpg" border="0">] below to view OSHA SNAP Records for a specific Site<br>
2. DAP 1 (in Jan-June column) and DAP 2 (in July-Dec column) indicate that OSHA SNAP records were gathered via Desk Audit.<br>
</cfoutput>

<!--- query to obtain the DAP 1 and DAP 2 audits for the current year --->
<CFQUERY BLOCKFACTOR="100" name="DAPAudits" Datasource="Corporate">
SELECT ID, Year_, Month
FROM AuditSchedule
WHERE Area LIKE 'SNAP/Data Acceptance Program (%'
AND Year_ = #url.year#
</CFQUERY>

<!--- set variable for audit ID --->
<cfoutput query="DAPAudits">
	<cfif Month lte 6>
		<cfset IDDAP1 = #ID#>
	<cfelseif Month gt 6>
		<cfset IDDAP2 = #ID#>
	</cfif>
</cfoutput>

<!--- select ACTIVE and PHYSICAL (not corporate, global, field services, etc) Sites, not including Super Locations --->
<CFQUERY BLOCKFACTOR="100" name="Locations" Datasource="Corporate">
SELECT OfficeName, SuperLocationID, SuperLocation, ID
FROM IQAtblOffices
WHERE SuperLocation <> 'Yes'
AND Exist = 'Yes'
<cfif url.year gte 2012>
<!--- as of 2012, office no longer exists as it is part of UL International Germany GmbH --->
AND OfficeName <> 'UL International Germany GmbH PV Lab'
</cfif>
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
	<!--- Look for Active or Cancelled (Deleted) 'Processes' and 'Processes and Labs' audits for this Location --->
	<CFQUERY BLOCKFACTOR="100" name="Audits" Datasource="Corporate">
	SELECT Year_, ID, AuditArea, Area, LeadAuditor, Month, OfficeName, Status, RescheduleNextYear
	FROM AuditSchedule
	WHERE OfficeName = '#OfficeName#'
	AND Year_ = #url.year#
	AND AuditedBy = 'IQA'
	AND AuditType2 = 'Local Function'
	AND (Status IS NULL OR Status = 'Deleted')
	AND (Area = 'Processes' OR Area = 'Processes and Labs')
	</CFQUERY>

<!--- If There is ONE audit returned in the Audits query for the location --->
<cfif Audits.Recordcount EQ 1>
<tr class="blog-content" align="left" valign="top">
	<!--- Output Office Name, the audit, and the area --->
	<td>#OfficeName#</td>
	<td><a href="auditdetails.cfm?Year=#Audits.Year_#&ID=#Audits.ID#">#Audits.Year_#-#Audits.ID#</a></td>
	<td>#Audits.Area#</td>
	<!--- output here if the audit is January-June --->
	<cfif Audits.Month lte 6>
		<!--- Handle cancelled/Deleted audits here. status=Deleted is a CANCELLED AUDIT--->
        <!--- also handle rescheduled for next year audits --->
		<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
		<!--- Show link to show cancellation/reschedule notes if there is no audit January-June --->
		<td align="center">
			<!---DAP 1: <a href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">Add</a>--->
            <a href="AuditDetails.cfm?ID=#Audits.ID#&Year=#Audits.Year_#">View Notes</a>
		</td>
		<!--- display RED for the cancelled audit --->
		<td align="center">
			<img src="#IQARootDir#/images/red.jpg" border="0">
		</td>
		<!--- Handle Active audits here --->
		<cfelse>
		<!--- Show Month of Scheduled Audit. --->
		<td align="center">
			#MonthAsString(Audits.Month)#
		</td>
		<!--- Check the status of SNAP Data for this audit --->
		<td align="center">
			<!--- check to see if the SNAP Data for this audit is complete/finalized/entered --->
			<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #Audits.ID#
			AND AuditYear = #Audits.Year_#
			AND AuditOfficeNameID = #ID#
			AND Status = 'Complete'
			</cfquery>

			<!--- see if its entered, if it isn't complete --->
			<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #Audits.ID#
			AND AuditYear = #Audits.Year_#
			AND AuditOfficeNameID = #ID#
			</cfquery>

			<cfif Audits.Year_ gte 2011>
				<cfset RecordQuantity = 9>
			<cfelseif Audits.Year_ eq 2010>
                <cfif Audits.Month gte 9>
                    <cfset RecordQuantity = 8>
                <cfelseif Audits.Month lt 9>
                    <cfset RecordQuantity = 7>
                </cfif>
            </CFIF>

			<!--- if all seven records are entered and flagged complete. link provided to review data --->
			<cfif Complete.RecordCount EQ RecordQuantity>
            	<A href="DAP_SNAP_Review.cfm?ID=#Audits.ID#&Year=#Audits.Year_#&OfficeID=#ID#">
					<img src="#IQARootDir#/images/green.jpg" border="0">
				</A>
			<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered. link provided to review what has been entered so far --->
			<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
				<A href="DAP_SNAP_Review.cfm?ID=#Audits.ID#&Year=#Audits.Year_#&OfficeID=#ID#">
					<img src="#IQARootDir#/images/blue.jpg" border="0">
				</A>
			<!--- no records have been entered. auditor handles entering this. --->
			<cfelseif Entered.RecordCount EQ 0>
				<img src="#IQARootDir#/images/yellow.jpg" border="0">
			</cfif>
		</td>
		</cfif>
	<!--- if the audit is in the second half of the year -
	check for DAP audit #1 records for the first half of the year --->
	<cfelseif Audits.Month gt 6>
	<td colspan="2" align="center">
		<!--- check to see if the SNAP Data for DAP 1 for this office is complete/finalized --->
		<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Status FROM xSNAPDATA
		WHERE AuditID = #IDDAP1#
		AND AuditYear = #url.year#
		AND AuditOfficeNameID = #ID#
		AND Status = 'Complete'
		</cfquery>

		<!--- see if its entered, if it isn't complete (for DAP 1) --->
		<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Status FROM xSNAPDATA
		WHERE AuditID = #IDDAP1#
		AND AuditYear = #url.year#
		AND AuditOfficeNameID = #ID#
		</cfquery>

		<cfif url.year gte 2011>
            <cfset RecordQuantity = 9>
        <cfelseif url.year eq 2010>
            <cfset RecordQuantity = 7>
        </CFIF>

        <!--- if all seven records are entered and flagged complete. link provided to review data --->
		<cfif Complete.RecordCount EQ RecordQuantity>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">
				DAP 1: <img src="#IQARootDir#/images/green.jpg" border="0">
			</A>
		<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered. link provided to review what has been entered so far --->
		<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">
				DAP 1: <img src="#IQARootDir#/images/blue.jpg" border="0">
			</A>
		<!--- no records have been entered. link provided to enter data since this is DAP 1 and not a Site Audit --->
		<cfelseif Entered.RecordCount EQ 0>
			<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
            	<img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                <a href="AuditDetails.cfm?ID=#Audits.ID#&Year=#Audits.Year_#">View Notes</a>
            <cfelse>
            	<a href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">DAP 1: Add</a>
			</cfif>
		</cfif>
	</td>
	<!--- END OF January-June Check --->
	</cfif>
	<!--- output here if the audit is July-December --->
	<cfif Audits.Month gt 6>
		<!--- Handle cancelled/Deleted audits here. status=Deleted is a CANCELLED AUDIT--->
		<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
		<!--- show link to add SNAP Data if there is no audit July-December
	An audit SHOULD be added but in the event that it is not possible - we will show a cancellation notice for the audit --->
		<td align="center">
			<!---<a href="DAP_SNAP_Add.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">DAP 2: Add</a>--->
            <a href="AuditDetails.cfm?ID=#Audits.ID#&Year=#Audits.Year_#">View Notes</a>
		</td>
		<!--- display RED for the cancelled audit --->
		<td align="center">
			<img src="#IQARootDir#/images/red.jpg" border="0">
		</td>
		<!--- Handle Active audits here --->
		<cfelse>
		<!--- Show Month of Scheduled Audit --->
		<td align="center">
			#MonthAsString(Audits.Month)#
		</td>
		<!--- Check the status of SNAP Data for this audit --->
		<td align="center">
			<!--- check to see if the SNAP Data for this audit is complete/finalized/entered --->
			<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #Audits.ID#
			AND AuditYear = #Audits.Year_#
			AND AuditOfficeNameID = #ID#
			AND Status = 'Complete'
			</cfquery>

			<!--- see if its entered, if it isn't complete --->
			<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #Audits.ID#
			AND AuditYear = #Audits.Year_#
			AND AuditOfficeNameID = #ID#
			</cfquery>

			<cfif Audits.Year_ gte 2011>
                <cfset RecordQuantity = 9>
            <cfelseif Audits.Year_ eq 2010>
                <cfif Audits.Month gte 9>
                    <cfset RecordQuantity = 8>
                <cfelseif Audits.Month lt 9>
                    <cfset RecordQuantity = 7>
                </cfif>
            </CFIF>

			<!--- if all seven records are entered and flagged complete. link provided to review data --->
			<cfif Complete.RecordCount EQ RecordQuantity>
				<A href="DAP_SNAP_Review.cfm?ID=#Audits.ID#&Year=#url.year#&OfficeID=#ID#">
					<img src="#IQARootDir#/images/green.jpg" border="0">
				</A>
			<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered.
				link provided to review what has been entered so far --->
			<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
				<A href="DAP_SNAP_Review.cfm?ID=#Audits.ID#&Year=#url.year#&OfficeID=#ID#">
					<img src="#IQARootDir#/images/blue.jpg" border="0">
				</A>
			<!--- no records have been entered. link provided to enter data
				since this is DAP 1 and not a Site Audit --->
			<cfelseif Entered.RecordCount EQ 0>
				<img src="#IQARootDir#/images/yellow.jpg" border="0">
			</cfif>
		</td>
		</cfif>
	<!--- if the audit is in the first half of the year -
	check for DAP audit #2 records for the second half of the year --->
	<cfelseif Audits.Month lte 6>
	<td colspan="2" align="center">
		<!--- check to see if the SNAP Data for DAP 2 for this office is completed/finalized/entered --->
		<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Status FROM xSNAPDATA
		WHERE AuditID = #IDDAP2#
		AND AuditYear = #url.year#
		AND AuditOfficeNameID = #ID#
		AND Status = 'Complete'
		</CFQUERY>

		<!--- see if its enetered, if it isn't complete (for DAP 2) --->
		<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Status FROM xSNAPDATA
		WHERE AuditID = #IDDAP2#
		AND AuditYear = #url.year#
		AND AuditOfficeNameID = #ID#
		</CFQUERY>

		<cfif url.year gte 2011>
            <cfset RecordQuantity = 9>
        <cfelseif url.year eq 2010>
            <cfset RecordQuantity = 8>
        </CFIF>

		<!--- if all seven records are entered and flagged complete --->
		<!--- link provided to review data --->
		<cfif Complete.RecordCount EQ RecordQuantity>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">
				DAP 2: <img src="#IQARootDir#/images/green.jpg" border="0">
			</A>
		<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered --->
		<!--- link provided to review what has been entered so far --->
		<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">
				DAP 2: <img src="#IQARootDir#/images/blue.jpg" border="0">
			</A>
		<!--- no records have been entered. auditor handles entering this --->
		<cfelseif Entered.RecordCount EQ 0>
			<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
            	<img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                <a href="AuditDetails.cfm?ID=#Audits.ID#&Year=#Audits.Year_#">View Notes</a>
            <cfelse>
            	<a href="DAP_SNAP_Add.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">DAP 2: Add</a>
			</cfif>
		</cfif>
	</td>
	</cfif>
</tr>

<!--- If there is an audit for the location, check if this location is also included in a super location audit --->
<cfif SuperLocation EQ "No" AND Len(SuperLocationID)>
	<CFQUERY BLOCKFACTOR="100" name="SuperAudit" Datasource="Corporate">
	SELECT AuditSchedule.xGUID, AuditSchedule.Year_, AuditSchedule.ID, AuditSchedule.AuditArea, AuditSchedule.Area, AuditSchedule.LeadAuditor, AuditSchedule.Month, AuditSchedule.OfficeName, AuditSchedule.Status, AuditSchedule.RescheduleNextYear, IQAtblOffices.SuperLocationID
	FROM AuditSchedule, IQAtblOffices
	WHERE IQAtblOffices.ID = '#SuperLocationID#'
	AND IQAtblOffices.OfficeName = AuditSchedule.OfficeName
	AND AuditSchedule.Year_ = #url.year#
	AND AuditSchedule.AuditedBy = 'IQA'
	AND AuditSchedule.AuditType2 = 'Local Function'
	AND (AuditSchedule.Status IS NULL OR AuditSchedule.Status = 'Deleted')
	AND (AuditSchedule.Area = 'Processes' OR AuditSchedule.Area = 'Processes and Labs')
	</CFQUERY>

	<!--- if any audits are returned --->
	<cfif SuperAudit.RecordCount GT 0>
		<tr class="blog-content" align="left" valign="top">
			<!--- office name --->
			<td>#OfficeName#</td>
			<!--- audit number, link to audit details, and superaudit location --->
			<td colspan="2"><a href="auditdetails.cfm?Year=#SuperAudit.Year_#&ID=#SuperAudit.ID#">#SuperAudit.Year_#-#SuperAudit.ID#</a>: #SuperAudit.OfficeName#</td>

	<!--- output here if the audit is January-June --->
		<cfif SuperAudit.Month lte 6>
			<!--- Handle cancelled/Deleted audits here. status=Deleted is a CANCELLED AUDIT--->
			<cfif SuperAudit.Status eq "Deleted" OR SuperAudit.RescheduleNextYear eq "Yes">
			<!--- Show link to show cancellation notes if there is no audit January-June --->
			<td align="center">
				<!---DAP 1: <a href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">Add</a>--->
                <a href="AuditDetails.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#">View Notes</a>
			</td>
			<!--- display RED for the cancelled audit --->
			<td align="center">
				<img src="#IQARootDir#/images/red.jpg" border="0">
			</td>
			<!--- Handle Active audits here --->
			<cfelse>
			<!--- Show Month of Scheduled Audit. --->
			<td align="center">
				#MonthAsString(SuperAudit.Month)#
			</td>
			<td align="center">
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #SuperAudit.ID#
				AND AuditYear = #SuperAudit.Year_#
				AND AuditOfficeNameID = #ID#
				AND Status = 'Complete'
				</cfquery>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #SuperAudit.ID#
				AND AuditYear = #SuperAudit.Year_#
				AND AuditOfficeNameID = #ID#
				</cfquery>

				<cfif SuperAudit.Year_ gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif SuperAudit.Year_ eq 2010>
                    <cfif SuperAudit.Month gte 9>
                        <cfset RecordQuantity = 8>
                    <cfelseif SuperAudit.Month lt 9>
                        <cfset RecordQuantity = 7>
                    </cfif>
                </CFIF>

				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<cfelseif Entered.RecordCount EQ 0>
					<img src="#IQARootDir#/images/yellow.jpg" border="0">
				</cfif>
			</td>
			</cfif>
		<cfelseif SuperAudit.Month gt 6>
		<td colspan="2" align="center">
			<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #IDDAP1#
			AND AuditYear = #url.year#
			AND AuditOfficeNameID = #ID#
			AND Status = 'Complete'
			</CFQUERY>

			<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #IDDAP1#
			AND AuditYear = #url.year#
			AND AuditOfficeNameID = #ID#
			</CFQUERY>

			<cfif url.year gte 2011>
                <cfset RecordQuantity = 9>
            <cfelseif url.year eq 2010>
                <cfset RecordQuantity = 7>
            </CFIF>

			<!--- if all seven records are entered and flagged complete. link provided to review data --->
			<cfif Complete.RecordCount EQ RecordQuantity>
				<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">
					DAP 1: <img src="#IQARootDir#/images/green.jpg" border="0">
				</A>
			<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered.
				link provided to review what has been entered so far --->
			<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
				<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">
					DAP 1: <img src="#IQARootDir#/images/blue.jpg" border="0">
				</A>
			<!--- no records have been entered. link provided to enter data
				since this is DAP 1 and not a Site Audit --->
			<cfelseif Entered.RecordCount EQ 0>
				<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
                    <img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                    <a href="AuditDetails.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#">View Notes</a>
                <cfelse>
                    <a href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">DAP 1: Add</a>
                </cfif>
			</cfif>
		</td>
		</cfif>
		<cfif SuperAudit.Month gt 6>
		<cfif SuperAudit.Status eq "Deleted" OR SuperAudit.RescheduleNextYear eq "Yes">
		<td align="center">
			<a href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">DAP 1: Add</a>
		</td>
		<td align="center">
			<img src="#IQARootDir#/images/red.jpg" border="0">
		</td>
		<cfelse>
		<td align="center">
			#MonthAsString(SuperAudit.Month)#
		</td>
		<td align="center">
			<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #SuperAudit.ID#
			AND AuditYear = #SuperAudit.Year_#
			AND AuditOfficeNameID = #ID#
			AND Status = 'Complete'
			</cfquery>

			<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #SuperAudit.ID#
			AND AuditYear = #SuperAudit.Year_#
			AND AuditOfficeNameID = #ID#
			</cfquery>

			<cfif SuperAudit.Year_ gte 2011>
                <cfset RecordQuantity = 9>
            <cfelseif SuperAudit.Year_ eq 2010>
                <cfif SuperAudit.Month gte 9>
                    <cfset RecordQuantity = 8>
                <cfelseif SuperAudit.Month lt 9>
                    <cfset RecordQuantity = 7>
                </cfif>
            </CFIF>

			<cfif Complete.RecordCount EQ RecordQuantity>
				<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
					<img src="#IQARootDir#/images/green.jpg" border="0">
				</A>
			<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
				<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
					<img src="#IQARootDir#/images/blue.jpg" border="0">
				</A>
			<cfelseif Entered.RecordCount EQ 0>
				<img src="#IQARootDir#/images/yellow.jpg" border="0">
			</cfif>
		</td>
		</cfif>
	<cfelseif SuperAudit.Month lte 6>
		<td colspan="2" align="center">
			<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #IDDAP2#
			AND AuditYear = #url.year#
			AND AuditOfficeNameID = #ID#
			AND Status = 'Complete'
			</CFQUERY>

			<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Status FROM xSNAPDATA
			WHERE AuditID = #IDDAP2#
			AND AuditYear = #url.year#
			AND AuditOfficeNameID = #ID#
			</CFQUERY>

			<cfif url.year gte 2011>
                <cfset RecordQuantity = 9>
            <cfelseif url.year eq 2010>
                <cfset RecordQuantity = 8>
            </CFIF>

		<!--- if all seven records are entered and flagged complete --->
		<!--- link provided to review data --->
		<cfif Complete.RecordCount EQ RecordQuantity>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#Audits.Year_#&OfficeID=#ID#">
				DAP 2: <img src="#IQARootDir#/images/green.jpg" border="0">
			</A>
		<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered --->
		<!--- link provided to review what has been entered so far --->
		<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
			<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#Audits.Year_#&OfficeID=#ID#">
				DAP 2: <img src="#IQARootDir#/images/blue.jpg" border="0">
			</A>
		<!--- no records have been entered. auditor handles entering this --->
		<cfelseif Entered.RecordCount EQ 0>
			<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
                <img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                <a href="AuditDetails.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#">View Notes</a>
            <cfelse>
                <a href="DAP_SNAP_Add.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">DAP 2: Add</a>
            </cfif>
		</cfif>
	</td>
	</cfif>
</tr>
	</cfif>
</cfif>
</cfif>

<!--- If there is more than one audit returned for the location --->
<cfif Audits.RecordCount GT 1>
	<!--- Output Office Name --->
	<cfloop query="Audits">
		<tr class="blog-content" align="left" valign="top">
			<td>#OfficeName#</td>
			<td><A href="auditdetails.cfm?Year=#Year_#&ID=#ID#">#Year_#-#ID#</A></td>
			<td>#Area#</td>
			<cfif Month lte 6>
				<!--- Handle cancelled/Deleted audits here. status=Deleted is a CANCELLED AUDIT--->
				<cfif Status eq "Deleted" OR RescheduleNextYear eq "Yes">
				<!--- Show link to view cancellation notes if there is no audit January-June --->
				<td align="center">
					<!---DAP 1: <a href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#Locations.ID#">Add</a>--->
                    <a href="AuditDetails.cfm?ID=#Audits.ID#&Year=#Audits.Year_#">View Notes</a>
				</td>
				<!--- display RED for the cancelled audit --->
				<td align="center">
					<img src="#IQARootDir#/images/red.jpg" border="0">
				</td>
				<!--- Handle Active audits here --->
				<cfelse>
				<!--- Show Month of Scheduled Audit. --->
				<td align="center">
					#MonthAsString(Month)#
				</td>
				<!--- Check the status of SNAP Data for this audit --->
				<td align="center">
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #ID#
				AND AuditYear = #Year_#
				AND Status = 'Complete'
				</cfquery>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #ID#
				AND AuditYear = #Year_#
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

				<cfif Complete.RecordCount EQ RecordQuantity>
                    <A href="DAP_SNAP_Review.cfm?ID=#ID#&Year=#Year_#&OfficeID=#Locations.ID#">
                        <img src="#IQARootDir#/images/green.jpg" border="0">
                    </A>
                <cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
                    <A href="DAP_SNAP_Review.cfm?ID=#ID#&Year=#Year_#&OfficeID=#Locations.ID#">
                        <img src="#IQARootDir#/images/blue.jpg" border="0">
                    </A>
                <cfelseif Entered.RecordCount EQ 0>
                    <img src="#IQARootDir#/images/yellow.jpg" border="0">
                </cfif>
				</td>
				</cfif>
			<!--- if the audit is in the second half of the year -
			check for DAP audit #1 records for the first half of the year --->
			<cfelseif Audits.Month gt 6>
			<td colspan="2" align="center">
			<!--- check to see if the SNAP Data for DAP 1 for this office is complete/finalized --->
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP1#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #Locations.ID#
				AND Status = 'Complete'
				</CFQUERY>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP1#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #Locations.ID#
				</CFQUERY>

				<cfif url.year gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif url.year eq 2010>
                    <cfset RecordQuantity = 7>
                </CFIF>

				<!--- if all seven records are entered and flagged complete. link provided to review data --->
				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#Locations.ID#">
						DAP 1: <img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered. link provided to review what has been entered so far --->
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#Locations.ID#">
						DAP 1: <img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<!--- no records have been entered. link provided to enter data since this is DAP 1 and not a Site Audit --->
				<cfelseif Entered.RecordCount EQ 0>
					<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
                        <img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                        <a href="AuditDetails.cfm?ID=#ID#&Year=#Year_#">View Notes</a>
                    <cfelse>
                        <a href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#Locations.ID#">DAP 1:: Add</a>
                    </cfif>
				</cfif>
			</td>
			</cfif>
			<cfif Month gt 6>
			<!--- Handle cancelled/Deleted audits here. status=Deleted is a CANCELLED AUDIT--->
				<cfif Status eq "Deleted" OR RescheduleNextYear eq "Yes">
				<!--- show link to add SNAP Data if there is no audit July-December
				An audit SHOULD be added but in the event that it is not possible - we will show cancellation notes for the audit --->
				<td align="center">
					<!---DAP 2: <a href="DAP_SNAP_Add.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#Locations.ID#">Add</a>--->
                    <a href="AuditDetails.cfm?ID=#ID#&Year=#Year_#">View Notes</a>
				</td>
				<!--- display RED for the cancelled audit --->
				<td align="center">
					<img src="#IQARootDir#/images/red.jpg" border="0">
				</td>
				<!--- Handle Active audits here --->
				<cfelse>
				<!--- Show Month of Scheduled Audit --->
				<td align="center">
					#MonthAsString(Month)#
				</td>
				<!--- Check the status of SNAP Data for this audit --->
				<td align="center">
					<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT Status FROM xSNAPDATA
					WHERE AuditID = #ID#
					AND AuditYear = #Year_#
					AND AuditOfficeNameID = #Locations.ID#
					AND Status = 'Complete'
					</cfquery>

					<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT Status FROM xSNAPDATA
					WHERE AuditID = #ID#
					AND AuditYear = #Year_#
					AND AuditOfficeNameID = #Locations.ID#
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
						<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#Locations.ID#">
							<img src="#IQARootDir#/images/green.jpg" border="0">
						</A>
					<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered.
						link provided to review what has been entered so far --->
					<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
						<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#Locations.ID#">
							<img src="#IQARootDir#/images/blue.jpg" border="0">
						</A>
					<!--- no records have been entered. link provided to enter data
						since this is DAP 1 and not a Site Audit --->
					<cfelseif Entered.RecordCount EQ 0>
						<img src="#IQARootDir#/images/yellow.jpg" border="0">
					</cfif>
				</td>
				</cfif>
			<!--- if the audit is in the first half of the year -
			check for DAP audit #2 records for the second half of the year --->
			<cfelseif Audits.Month lte 6>
			<td colspan="2" align="center">
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP2#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #Locations.ID#
				AND Status = 'Complete'
				</CFQUERY>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP2#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #Locations.ID#
				</CFQUERY>

				<cfif url.year gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif url.year eq 2010>
                    <cfset RecordQuantity = 8>
                </CFIF>

				<!--- if all seven records are entered and flagged complete --->
				<!--- link provided to review data --->
				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#Locations.ID#">
						DAP 2: <img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<!--- if the records are NOT complete, and at least 1 (up to 7) have been entered --->
				<!--- link provided to review what has been entered so far --->
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#Locations.ID#">
						DAP 2: <img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<!--- no records have been entered. auditor handles entering this --->
				<cfelseif Entered.RecordCount EQ 0>
					<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
                        <img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                        <a href="AuditDetails.cfm?ID=#ID#&Year=#Year_#">View Notes</a>
                    <cfelse>
                        <a href="DAP_SNAP_Add.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#Locations.ID#">DAP 2: Add</a>
                    </cfif>
				</cfif>
			</td>
			</cfif>
		</tr>
	</cfloop>

<!--- If there is an audit for the location, check if this location is also included in a super location audit --->
<cfif SuperLocation EQ "No" AND Len(SuperLocationID)>
	<CFQUERY BLOCKFACTOR="100" name="SuperAudit" Datasource="Corporate">
	SELECT AuditSchedule.xGUID, AuditSchedule.Year_, AuditSchedule.ID, AuditSchedule.AuditArea, AuditSchedule.Area, AuditSchedule.LeadAuditor, AuditSchedule.Month, AuditSchedule.OfficeName, AuditSchedule.Status, AuditSchedule.RescheduleNextYear, IQAtblOffices.SuperLocationID
	FROM AuditSchedule, IQAtblOffices
	WHERE IQAtblOffices.ID = '#SuperLocationID#'
	AND IQAtblOffices.OfficeName = AuditSchedule.OfficeName
	AND AuditSchedule.Year_ = #url.year#
	AND AuditSchedule.AuditedBy = 'IQA'
	AND AuditSchedule.AuditType2 = 'Local Function'
	AND (AuditSchedule.Status IS NULL OR AuditSchedule.Status = 'Deleted')
	AND (AuditSchedule.Area = 'Processes' OR AuditSchedule.Area = 'Processes and Labs')
	</CFQUERY>

	<cfif SuperAudit.RecordCount GT 0>
		<tr class="blog-content" align="left" valign="top">
			<td>#OfficeName#</td>
			<td colspan="2"><a href="auditdetails.cfm?Year=#SuperAudit.Year_#&ID=#SuperAudit.ID#">#SuperAudit.Year_#-#SuperAudit.ID#</a>: #SuperAudit.OfficeName#</td>
			<cfif SuperAudit.Month lte 6>
			<td align="center">
				#MonthAsString(SuperAudit.Month)#
			</td>
			<td align="center">
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #SuperAudit.ID#
				AND AuditYear = #SuperAudit.Year_#
				AND AuditOfficeNameID = #ID#
				AND Status = 'Complete'
				</cfquery>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #SuperAudit.ID#
				AND AuditYear = #SuperAudit.Year_#
				AND AuditOfficeNameID = #ID#
				</cfquery>

				<cfif SuperAudit.Year_ gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif SuperAudit.Year_ eq 2010>
                    <cfif SuperAudit.Month gte 9>
                        <cfset RecordQuantity = 8>
                    <cfelseif SuperAudit.Month lt 9>
                        <cfset RecordQuantity = 7>
                    </cfif>
                </CFIF>

				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<cfelseif Entered.RecordCount EQ 0>
					<img src="#IQARootDir#/images/yellow.jpg" border="0">
				</cfif>
			</td>
			<cfelse>
			<td colspan="2" align="center">
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP1#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #ID#
				AND Status = 'Complete'
				</CFQUERY>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP1#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #ID#
				</CFQUERY>

				<cfif url.year gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif url.year eq 2010>
                    <cfset RecordQuantity = 7>
                </CFIF>

				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">
						DAP 1: <img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">
						DAP 1: <img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<cfelseif Entered.RecordCount EQ 0>
					<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
                        <img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                        <a href="AuditDetails.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#">View Notes</a>
                    <cfelse>
                        <A href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">DAP 1: Add</a>
                    </cfif>
				</cfif>
			</td>
			</cfif>
			<cfif SuperAudit.Month gt 6>
				<td align="center">
					#MonthAsString(SuperAudit.Month)#
				</td>
				<td align="center">
					<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT Status FROM xSNAPDATA
					WHERE AuditID = #SuperAudit.ID#
					AND AuditYear = #SuperAudit.Year_#
					AND AuditOfficeNameID = #ID#
					AND Status = 'Complete'
					</cfquery>

					<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT Status FROM xSNAPDATA
					WHERE AuditID = #SuperAudit.ID#
					AND AuditYear = #SuperAudit.Year_#
					AND AuditOfficeNameID = #ID#
					</cfquery>

					<cfif SuperAudit.Year_ gte 2011>
                        <cfset RecordQuantity = 9>
                    <cfelseif SuperAudit.Year_ eq 2010>
                        <cfif SuperAudit.Month gte 9>
                            <cfset RecordQuantity = 8>
                        <cfelseif SuperAudit.Month lt 9>
                            <cfset RecordQuantity = 7>
                        </cfif>
                    </CFIF>

				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<cfelseif Entered.RecordCount EQ 0>
					<img src="#IQARootDir#/images/yellow.jpg" border="0">
				</cfif>
				</td>
			<cfelse>
			<td colspan="2" align="center">
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP2#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #ID#
				AND Status = 'Complete'
				</CFQUERY>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP2#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #ID#
				</CFQUERY>

				<cfif url.year gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif url.year eq 2010>
                    <cfset RecordQuantity = 8>
                </CFIF>

				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">
						DAP 2: <img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">
						DAP 2: <img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<cfelseif Entered.RecordCount EQ 0>
					<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
                        <img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                        <a href="AuditDetails.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#">View Notes</a>
                    <cfelse>
                        <A href="DAP_SNAP_Add.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">DAP 2: Add</a>
                    </cfif>
				</cfif>
			</td>
			</cfif>
		</tr>
	</cfif>
</cfif>

<!--- If there is no audit returned --->
<cfelseif Audits.Recordcount EQ 0>
<!--- If the Office listed is a super location, check if child locations have audits --->
	<!--- not checking super locations
	<cfif SuperLocation EQ "Yes">
		<CFQUERY BLOCKFACTOR="100" name="ChildAudit" Datasource="Corporate">
		SELECT AuditSchedule.Year_, AuditSchedule.ID, AuditSchedule.AuditArea, AuditSchedule.Area, AuditSchedule.LeadAuditor, AuditSchedule.Month, AuditSchedule.OfficeName, Auditschedule.Status, IQAtblOffices.SuperLocationID
		FROM AuditSchedule, IQAtblOffices
		WHERE IQAtblOffices.SuperLocationID = '#ID#'
		AND IQAtblOffices.OfficeName = AuditSchedule.OfficeName
		AND AuditSchedule.Year_ = #url.year#
		AND AuditSchedule.AuditedBy = 'IQA'
		AND AuditSchedule.AuditType2 = 'Local Function'
		AND (AuditSchedule.Status IS NULL OR AuditSchedule.Status = 'Deleted')
		AND (AuditSchedule.Area = 'Processes' OR AuditSchedule.Area = 'Processes and Labs')
		ORDER BY OfficeName
		</CFQUERY>

		<tr class="blog-content" align="left" valign="top">
		<td>#OfficeName#</td>
		<td colspan="5">
		<cfif ChildAudit.recordcount GT 0>
			<cfloop query="ChildAudit">
				#OfficeName#: <A href="auditdetails.cfm?Year=#Year_#&ID=#ID#">#Year_#-#ID#</A> #Area#<br>
			</cfloop>
		</cfif>
		</td>
		--->

	<!--- if the office listed is NOT a super location, and there is a Super Location ID listed for this location,
	this indicates the location is a child of a super location, check for super location audits --->
		<!--- removed cfif superlocation eq "Yes" from above. if added in again, the next line needs to be changed to cfelseif --->
	<cfif SuperLocation EQ "No" AND Len(SuperLocationID)>
        <!--- Ise / Tokyo fix
			2011 and prior: [(Ise / Yokohama / Tokyo for 2011 and prior (SuperLocationID = 16)]
			2012 and forward: [(Ise / Tokyo) (SuperLocationID = 102)] --->
		<cfif OfficeName eq "UL Japan, Inc. Ise Head Office" OR OfficeName eq "UL Japan, Inc. Tokyo">
            <cfif url.year lte 2011>
                <cfset vSuperLocationID = 16>
            <cfelse>
                <cfset vSuperLocationID = 102>
            </cfif>
        <!--- Germany PV Lab removed from Superlocation after 2011.
			Old Name for 2011 and prior = Germany (Munich, Frankfurt, Frankfurt PV Lab)
			2012 and later = Germany (Munich, Frankfurt) --->
        <cfelseif OfficeName eq "Munich LES" OR OfficeName eq "UL International Germany GmbH">
            <cfif url.year lte 2011>
                <cfset vSuperLocationID = 107>
            <cfelse>
                <cfset vSuperLocationID = 79>
            </cfif>
		<!--- ULCCIC super location changed for 2012
			Old Name for 2011 and prior = UL-CCIC Company Limited (Shanghai / Guangzhou / Suzhou)
			New Name for 2012 and later = UL-CCIC Company Limited (Shanghai / Guangzhou)
        <cfelseif OfficeName eq "UL-CCIC Company Limited Guangzhou Branch" OR OfficeName eq "UL-CCIC Company Limited Shanghai Branch">
        	<cfif url.year lte 2011>
            	<cfset vSuperLocationID = 43>
            <cfelse>
            	<cfset vSuperLocationID = 111>
            </cfif>
		--->
		<cfelse>
          	<cfset vSuperLocationID = SuperLocationID>
        </cfif>

		<CFQUERY BLOCKFACTOR="100" name="SuperAudit" Datasource="Corporate">
		SELECT AuditSchedule.Year_, AuditSchedule.ID, AuditSchedule.AuditArea, AuditSchedule.Area, AuditSchedule.LeadAuditor, AuditSchedule.Month, AuditSchedule.OfficeName, AuditSchedule.Status, AuditSchedule.RescheduleNextYear, IQAtblOffices.SuperLocationID
		FROM AuditSchedule, IQAtblOffices
		WHERE IQAtblOffices.ID = '#vSuperLocationID#'
		AND IQAtblOffices.OfficeName = AuditSchedule.OfficeName
		AND AuditSchedule.Year_ = #url.year#
		AND AuditSchedule.AuditedBy = 'IQA'
		AND AuditSchedule.AuditType2 = 'Local Function'
		AND (AuditSchedule.Status IS NULL OR AuditSchedule.Status = 'Deleted')
		AND (AuditSchedule.Area = 'Processes' OR AuditSchedule.Area = 'Processes and Labs')
		</CFQUERY>

		<tr class="blog-content" align="left" valign="top">
			<td>#OfficeName#</td>
			<td colspan="2"><a href="auditdetails.cfm?Year=#SuperAudit.Year_#&ID=#SuperAudit.ID#">#SuperAudit.Year_#-#SuperAudit.ID#</a>: #SuperAudit.OfficeName#</td>
			<cfif SuperAudit.Month lte 6>
			<td align="center">
				#MonthAsString(SuperAudit.Month)#
			</td>
			<td align="center">
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #SuperAudit.ID#
				AND AuditYear = #SuperAudit.Year_#
				AND AuditOfficeNameID = #ID#
				AND Status = 'Complete'
				</cfquery>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #SuperAudit.ID#
				AND AuditYear = #SuperAudit.Year_#
				AND AuditOfficeNameID = #ID#
				</cfquery>

				<cfif SuperAudit.year_ gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif SuperAudit.year_ eq 2010>
                    <cfif SuperAudit.Month gte 9>
                        <cfset RecordQuantity = 8>
                    <cfelseif SuperAudit.Month lt 9>
                        <cfset RecordQuantity = 7>
                    </cfif>
                </CFIF>

				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<cfelseif Entered.RecordCount EQ 0>
					<img src="#IQARootDir#/images/yellow.jpg" border="0">
				</cfif>
			</td>
			<cfelse>
			<td colspan="2" align="center">
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP1#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #ID#
				AND Status = 'Complete'
				</CFQUERY>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP1#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #ID#
				</CFQUERY>

				<cfif url.year gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif url.year eq 2010>
                    <cfset RecordQuantity = 7>
                </CFIF>

				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">
						DAP 1: <img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">
						DAP 1: <img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<cfelseif Entered.RecordCount EQ 0>
					<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
                        <img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                        <a href="AuditDetails.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#">View Notes</a>
                    <cfelse>
                        <A href="DAP_SNAP_Add.cfm?ID=#IDDAP1#&Year=#url.year#&OfficeID=#ID#">DAP 1: Add</a>
                    </cfif>
				</cfif>
			</td>
			</cfif>
			<cfif SuperAudit.Month gt 6>
				<td align="center">
					#MonthAsString(SuperAudit.Month)#
				</td>
				<td align="center">
					<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT Status FROM xSNAPDATA
					WHERE AuditID = #SuperAudit.ID#
					AND AuditYear = #SuperAudit.Year_#
					AND AuditOfficeNameID = #ID#
					AND Status = 'Complete'
					</cfquery>

					<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT Status FROM xSNAPDATA
					WHERE AuditID = #SuperAudit.ID#
					AND AuditYear = #SuperAudit.Year_#
					AND AuditOfficeNameID = #ID#
					</cfquery>

				<cfif SuperAudit.year_ gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif SuperAudit.year_ eq 2010>
                    <cfif SuperAudit.Month gte 9>
                        <cfset RecordQuantity = 8>
                    <cfelseif SuperAudit.Month lt 9>
                        <cfset RecordQuantity = 7>
                    </cfif>
                </CFIF>

				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#&OfficeID=#ID#">
						<img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<cfelseif Entered.RecordCount EQ 0>
					<img src="#IQARootDir#/images/yellow.jpg" border="0">
				</cfif>
				</td>
			<cfelse>
			<td colspan="2" align="center">
				<CFQUERY BLOCKFACTOR="100" name="Complete" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP2#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #ID#
				AND Status = 'Complete'
				</CFQUERY>

				<CFQUERY BLOCKFACTOR="100" name="Entered" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Status FROM xSNAPDATA
				WHERE AuditID = #IDDAP2#
				AND AuditYear = #url.year#
				AND AuditOfficeNameID = #ID#
				</CFQUERY>

				<cfif url.year gte 2011>
                    <cfset RecordQuantity = 9>
                <cfelseif url.year eq 2010>
                    <cfset RecordQuantity = 8>
                 </CFIF>

				<cfif Complete.RecordCount EQ RecordQuantity>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">
						DAP 2: <img src="#IQARootDir#/images/green.jpg" border="0">
					</A>
				<cfelseif Complete.RecordCount EQ 0 AND Entered.RecordCount GT 0>
					<A href="DAP_SNAP_Review.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">
						DAP 2: <img src="#IQARootDir#/images/blue.jpg" border="0">
					</A>
				<cfelseif Entered.RecordCount EQ 0>
					<cfif Audits.Status eq "Deleted" OR Audits.RescheduleNextYear eq "Yes">
                        <img src="#IQARootDir#/images/red.jpg" border="0"><Br />
                        <a href="AuditDetails.cfm?ID=#SuperAudit.ID#&Year=#SuperAudit.Year_#">View Notes</a>
                    <cfelse>
                        <A href="DAP_SNAP_Add.cfm?ID=#IDDAP2#&Year=#url.year#&OfficeID=#ID#">DAP 2: Add</a>
                    </cfif>
				</cfif>
			</td>
			</cfif>
		</tr>
	<!--- If the office listed is NOT a super location, and there is no super location ID listed --->
	<cfelseif SuperLocation EQ "No" AND NOT Len(SuperLocationID)>
		<!---
        <tr class="blog-content" align="left" valign="top">
			<td>#OfficeName#</td>
			<td colspan="6" align="center">None</td>
		</tr>
        --->
	</cfif>
</cfif>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->