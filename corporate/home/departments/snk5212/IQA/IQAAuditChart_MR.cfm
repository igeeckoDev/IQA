<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='Activity_Coverage_Menu.cfm'>IQA Schedule Attainment Metrics</a> - Audit Chart">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<table border=1 width=750 style="border-collapse: collapse;">
<tr>
	<th>Year</th>
	<th>Audits Scheduled</th>
	<th>Audits Completed</th>
	<th>Audits Remaining</th>
	<th>Audits Cancelled</th>
	<th>Audits Rescheduled in the same Year</th>
	<th>Audits Reschedule for the following Year</th>
</tr>

<cfset firstYear = curyear - 4>
<cfset listTotal = "">
<cfset listYears = "">

<cfloop index=i from=#firstYear# to=#curyear#>

	<cfset listYears = listAppend(ListYears, i)>

	<CFQUERY BLOCKFACTOR="100" name="Total" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND (Status IS NULL OR Status = 'Deleted')
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<cfoutput>
	<tr>
		<!--- Year and Audits Scheduled --->
		<td align=center>#Total.Year_#</td>
		<td align=center>#Total.Count#</td>
		<cfset TotalAudits = #Total.Count#>

		<cfset listTotal = listAppend(listTotal, Total.Count)>

	<CFQUERY BLOCKFACTOR="100" name="Completed" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND Status IS NULL
	AND Report IS NOT NULL
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Completed --->
		<td align=center>#Completed.Count#</td>

	<CFQUERY BLOCKFACTOR="100" name="Remaining" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND (Status IS NULL)
	AND Report IS NULL
	AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Remaining --->
		<td align=center>
			<cfif isDefined("Remaining.Count") AND len(Remaining.Count)>
				#Remaining.Count#
			<cfelse>
				0
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="Cancelled" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND Status = 'Deleted'
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Cancelled --->
		<td align=center>
			<cfif isDefined("Cancelled.Count") AND len(Cancelled.Count)>
				<cfset avgCancelled = (Cancelled.Count / Total.Count) * 100>
				#Cancelled.Count# (#numberformat(avgCancelled, "9.99")#%)
			<cfelse>
				0
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="RescheduledInYear" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND (Status IS NULL)
	AND RescheduleStatus = 'Rescheduled'
	AND RescheduleNextyear = 'No'
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Rescheduled within the year --->
		<td align=center>
			<cfif isDefined("RescheduledInYear.Count") AND len(RescheduledInYear.Count)>
				<cfset avgRescheduledInYear = (RescheduledInYear.Count / Total.Count) * 100>
				#RescheduledInYear.Count# (#numberformat(avgRescheduledInYear, "9.99")#%)
			<cfelse>
				0
			</cfif>
		</td>

	<CFQUERY BLOCKFACTOR="100" name="RescheduledNextYear" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND (Status IS NULL)
	AND RescheduleStatus = 'Rescheduled'
	AND RescheduleNextyear = 'Yes'
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

		<!--- Rescheduled next year --->
		<td align=center>
			<cfif isDefined("RescheduledNextYear.Count") AND len(RescheduledNextYear.Count)>
				<cfset avgRescheduledNextYear = (RescheduledNextYear.Count / Total.Count) * 100>
				#RescheduledNextYear.Count# (#numberformat(avgRescheduledNextYear, "9.99")#%)
			<cfelse>
				0
			</cfif>
		</td>
	</tr>
	</cfoutput>
</cfloop>
</table><br>

