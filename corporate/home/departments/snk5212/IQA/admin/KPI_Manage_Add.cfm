<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="<a href=KPI_Manage.cfm>KPI - Add Month</a>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID) as MaxID
FROM KPI
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="getYearMonth" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Year_, Month
FROM KPI
WHERE ID = #KPI.MaxID#
</CFQUERY>

<cfif getYearMonth.Month eq 12>
	<cfset varMonth = 1>
	<cfset varYear = getYearMonth.Year_ + 1>
<cfelse>
	<cfset varMonth = getYearMonth.Month + 1>
	<cfset varYear = getYearMonth.Year_>
</cfif>

<cfoutput>
	<b>Year/Month to Add</b><br>
	<u>Year</u>: #varYear#<br>
	<u>Month</u>: #monthAsString(varMonth)#<br><br>
</cfoutput>

	<table border=1>
		<tr>
			<th>KPI / Supporting Metric</th>
			<th>Value</th>
		</tr>
		<tr>
			<th colspan="2">
				IQA KPI
			</th>
		</tr>
		<tr>
			<td>
			<cfoutput>
				<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Admin/AuditSurvey_Metrics.cfm?Year=2017" target="_blank">IQA Customer Satisfaction Survey</a> (YTD)
			</cfoutput>
			</td>
			<td align="center">
				<CFQUERY BLOCKFACTOR="100" name="AuditSurvey" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Avg(AuditSurvey_Answers.Answer) as avgAnswer
				FROM AuditSurvey_Answers, AuditSurvey_Users
				WHERE AuditSurvey_Answers.Answer <> 0
				AND AuditSurvey_Answers.UserID = AuditSurvey_Users.ID
				AND AuditSurvey_Users.AuditYear = #curYear#
				</cfquery>
				
				<cfoutput query="AuditSurvey">
					#numberformat(avgAnswer, "9.99")#
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td>Average Number of audits per Schemes</td>
			<!--- 5 Schemes are not being audited in 2017. UL Verif Mark Copper LAN, BSAI, TCB UK, ECV, SPC. Subtract from 'scheme total' --->
			<td align="center">
			
				<CFQUERY BLOCKFACTOR="100" name="Progs" Datasource="Corporate">
				SELECT Program
				FROM ProgDev
				WHERE IQA = 1
				AND Status IS NULL
				</CFQUERY>

				<cfset allCount = 0>
				<cfset totalCount = 0>
				
				<cfoutput query="Progs">
					<CFQUERY BLOCKFACTOR="100" name="ResultsProgAudit" Datasource="Corporate">
					SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
					FROM AuditSchedule
					WHERE Area = '#Progs.Program#'
					AND AuditType2 = 'Program'
					AND YEAR_ = #curYear#
					AND AuditedBy = 'IQA'
					AND (Status IS NULL OR Status = '')
					AND Month < 13
					ORDER BY ID
					</CFQUERY>

					<CFQUERY BLOCKFACTOR="100" name="ResultsSiteAudit" Datasource="Corporate">
					SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
					FROM AuditSchedule
					WHERE (KP LIKE '%#Program#%' OR Area = '#Program#')
					AND AuditType2 <> 'Program'
					AND YEAR_ = #curYear#
					AND AuditedBy = 'IQA'
					AND (Status IS NULL OR Status = '')
					AND Month < 13
					ORDER BY ID
					</CFQUERY>

					<CFQUERY BLOCKFACTOR="100" name="ResultsReport" Datasource="Corporate">
					SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year", Report.Programs
					FROM AuditSchedule, Report
					WHERE
					Report.ID = AuditSchedule.ID
					AND Report.Year_ = AuditSchedule.Year_
					AND AuditSchedule.Year_= #curYear#
					AND 
						(
							Report.Programs LIKE '%#Program#%'
							<cfif Program eq "&lt;PS&gt;E Mark (JP) (US CO)">
								OR Report.Programs LIKE '%<PS>E Mark (JP) (US CO)%'
							<cfelseif Program eq "&lt;PS&gt;E Mark (JP) (JP CO)">
								OR Report.Programs LIKE '%<PS>E Mark (JP) (JP CO)%'
							</cfif>
						)
					AND AuditSchedule.AuditType2 <> 'Program'
					AND AuditSchedule.AuditedBy = 'IQA'
					AND (AuditSchedule.Status IS NULL OR AuditSchedule.Status = '')
					AND Month < 13
					ORDER BY AuditSchedule.AuditType2, AuditSchedule.ID
					</CFQUERY>
					
					<cfif ResultsProgAudit.recordcount eq 0 AND ResultsSiteAudit.recordcount eq 0 AND ResultsReport.recordcount eq 0>
					<cfelse>
						<cfset totalCount = ResultsProgAudit.recordcount + ResultsSiteAudit.recordcount + ResultsReport.recordcount>
					</cfif>
					
					<cfset allCount = allCount + totalCount>
				</cfoutput>

				<cfoutput>
					Total Count of Schemes (Multiple Schemes per Audit are possible): #allCount#<br>
					Number of Schemes Audited: #progs.recordcount#<br>
					Adjusted Number of Schemes (excluding schemes that are not beign audited in 2017): <Cfset adjustedCount = progs.recordcount - 5> #adjustedCount#<Br>
					
					<cfset averageAuditsPerScheme = allCount / #adjustedCount#>
					Average Audits per Scheme = #averageAuditsPerScheme#<Br>
				</cfoutput>
			
			</td>
		</tr>
		<tr>
			<td valign="top">
				Target - Schemes by Quarter<br><Br>
				
				This is set at the beginning of the year.
			</td>
			<td align="center">
				<CFQUERY BLOCKFACTOR="100" NAME="lastMonth" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT *
				FROM KPI
				WHERE ID = #KPI.MaxID#
				</CFQUERY>
				
				<cfoutput query="lastMonth">
					#PlannedSchemesQ1# (Q1)<br>
					#PlannedSchemesQ2# (Q2)<br>
					#PlannedSchemesQ3# (Q3)<br>
					#PlannedSchemesQ4# (Q4)
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td valign="top">
				Actual - Schemes by Quarter<br><br>

				Data is from <cfoutput query="lastMonth">#MonthAsString(Month)#</cfoutput>. Adjust after counting NEW schemes covered in the current Quarter. (Manual Calculation/counting)
			</td>
			<td align="center">
				<cfoutput query="lastMonth">		
					#SchemesQ1# (Q1)<br>
					#SchemesQ2# (Q2)<br>
					#SchemesQ3# (Q3)<br>
					#SchemesQ4# (Q4)
				</cfoutput>
			</td>
		</tr>
		<tr>
			<th colspan="2">CAR KPI</th>
		</tr>
		<tr>
			<td>
				<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Admin/CARSurvey_Metrics.cfm?Year=2017" target="_blank">Corrective Action Customer Survey</a> (YTD)
			</td>
			<td align="center">
				<CFQUERY BLOCKFACTOR="100" name="CARSurvey" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Avg(CARSurvey_Answers.Answer) as avgAnswer
				FROM CARSurvey_Answers, CARSurvey_Users
				WHERE CARSurvey_Answers.Answer <> 0
				AND CARSurvey_Users.ID = CARSurvey_Answers.USERID
				AND
					(CARSurvey_Users.Posted >= TO_DATE('#curYear#-01-01', 'yyyy-mm-dd')
					AND CARSurvey_Users.Posted <= TO_DATE('#curYear#-12-31', 'yyyy-mm-dd'))
				</cfquery>
				
				<cfoutput query="CARSurvey">
					#numberformat(avgAnswer, "9.99")#
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td>Effectively Closed CAR %</td>
			<!--- CARs Verified Effective / [Effective + Ineffective], when CAR Open Date is in the last 3 years, i.e., Month Posted/01/curyear minus 3--->
			
			<cfset varThreeYear = curYear - 3>
			<cfset varNextMonth = varMonth + 1>
			
			<CFQUERY BLOCKFACTOR="100" name="EffectiveCARs" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT DISTINCT CARNumber
			FROM GCAR_Metrics
			WHERE 
				(CARCloseDate >= TO_DATE('#varThreeYear#-#varNextMonth#-01', 'yyyy-mm-dd') <!--- greater than or equal to 2014-05-01 --->
				AND CARCloseDate <= TO_DATE('#curYear#-#varNextMonth#-01', 'yyyy-mm-dd')) <!--- less than or equal to 2017-05-01 --->
			AND CARState = 'Closed - Verified as Effective'
			AND CARFindOrObservation = 'Finding'
			</cfquery>
			
			<CFQUERY BLOCKFACTOR="100" name="VerifiedCARs" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT DISTINCT CARNumber
			FROM GCAR_Metrics
			WHERE 
				(CARCloseDate >= TO_DATE('#varThreeYear#-#numberformat(varNextMonth, 00)#-01', 'yyyy-mm-dd') <!--- greater than or equal to 2014-05-01 --->
				AND CARCloseDate <= TO_DATE('#curYear#-#numberformat(varNextMonth, 00)#-01', 'yyyy-mm-dd')) <!--- less than or equal to 2017-05-01 --->
			AND 
				(CARState = 'Closed - Verified as Effective'
				OR CARState = 'Closed - Verified as Ineffective')
			AND CARFindOrObservation = 'Finding'
			</cfquery>
			
			<cfset CARVerifiedEffectiveRate = (EffectiveCARs.recordcount / VerifiedCARs.recordcount) * 100>
			
			<td align="center">
				<cfoutput>
					#numberformat(CARVerifiedEffectiveRate, 00.00)# %<br>
					
					<!---
					#EffectiveCARs.recordcount# / #VerifiedCARs.recordcount#<br>
					From #varThreeYear#-#varNextMonth#-01<br>
					To #curYear#-#varNextMonth#-01
					--->
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td>
				Median Duration of Corrective Actions (Findings)<br><br>
			
				Manual Entry from "GCAR_Metrics_NewImport.xlsx" "CAR Life" worksheet tab
			</td>
			<td align="center">
				125
			</td>
		</tr>
		<tr>
			<td>
				Median Duration of Corrective Actions (Observations)<br><br>
			
				Manual Entry from "GCAR_Metrics_NewImport.xlsx" "CAR Life" worksheet tab
			</td>
			<td align="center">
				50
			</td>
		</tr>
		<tr>
			<th colspan="2">DAP/CTF/External CBTL Audit Fulfillment KPI</th>
		</tr>
		<tr>
			<td>DAP/CTF/External CBTL - Audit NPS</td>
			<td align="center">#NPS#</td>
		</tr>
		<tr>
			<td>Completed Audit Projects Before Anniversary Date % (AVD)</td>
			<td align="center">#AVD#</td>
		</tr>
		<tr>
			<th colspan="2">DAP/CTF/CBTL Resource Allocation KPI</th>
		</tr>
		<tr>
			<td>Average Number of Clients per DAP Auditor</td>
			<td align="center">#DAPAudits#</td>
		</tr>
		<tr>
			<td>Average Number of CTF/CBTL per Auditor</td>
			<td align="center">#CTFAudits#</td>
		</tr>
	</table><br><br>
  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->