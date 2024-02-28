<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Report Card - Yearly Overview">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="getAudit1" Datasource="Corporate">
SELECT Area, OfficeName, AuditType2, ID, Year_, lastYear
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
AND AuditedBY = 'IQA'
</CFQUERY>

<cfif len(getAudit1.lastYear)>
	<CFQUERY Name="getAudit2" Datasource="Corporate">
	SELECT Area, OfficeName, AuditType2, ID, Year_, lastYear
	FROM AuditSchedule
	WHERE AuditedBY = 'IQA'
	AND xGUID = #getaudit1.lastYear#
	</CFQUERY>
	
	<cfif len(getAudit2.lastYear)>
		<CFQUERY Name="getAudit3" Datasource="Corporate">
		SELECT Area, OfficeName, AuditType2, ID, Year_, lastYear
		FROM AuditSchedule
		WHERE AuditedBY = 'IQA'
		AND xGUID = #getaudit2.lastYear#
		</CFQUERY>
		
		<cfif len(getAudit3.Year_)>
			<cfset loopTo = 3>
		</cfif>
	<cfelse>
		<cfset loopTo = 2>
	</cfif>
<cfelse>
	<cfset loopTo = 1>
</cfif>

<cfset myarray=arraynew(2)>
<cfset i = #URL.Year#>

<cfoutput>
<cfloop index=j from=1 to=#loopTo#>
	<CFQUERY Name=avgData Datasource=UL06046 username=#OracleDB_Username# password=#OracleDB_Password#>
	SELECT AVG(xAxis) as avgX, AVG(yAxis) as avgY
	From ProgramReportCard_Output
	WHERE 
	Year_ = #i#
	<cfif j eq 3>
		AND ID = #getAudit3.ID#
	<cfelseif j eq 2>
		AND ID = #getAudit2.ID#
	<cfelseif j eq 1>
		AND ID = #getAudit1.ID#
	</cfif>
	</CFQUERY>
	
	<cfset myarray[j][1] = "#i#">
	<cfset myarray[j][2] = #numberformat(avgData.avgX, "9.99")#>
	<cfset myarray[j][3] = #numberformat(avgData.avgY, "9.99")#>

<cfset i = i - 1>
</cfloop>
</cfoutput>

<!---
<cfloop index=i from=1 to=3>
	<cfoutput>
		Audit: #myArray[i][1]#<br>
		AvgX: #myArray[i][2]#<br>
		AvgY: #myArray[i][3]#<br>
	</cfoutput>
</cfloop>
--->

<Cfoutput>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
</cfoutput>

<script type="text/javascript">
$(function () {
    Highcharts.setOptions({
        colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
    });

	$('#container').highcharts({
        chart: {
            type: 'scatter',
            plotBorderWidth: 1
        },
        legend: {
        	title: {
                text: 'Year<br/><span style="font-size: 9px; color: #666; font-weight: normal">(Click to hide)</span>',
                style: {
                    fontStyle: 'italic',
                }
            },
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -10,
            y: 100
        },
        credits: {
        	enabled: false
        },
        title: {
            text: '<cfoutput>Report Card - Yearly Overview<br>#getAudit1.OfficeName#</cfoutput>'
        },
        subtitle: {
            text: 'based on IQA\'s Determination of Effectiveness'
        },
        xAxis: {
            allowDecimals: false,
            max: 5,
            min: 1,
            title: {
                enabled: true,
                text: 'Approach'
            },
            startOnTick: true,
            endOnTick: true,
            showLastLabel: true
        },
        yAxis: {
            allowDecimals: false,
            max: 5,
            min: 1,
            title: {
                enabled: true,
                text: 'Effectiveness'
            }
        },
        plotOptions: {
            series: {
            	dataLabels: {
            		enabled: false,
            		format: '{series.name}', //make it show the name
            		x: 10, // place it on the right side
            		y: 25
            	},
            },
            scatter: {
                marker: {
                    radius: 6,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: 'rgb(100,100,100)'
                        }
                    }
                },
                states: {
                    hover: {
                        marker: {
                            enabled: false
                        }
                    }
                },
                tooltip: {
                	enabled: true,
                    headerFormat: '<b>{series.name}</b><br>',
                    pointFormat: 'Approach: {point.x}, Effectiveness: {point.y}'
                }
            }
        },
        series: [
		<cfloop index=i from=1 to=#loopTo#>
			<cfoutput>
	            {
	            name: '#myArray[i][1]#',
	            data: [[#numberformat(myArray[i][2], "9.99")#, #numberformat(myArray[i][3], "9.99")#]]
	            }<cfif i lt 3>,</cfif>
			</cfoutput>
		</cfloop>
    	]
    });
});
</script>

<cfoutput>
<script src="#SiteDir#SiteShared/js/highcharts.js"></script>
<script src="#SiteDir#SiteShared/js/modules/exporting.js"></script>
</cfoutput>

<div id="container" style="min-width: 800px; height: 500px; max-width: 1000px; margin: 0 auto"></div>

<cfset startYear = #URL.Year# - 2>

<CFQUERY Name="Audits" Datasource="Corporate">
SELECT ID, Year_, OfficeName, Area, AuditedBy, Status
FROM AuditSchedule
WHERE OfficeName = '#getAudit1.OfficeName#'
AND AuditType2 = 'Local Function'
AND AuditArea = 'Certification Body (CB) Audit'
AND AuditedBY = 'IQA'
AND Year_ BETWEEN #StartYear# AND #URL.Year#

<cfif getAudit1.OfficeName eq "UL International Demko A/S">
	AND ID <> 403
</cfif>

ORDER BY Year_
</CFQUERY>

<table border="1">
<tr>
	<th width="100">Audit</th>
	<th width="100">Approach</th>
	<th width="100">Effectiveness</th>
</tr>
<cfoutput query="Audits">
	<CFQUERY Name="avgData" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT AVG(xAxis) as avgX, AVG(yAxis) as avgY
	From ProgramReportCard_Output
	WHERE ID = #ID#
	AND Year_ = #Year_#
	</CFQUERY>

	<cfloop query="avgData">
	<tr>
		<td align="center"><a href="_scatterTest3.cfm?Year=#Audits.Year_#&ID=#Audits.ID#" target="_blank">#Audits.Year_#</a></td>
		<td align="center">#numberformat(avgX, "9.99")#</td>
		<td align="center">#numberformat(avgY, "9.99")#</td>
	</tr>
	</cfloop>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->