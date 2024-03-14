<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<CFQUERY BLOCKFACTOR="100" NAME="maxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID) as maxID
FROM KPI
</CFQUERY>

<cfif isdefined("URL.ID")>
	<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT *
	FROM KPI
	WHERE ID = #URL.ID#
	</CFQUERY>
<cfelse>
	<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT *
	FROM KPI
	WHERE ID = #maxID.maxID#
	</CFQUERY>
</cfif>

<cfif isdefined("URL.ID")>
	<font class="warning">
		<cfif URL.ID neq maxID.maxID AND URL.ID neq 0>
			Note - This is HISTORICAL DATA.<br>
			View Published KPI Data - <b><a href="KPI.cfm">Published KPI Data</a></b>
		<cfelseif URL.ID eq 0>
			Note - This is DRAFT KPI DATA.<br>
			View Published KPI Data - <b><a href="KPI.cfm">Published KPI Data</a></b>
		</cfif><br><br>
	</font>
</cfif>
	
<!--- 2016 planned schemes per quarter: 16,35,54,65 --->

<cfoutput query="KPI">
	<script language="JavaScript">
	var QuarterlyInputs= {
		IQASurvey: #IQASurvey#, 
		AveragerObservation: #CARObservationMedian#, 
		NPS: #NPS#, 
		CARSurvey: #CARSurvey#, 
		EffectiveCAR: #CARVerifiedEffective#, 
		CARLife: #CARFindingMedian#, 
		AVD: #AVD#, 
		FPY: 0, // Currently not applicable
		DAPAudits: #DAPAudits#, 
		CTFAudits: #CTFAudits#, 
		SchemeQ1: #SchemesQ1#,  
		SchemeQ2: #SchemesQ2#, 
		SchemeQ3: #SchemesQ3#, 
		SchemeQ4: #SchemesQ4#, 
		SchemeQ1_Planned: #PlannedSchemesQ1#,  
		SchemeQ2_Planned: #PlannedSchemesQ2#, 
		SchemeQ3_Planned: #PlannedSchemesQ3#, 
		SchemeQ4_Planned: #PlannedSchemesQ4#, 
		InputDate:'#dateformat(DatePosted, "mm/dd/yyyy")#', 
		PeriodEnding: '#dateformat(PeriodEnding, "mm/dd/yyyy")#',
		SchemesAudited:'Average Number of audits per Scheme: #avgAuditsPerScheme#<br>Number of Schemes: #CurrentSchemeCount#', // 247 divided by 65 (Q1-2-3-4) - from prog_plan page
		CurrentSchemes: #CurrentSchemeCount# // on prog_plan.cfm - re-run for update
	};
	</script>
</cfoutput>	

<script language="JavaScript">

// IQA Customer Satifaction Survey
var varIQACustomerSatisfactionInputs = {
	title: 'IQA Customer Satifaction Survey',
	yAxisMin: 2.5,
	yAxisMax: 5,
	yAxisTitle: 'Year to Date',
	redPlotTo: 3.0,
	yellowPlotTo: 4,
	seriesName: 'IQA Survey Results',
	seriesData: QuarterlyInputs.IQASurvey,
	BandOrder: 1
};

// Median Duration of Corrective Actions for Observations
var varTestInputs = {
	title: 'Median Duration of Corrective Actions for Observations',
	yAxisMin: 0,
	yAxisMax: 120,
	yAxisTitle: 'Days',
	redPlotTo: 90,
	yellowPlotTo: 60,
	seriesName: 'Observations',
	seriesData: QuarterlyInputs.AveragerObservation,
	BandOrder: 0
};

// DAP/CTF/External CBTL Audit NPS
var varNPSInputs = {
	title: 'DAP/CTF/External CBTL<br>Audit NPS',
	yAxisMin: 0,
	yAxisMax: 100,
	yAxisTitle: 'Year to Date',
	redPlotTo: 15,
	yellowPlotTo: 40,
	seriesName: 'NET Promote Score',
	seriesData: QuarterlyInputs.NPS,
	BandOrder: 1
};

// Corrective Action Customer Satisfaction Survey
var varCARCSInputs = {
	title: 'Corrective Action Customer Survey',
	yAxisMin: 2.5,
	yAxisMax: 5,
	yAxisTitle: 'Year to Date',
	redPlotTo: 3.0,
	yellowPlotTo: 3.5,
	seriesName: 'CAR Survey',
	seriesData: QuarterlyInputs.CARSurvey,
	BandOrder: 1
};

// Effectively Closed CAR %
var varEffectiveCARInputs = {
	title: 'Effectively Closed CAR<br>Percentage',
	yAxisMin: 76,
	yAxisMax: 100,
	yAxisTitle: 'Year to Date',
	redPlotTo: 80,
	yellowPlotTo: 92,
	seriesName: 'Effective CAR Percentage',
	seriesData: QuarterlyInputs.EffectiveCAR,
	BandOrder: 1
};

