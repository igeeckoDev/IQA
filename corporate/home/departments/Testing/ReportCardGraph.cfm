<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Report Card">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Audit" Datasource="Corporate">
SELECT Area, OfficeName, AuditType2
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
AND AuditedBY = 'IQA'
</CFQUERY>

<cfoutput>
	<cfif Audit.AuditType2 eq "Program">
		<cfset chartLabel = Audit.Area>
	<cfelseif Audit.AuditType2 eq "Local Function">
		<cfset chartLabel = Audit.OfficeName>
	</cfif>

	<cfset chartYear = URL.Year>
</cfoutput>

<CFQUERY Name="Data" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ProgramReportCard_output.xAxis, programReportCard_output.yAxis, ProgramReportCard_Areas.AreaName
From ProgramReportCard_Output, ProgramReportCard_Areas
WHERE ProgramReportCard_output.ID = #URL.ID#
AND ProgramReportCard_output.Year_ = #URL.Year#
AND ProgramReportCard_output.AreaID = ProgramReportCard_Areas.ID
ORDER BY ProgramReportCard_output.AreaID
</CFQUERY>

<CFQUERY Name="avgData" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AVG(xAxis) as avgX, AVG(yAxis) as avgY
From ProgramReportCard_Output
WHERE ID = #URL.ID#
AND Year_ = #URL.year#
</CFQUERY>

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
                text: 'Area<br/><span style="font-size: 9px; color: #666; font-weight: normal">(Click to hide)</span>',
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
            text: '<cfoutput>Report Card - #chartYear#<br>#chartLabel#</cfoutput>'
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
       	<cfoutput query=Data>
        	{
            name: '#AreaName#',
            data: [[#xAxis#, #yAxis#]]
        	},
        </cfoutput>
		<cfoutput query=avgData>
            {
            name: 'Overall',
            data: [[#numberformat(avgX, "9.99")#, #numberformat(avgY, "9.99")#]]
            }
		</cfoutput>
    	]
    });
});
</script>

<cfoutput>
<script src="#SiteDir#SiteShared/js/highcharts.js"></script>
<script src="#SiteDir#SiteShared/js/modules/exporting.js"></script>
</cfoutput>

<div id="container" style="min-width: 800px; height: 500px; max-width: 1000px; margin: 0 auto"></div>

<cfoutput>
<a href="ReportCardGraph_Overview.cfm?ID=#URL.ID#&Year=#URL.Year#" target="_blank">View Three Year Summary</a><br><bR>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="outputOfReportData" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	ProgramReportCard_Report3.Rating, ProgramReportCard_Report3.Comments, ProgramReportCard_Areas.AreaName, ProgramReportCard_Report3.CriteriaType,
	ProgramReportCard_Areas.ID
FROM
	ProgramReportCard_Report3, ProgramReportCard_Areas
WHERE
	ProgramReportCard_Areas.ID = ProgramReportCard_Report3.AreaID
	AND ProgramReportCard_Report3.ID = #URL.ID#
	AND ProgramReportCard_Report3.Year_ = #URL.Year#
ORDER BY
	ProgramReportCard_Areas.ID, ProgramReportCard_Report3.CriteriaType
</cfquery>

<cfset AreaHolder = "">

<cfoutput query="outputOfReportData">
	<cfif AreaHolder IS NOT AreaName>
	<cfIf len(Areaholder)>
	<hr width="85%"><br>
	</cfif>

	<b><u>#AreaName#</u></b><br><br>
	</cfif>

<b>#CriteriaType#</b><br>
<u>Rating</u>: #Rating#<br>

<CFQUERY BLOCKFACTOR="100" name="getCriteria" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
select CriteriaText
from ProgramReportCard_Criteria
where AreaID = #ID#
and criteriaType = '#criteriaType#'
and Rating = #Rating#
</cfquery>

<u>Criteria:</u> #getCriteria.CriteriaText#<br>
<u>Comments:</u> #Comments#<br><br>

<cfset AreaHolder = AreaName>
</cfoutput>


<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->