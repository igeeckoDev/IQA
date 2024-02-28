<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="<a href=KPI_Manage.cfm>KPI - Manage</a>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM KPI
WHERE ID = #ID#
</CFQUERY>

<cfoutput query="KPI">
<b>Month</b> #Month#<br>
<b>Year</b> #Year_#<br>
<b>Date Posted</b> (date of latest revision) #dateformat(DatePosted, "mm/dd/yyyy")#<br><br>

	<table border=1>
		<tr>
			<th>KPI / Supporting Metric</th>
			<th>Value</th>
		</tr>
		<tr>
			<th colspan="2">IQA KPI</th>
		</tr>
		<tr>
			<td>IQA Customer Satisfaction Survey</td>
			<td align="center">#IQASurvey#</td>
		</tr>
		<tr>
			<td>Number of Schemes/Program</td>
			<td align="center">#CurrentSchemeCount#</td>
		</tr>
		<tr>
			<td>Average Number of audits per Schemes</td>
			<td align="center">#avgAuditsPerScheme#</td>
		</tr>
		<tr>
			<td>Total Number of Audits</td>
			<td align="center">#IQAAudits#</td>
		</tr>
		<tr>
			<td valign="top">Target - Schemes by Quarter</td>
			<td align="center">#SchemesQ1# (Q1)<br>#SchemesQ2# (Q2)<br>#SchemesQ3# (Q3)<br>#SchemesQ4# (Q4)</td>
		</tr>
		<tr>
			<th colspan="2">CAR KPI</th>
		</tr>
		<tr>
			<td>Corrective Action Customer Survey</td>
			<td align="center">#CARSurvey#</td>
		</tr>
		<tr>
			<td>Effectively Closed CAR %</td>
			<td align="center">#CARVerifiedEffective#</td>
		</tr>
		<tr>
			<td>Median Duration of Corrective Actions (Findings)</td>
			<td align="center">#CARFindingMedian#</td>
		</tr>
		<tr>
			<td>Median Duration of Corrective Actions (Observations)</td>
			<td align="center">#CARObservationMedian#</td>
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
	
<b>IQA KPIs - Comments</b><br>
<cfif len(IQAComments)>
	#IQAComments#
<cfelse>
	No Comments
</cfif><br><br>

<b>CAR KPIs - Comments</b><br>
<cfif len(CARComments)>
	#CARComments#
<cfelse>
	No Comments
</cfif><br><br>

<b>Audit Fulfillment KPIs - Comments</b><br>
<cfif len(FulfillmentComments)>
	#FulfillmentComments#
<cfelse>
	No Comments
</cfif><br><br>

<b>Audit Resource Allocation KPIs - Comments</b><br>
<cfif len(AllocationComments)>
	#AllocationComments#
<cfelse>
	No Comments
</cfif><br><br>
</cfoutput>
  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->