<table border=1 width=750 style="border-collapse: collapse;">
<b>** Note</b> - For the table below, the current year (<cfoutput>#curYear#</cfoutput>) shows the audit forecast for the year (total audits, not including cancelled or rescheduled for next year audits).<br><br>

<tr>
	<th>Year</th>
	<th>Audits Completed **</th>
	<th>Site Audits Completed</th>
	<th>Programs/Schemes</th>
	<th>Certification Body Audits Completed</th>
	<th>Global Function/Process Audits Completed</th>
</tr>

<cfset listCompleted = "">
<cfset listSite = "">
<cfset listProg = "">
<cfset listSchemes = "">
<cfset listCB = "">
<cfset listGlobal = "">

<cfloop index=i from=#firstyear# to=#curyear#>
	<!--- Scheduled --->
	<!---
	<CFQUERY BLOCKFACTOR="100" name="Scheduled" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND (Status IS NULL OR Status = 'Deleted')
	AND (RescheduleStatus = 'Rescheduled' AND RescheduleNextyear = 'No' OR RescheduleStatus IS NULL)
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>
	--->

	<!--- Completed --->
	<CFQUERY BLOCKFACTOR="100" name="Completed" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND Status IS NULL
	<cfif i LT curyear>
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	</cfif>
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<cfset listCompleted = listAppend(listCompleted, Completed.Count)>

	<!--- Completed Site Audits --->
	<CFQUERY BLOCKFACTOR="100" name="CompletedSite" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND (AuditType2 = 'Local Function' and AuditArea <> 'Certification Body (CB) Audit')
	AND Status IS NULL
	<cfif i LT curyear>
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	</cfif>
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<cfset listSite = listAppend(listSite, CompletedSite.Count)>

	<!--- Completed Program Audits and total Number of Schemes --->
	<CFQUERY BLOCKFACTOR="100" name="CompletedProg" Datasource="Corporate">
	SELECT COUNT(*) <cfif i eq 2015>+34<cfelseif i eq 2016>+37</cfif> as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND AuditType2 = 'Program'
	AND AuditArea <> 'Scheme Documentation Audit'
	AND Status IS NULL
	<cfif i LT curyear>
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	</cfif>
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<cfset listProg = listAppend(listProg, CompletedProg.Count)>

	<!--- Completed Certification Body Audits --->
	<CFQUERY BLOCKFACTOR="100" name="CompletedCB" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND (AuditType2 = 'Local Function' and AuditArea = 'Certification Body (CB) Audit')
	AND Status IS NULL
	<cfif i LT curyear>
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	</cfif>
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<cfif len(CompletedCB.Count)>
		<cfset listCB = listAppend(listCB, CompletedCB.Count)>
	<cfelse>
		<cfset listCB = listAppend(listCB, 0)>
	</cfif>

	<!--- Completed Global Function/Process Audits --->
	<CFQUERY BLOCKFACTOR="100" name="CompletedGlobal" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND AuditType2 = 'Global Function/Process'
	AND Status IS NULL
	<cfif i LT curyear>
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	</cfif>
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<cfset listGlobal = listAppend(listGlobal, CompletedGlobal.Count)>

<cfoutput>
	<tr>
		<!--- Year and Audits Scheduled --->
		<td align=center>#i#</td>
		<td align=center><cfif isDefined("Completed.Count") AND len(Completed.Count)>#Completed.Count#<cfelse>0</cfif></td>
		<td align=center><cfif isDefined("CompletedSite.Count") AND len(CompletedSite.Count)>#CompletedSite.Count#<cfelse>0</cfif></td>
		<td align=center><cfif isDefined("CompletedProg.Count") AND len(CompletedProg.Count)>#CompletedProg.Count#<cfelse>0</cfif></td>
		<td align=center><cfif isDefined("CompletedCB.Count") AND len(CompletedCB.Count)>#CompletedCB.Count#<cfelse>0</cfif></td>
		<td align=center><cfif isDefined("CompletedGlobal.Count") AND len(CompletedGlobal.Count)>#CompletedGlobal.Count#<cfelse>0</cfif></td>
	</tr>
</cfoutput>
</cfloop>
</table>

<br><br><br>
<Cfoutput>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
</cfoutput>

<script type="text/javascript">
$(function () {
	Highcharts.setOptions({
   		colors: ['#708090', '#DC143C', '#FFD700', '#1E90FF', '#64E572']})
    $('#container').highcharts({
        title: {
            text: 'IQA Audits Completed by Year',
            x: -20 //center
        },
        subtitle: {
            text: 'Source: IQA DB',
            x: -20
        },
        xAxis: {
            categories: [<cfoutput>#listYears#</cfoutput>]
        },
        yAxis: {
            min: 0,
            minRange: 0.1,
            title: {
                text: 'Number of Audits'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
		plotOptions: {
            line: {
                dataLabels: {
                    enabled: false
                },
                enableMouseTracking: true
            }
        },
        series: [{
            name: 'Audits Completed / Forecast',
            data: [<Cfoutput>#listCompleted#</cfoutput>]
        }, {
            name: 'Site Audits',
            data: [<Cfoutput>#listSite#</cfoutput>]
        }, {
            name: 'Programs/Schemes',
            data: [<Cfoutput>#listProg#</cfoutput>]
        }, {
            name: 'Certification Body',
            data: [<Cfoutput>#listCB#</cfoutput>]
        }, {
        	name: 'Global Function/Process',
        	data: [<Cfoutput>#listGlobal#</cfoutput>]
    	}]
    });
});
</script>

<cfoutput>
<script src="#SiteDir#SiteShared/js/highcharts.js"></script>
<script src="#SiteDir#SiteShared/js/modules/exporting.js"></script>
</cfoutput>

<div id="container" style="min-width: 900px; height: 500px; max-width: 1000px; margin: 0 auto"></div>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->