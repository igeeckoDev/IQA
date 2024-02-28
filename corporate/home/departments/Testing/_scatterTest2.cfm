<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Report Card - Yearly Overview">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="getAudit" Datasource="Corporate">
SELECT Area, OfficeName, AuditType2, ID, Year_, lastYear
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
AND AuditedBY = 'IQA'
</CFQUERY>

<CFQUERY Name="getlastYearAudit" Datasource="Corporate">
SELECT Area, OfficeName, AuditType2, ID, Year_
FROM AuditSchedule
WHERE xGUID = #getAudit.lastYear#
</CFQUERY>

<CFQUERY Name="getfirstYearAudit" Datasource="Corporate">
SELECT Area, OfficeName, AuditType2, ID, Year_
FROM AuditSchedule
WHERE xGUID = #getlastYearAudit.lastYear#
</CFQUERY>

<cfdump var="#getaudit#">

<cfset startYear = #URL.Year# - 2>

<cfset myarray=arraynew(2)>
<cfset i = StartYear>

<cfoutput query=Audit>
	<CFQUERY Name=avgData Datasource=UL06046 username=#OracleDB_Username# password=#OracleDB_Password#>
	SELECT AVG(xAxis) as avgX, AVG(yAxis) as avgY
	From ProgramReportCard_Output
	WHERE 
	AND Year_ = #i#
	</CFQUERY>
	
	<cfdump var="#avgData#">

	<cfloop query=avgData>
		<cfset myarray[i][1] = "#Audit.Year_#">
		<cfset myarray[i][2] = #numberformat(avgX, "9.99")#>
		<cfset myarray[i][3] = #numberformat(avgY, "9.99")#>
	</cfloop>

<cfset i = i + 1>
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
            text: '<cfoutput>Report Card - Yearly Overview<br>#Audit.OfficeName#</cfoutput>'
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
		<cfloop index=i from=1 to=3>
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

<cfset startYear = #URL.Year_# - 2>

<CFQUERY Name="Audit" Datasource="Corporate">
SELECT ID, Year_, OfficeName
FROM AuditSchedule
WHERE OfficeName = '#getAudit.OfficeName#'
AND AuditedBY = 'IQA'
AND Year_ BETWEEN #URL.Year_# AND #StartYear#
ORDER BY Year_
</CFQUERY>

<table border="1">
<tr>
	<th width="100">Audit</th>
	<th width="100">Approach</th>
	<th width="100">Effectiveness</th>
</tr>
<cfoutput query="Audit">
	<CFQUERY Name="avgData" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT AVG(xAxis) as avgX, AVG(yAxis) as avgY
	From ProgramReportCard_Output
	WHERE ID = #ID#
	AND Year_ = #Year_#
	</CFQUERY>

	<cfloop query="avgData">
	<tr>
		<td align="center"><a href="_scatterTest3.cfm?Year=#Audit.Year_#&ID=#Audit.ID#" target="_blank">#Audit.Year_#</a></td>
		<td align="center">#numberformat(avgX, "9.99")#</td>
		<td align="center">#numberformat(avgY, "9.99")#</td>
	</tr>
	</cfloop>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->