// Median Duration of Corrective Actions for Finding
var varCARlifeInputs = {
	title: 'Median Duration of Corrective Actions for Finding',
	yAxisMin: 0,
	yAxisMax: 300,
	yAxisTitle: 'Days',
	redPlotTo: 240,
	yellowPlotTo: 180,
	seriesName: 'Days',
	seriesData: QuarterlyInputs.CARLife,
	BandOrder: 0
};

// Completed Audit Projects before Anniversary Date %


var chart = {
  type: 'gauge',
  plotBackgroundColor: null,
  plotBackgroundImage: null,
  plotBorderWidth: 0,
  plotShadow: false,
  spacingBottom: 0,
  spacingTop: 0,
  spacingLeft: 0,
  spacingRight: 0
};

var pane = {
  startAngle: -120,
  endAngle: 120,
  center: ['50%', '50%'],
  size:[200],
  background: [{
	 backgroundColor: {
		linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
		stops: [
		   [0, '#FFF'],
		   [1, '#333']
		]
	 },
	 borderWidth: 0,
	 outerRadius: '109%'
  }, {
	 backgroundColor: {
		linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
		stops: [
		   [0, '#333'],
		   [1, '#FFF']
		]
	 },
	 borderWidth: 1,
	 outerRadius: '117%'
 }, {
	 // default background
 }, {
	 backgroundColor: '#DDD',
	 borderWidth: 0,
	 outerRadius: '110%',
	 innerRadius: '103%'
 }]
};

function getYAxis(argMin, argMax, argTitle, redPlotTo, yellowPlotTo, BandOrder) {
if (BandOrder >= 1) {
	var yAxis = {
		  min: argMin,
		  max: argMax,

		  minorTickInterval: 'auto',
		  minorTickWidth: 1,
		  minorTickLength: 10,
		  minorTickPosition: 'inside',
		  minorTickColor: '#666',

		  tickPixelInterval: 30,
		  tickWidth: 2,
		  tickPosition: 'inside',
		  tickLength: 15,
		  tickColor: '#666',
		  labels: {
			 step: 2,
			 rotation: 'auto'
		  },
		  title: {
			 text: argTitle
		  },
		  plotBands: [{
			 from: yellowPlotTo,
			 to: argMax,
			 color: '#55BF3B' // green
		  }, {
			 from: redPlotTo,
			 to: yellowPlotTo,
			 color: '#DDDF0D' // yellow
		  }, {
			 from: argMin,
			 to: redPlotTo,
			 color: '#DF5353' // red
		  }]

		  };

	return yAxis;
	} else {
	var yAxis = {
		  min: argMin,
		  max: argMax,

		  minorTickInterval: 'auto',
		  minorTickWidth: 1,
		  minorTickLength: 10,
		  minorTickPosition: 'inside',
		  minorTickColor: '#666',

		  tickPixelInterval: 30,
		  tickWidth: 2,
		  tickPosition: 'inside',
		  tickLength: 15,
		  tickColor: '#666',
		  labels: {
			 step: 2,
			 rotation: 'auto'
		  },
		  title: {
			 text: argTitle
		  },
		  plotBands: [{
			 from: argMin,
			 to: yellowPlotTo,
			 color: '#55BF3B' // green
		  }, {
			 from: yellowPlotTo,
			 to: redPlotTo,
			 color: '#DDDF0D' // yellow
		  }, {
			 from: redPlotTo,
			 to: argMax,
			 color: '#DF5353' // red
		  }]

		  };

	return yAxis;

	};
}

function getChartJSON(chartInputs) {
   var series= [{
        name: chartInputs.seriesName,
        data: [chartInputs.seriesData],
        tooltip: {
           valueSuffix: ' '
        }
   }];

   var json = {};
   json.chart = chart;
   json.credits = {enabled:false};
   json.title = {text: chartInputs.title};    		// vary per graph
   json.pane = pane;
   json.yAxis = getYAxis(chartInputs.yAxisMin,
						chartInputs.yAxisMax,
						chartInputs.yAxisTitle,
						chartInputs.redPlotTo,
						chartInputs.yellowPlotTo,
						chartInputs.BandOrder);	// vary per graph
   json.series = series;  							// vary per graph

   return json;
}

$(document).ready(function() {
   // Add some life
   var chartFunction = function (chart) {
         setInterval(function () {
			var point = chart.series[0].points[0], 
			newVal, 
			inc = 0;

			newVal = point.y + inc;

        point.update(newVal);
         }, 3000);
		};

   $('#container1').highcharts(getChartJSON(varIQACustomerSatisfactionInputs),chartFunction);
   $('#container2').highcharts(getChartJSON(varTestInputs),chartFunction);
   $('#container4').highcharts(getChartJSON(varCARCSInputs),chartFunction);
   $('#container5').highcharts(getChartJSON(varEffectiveCARInputs),chartFunction);
   $('#container6').highcharts(getChartJSON(varCARlifeInputs),chartFunction);
   
     });
</script>

