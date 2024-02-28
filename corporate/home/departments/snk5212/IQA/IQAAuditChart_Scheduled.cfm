<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Schedule Attainment Metrics - Audit Chart">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<table border=1 width=750 style="border-collapse: collapse;">
<tr>
	<th>Year</th>
	<th>Audits Completed</th>
	<th>Site Audits Completed</th>
	<th>Program/Scheme Audits Completed</th>
	<th>Certification Body Audits Completed</th>
	<th>Global Function/Process Audits Completed</th>
</tr>

<cfloop index=i from=2012 to=#curyear#>
	<!--- Completed --->
	<CFQUERY BLOCKFACTOR="100" name="Completed" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND Status IS NULL
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<!--- Completed Site Audits --->
	<CFQUERY BLOCKFACTOR="100" name="CompletedSite" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND (AuditType2 = 'Local Function' and AuditArea <> 'Certification Body (CB) Audit')
	AND Status IS NULL
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<!--- Completed Program/Scheme Audits --->
	<CFQUERY BLOCKFACTOR="100" name="CompletedProg" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND AuditType2 = 'Program'
	AND Status IS NULL
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<!--- Completed Certification Body Audits --->
	<CFQUERY BLOCKFACTOR="100" name="CompletedCB" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND (AuditType2 = 'Local Function' and AuditArea = 'Certification Body (CB) Audit')
	AND Status IS NULL
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

	<!--- Completed Global Function/Process Audits --->
	<CFQUERY BLOCKFACTOR="100" name="CompletedGlobal" Datasource="Corporate">
	SELECT COUNT(*) as Count, Year_
	FROM AuditSchedule
	WHERE Year_ = #i#
	AND AuditedBy = 'IQA'
	AND AuditType2 = 'Global Function/Process'
	AND Status IS NULL
	AND (Report IS NOT NULL
			AND Report <> '1'
			AND Report <> '2'
			AND Report <> '3'
			AND Report <> '4'
			AND Report <> '5'
			AND Report <> 'Entered')
	GROUP BY Year_
	ORDER BY Year_ DESC
	</cfquery>

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
    $('#container').highcharts({
        title: {
            text: 'IQA Audits Completed by Year',
            x: -20 //center
        },
        subtitle: {
            text: 'Source: IQA DB',
            x: -5
        },
        xAxis: {
            categories: ['2012', '2013', '2014', '2015', '2016']
        },
        yAxis: {
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
        series: [{
            name: 'Audits Completed',
            data: [106,118,127,157,1]
        }, {
            name: 'Site',
            data: [47,62,64,79,0]
        }, {
            name: 'Program/Scheme',
            data: [39,40,43,43,1]
        }, {
            name: 'Certification Body',
            data: [0,0,1,17,0]
        }, {
        	name: 'Global Function/Process',
        	data: [14,13,16,17,0]
    	}]
    });
});
</script>

<cfoutput>
<script src="#SiteDir#SiteShared/js/highcharts.js"></script>
<script src="#SiteDir#SiteShared/js/modules/exporting.js"></script>
</cfoutput>

<div id="container" style="min-width: 800px; height: 500px; max-width: 1000px; margin: 0 auto"></div>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->