<script language="JavaScript">
$(document).ready(function() {
   var chart = {
      type: 'column'
   };
   var title = {
      text: 'Schemes/Programs Coverage'
   };
   var subtitle = {
      text: QuarterlyInputs.SchemesAudited
   };
   var xAxis = {
      categories: [' Q 1','Q 2','Q 3','Q 4'],
      crosshair: true
   };
   var yAxis = {
      min: 0,
      title: {
         text: 'Number of Schemes'
      }
   };
   var tooltip = {
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
         '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
      footerFormat: '</table>',
      shared: true,
      useHTML: true
   };
   var plotOptions = {
      column: {
         pointPadding: 0.2,
         borderWidth: 0
      }
   };
   var credits = {
      enabled: false
   };

   var series= [{
        name: 'Actual',
            data: [QuarterlyInputs.SchemeQ1, QuarterlyInputs.SchemeQ2, QuarterlyInputs.SchemeQ3, QuarterlyInputs.SchemeQ4]
        }, {
            name: 'Target',
            data: [QuarterlyInputs.SchemeQ1_Planned, QuarterlyInputs.SchemeQ2_Planned, QuarterlyInputs.SchemeQ3_Planned, QuarterlyInputs.SchemeQ4_Planned]
   }];

   var json = {};
   json.chart = chart;
   json.title = title;
   json.subtitle = subtitle;
   json.tooltip = tooltip;
   json.xAxis = xAxis;
   json.yAxis = yAxis;
   json.series = series;
   json.plotOptions = plotOptions;
   json.credits = credits;
   $('#container9').highcharts(json);
});


</script>

	<div class="KPI-Title" align="left">
		 IQA and CAR Key Process Indicators</div>

	<div class="blog-content" align="left">
		KPIs represent data through 
		<script language="JavaScript">
		document.write(QuarterlyInputs.PeriodEnding);
		</script><Br>
		
		Updated
		<script language="JavaScript">
		document.write(QuarterlyInputs.InputDate);
		</script>
	</div><br><br>

	<p class="blog-date">Internal Quality Audit
	<table border=0 width=700>
		<tr>
			<td width=50%>
				<div id="container1">IQA Survey</div>
			</td>
			<td>
				<div id="container9">Scheme Coverage</div>
			</td>
		</tr>
	</table>
	</p>
	
	<p class="blog-date">Corrective Action Process</p>
	<table border=0 width=1400>
		<tr>
			<td width=25%>
				<div id="container4"></div>
			</td>
			<td width=25%>
				<div id="container5"></div>
			</td>
			<td width=25%>
				<div id="container6"></div>
			</td>
			<td width=25%>
				<div id="container2"></div>
			</td>
		</tr>
	</table>
	<cfoutput>
	<br>
	View: <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/CARSurvey_Metrics.cfm?Year=All" target="_blank">Corrective Action Customer Survey Details</a><br>
	View: <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/CARSurvey_Metrics.cfm?Year=All" target="_blank">GCAR Metrics Data</a><br><Br>

	

<table border=0 width=800>	
<tr>
<td>
<b><u>Notes and Definitions</u></b><br><br>

<b>Internal Quality Audit</b><br>
<u>IQA Customer Satisfaction Survey</u><br>
Audit recipients receive a survey at the completion of each IQA audit. The results can be viewed here: <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/AuditSurvey_Metrics.cfm?Year=All" target="_blank">IQA Customer Satisfaction Survey Details</a>
<br><br>

<u>Schemes/Programs Coverage</u><br>
This chart shows the number of schemes that are planned to be audited at the beginning of the year (Target). The "Actual" represents the number of schemes that were covered throughout the year. The number may be different than the "Target" due to the addition of new schemes by UL throughout the year.<br><br>

Above the chart, there are several calculations. The number of current number of schemes is listed, as well as the total number of IQA audits, and the "Average Number of Audits per Scheme" shows how many times we audit a scheme throughout the year.<br><br>
View: <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/prog_plan.cfm" target="_blank"> Scheme Coverage Details</a><br><br>
	
<b>Corrective Action Process</b><br>
<u>Corrective Action Customer Satisfaction Survey</u><br>
CAR Owners receive a survey when a CAR reaches the "Closed - Awaiting Verification" state. The results can be viewed here: <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/CARSurvey_Metrics.cfm?Year=All" target="_blank">Corrective Action Customer Satisfaction Survey</a>.
<br><br>
</cfoutput>
<u>Median Duration of Corrective Actions for Findings</u><br>
The median length of time in days that Findings are open. This calculation is from the date the CAR was submitted in the CAR DB, to the date that it reached "Closed Awaiting Verification" state.
<br><br>

<u>Median Duration of Corrective Actions for Observations</u><br>
The median length of time in days that Observations are open. This calculation is from the date the CAR was submitted in the CAR DB, to the date that it reached "Closed Awaiting Verification" state.
<br><br>

<u>Effectively Closed CAR Percentage</u><br>
This data reflects the percentage of effectively verified (closed) CARs, for CARs closed during the last 36 months (3 years). This does not include open CARs.
<br><br>


<b>KPI Data Details</b><br>
<u>Data Refresh Schedule</u><br>
All KPIs are updated monthly; except for Schemes/Programs Coverage (Quarterly).<br><br>
</td>
</tr>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->