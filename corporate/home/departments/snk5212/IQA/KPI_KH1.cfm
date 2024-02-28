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

<CFQUERY BLOCKFACTOR="100" NAME="KPI" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM KPI
WHERE ID = #maxID.maxID#
</CFQUERY>

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
		SumAudits: #IQAAudits#, 
		SchemeQ1: #SchemesQ1#,  
		SchemeQ2: #SchemesQ2#, 
		SchemeQ3: #SchemesQ3#, 
		SchemeQ4: #SchemesQ4#, 
		InputDate:'#dateformat(DatePosted, "mm/dd/yyyy")#', 
		PeriodEnding: '#dateformat(PeriodEnding, "mm/dd/yyyy")#',
		SchemesAudited:'Average Number of audits per Scheme: 5.47<br>Number of Schemes: #CurrentSchemeCount#<br>Total Number of Audits: #IQAAudits#', // 247 divided by 65 (Q1-2-3-4) - from prog_plan page
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

// Corrective Action Customer Survey
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
var varAVDInputs = {
	title: 'Completed Audit Projects before Anniversary Date %',
	yAxisMin: 75,
	yAxisMax: 100,
	yAxisTitle: 'Year to Date',
	redPlotTo: 85,
	yellowPlotTo: 90,
	seriesName: 'AVD',
	seriesData: QuarterlyInputs.AVD,
	BandOrder: 1
};

// Review First Pass Rate
var varFPYInputs = {
	title: 'Review First Pass Rate %',
	yAxisMin: 50,
	yAxisMax: 100,
	yAxisTitle: 'Year to Date',
	redPlotTo: 60,
	yellowPlotTo: 75,
	seriesName: 'Review FPY',
	seriesData: QuarterlyInputs.FPY,
	BandOrder: 1
};

// Average Number of Clients per DAP auditor
var varDAPAuditorsInputs = {
	title: 'Average Number of Clients per DAP auditor',
	yAxisMin: 0,
	yAxisMax: 10,
	yAxisTitle: 'Clients',
	redPlotTo: 3,
	yellowPlotTo: 4,
	seriesName: 'Clients',
	seriesData: QuarterlyInputs.DAPAudits,
	BandOrder: 1
};

// Average Number of CTF/CBTL per auditor
var varCBTLAuditorsInputs = {
	title: 'Average Number of CTF/CBTL per  auditor',
	yAxisMin: 0,
	yAxisMax: 10,
	yAxisTitle: 'Clients',
	redPlotTo: 2,
	yellowPlotTo: 2.5,
	seriesName: 'Clients',
	seriesData: QuarterlyInputs.CTFAudits,
	BandOrder: 1
};

var chart = {
  type: 'gauge',
  plotBackgroundColor: null,
  plotBackgroundImage: null,
  plotBorderWidth: 0,
  plotShadow: false
};

var pane = {
  startAngle: -120,
  endAngle: 120,
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
   $('#container3').highcharts(getChartJSON(varNPSInputs),chartFunction);
   $('#container4').highcharts(getChartJSON(varCARCSInputs),chartFunction);
   $('#container5').highcharts(getChartJSON(varEffectiveCARInputs),chartFunction);
   $('#container6').highcharts(getChartJSON(varCARlifeInputs),chartFunction);
   $('#container7').highcharts(getChartJSON(varAVDInputs),chartFunction);
   $('#container8').highcharts(getChartJSON(varFPYInputs),chartFunction);
   $('#container10').highcharts(getChartJSON(varDAPAuditorsInputs),chartFunction);
   $('#container11').highcharts(getChartJSON(varCBTLAuditorsInputs),chartFunction);

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
            data: [ QuarterlyInputs.SchemeQ1,  QuarterlyInputs.SchemeQ2, QuarterlyInputs.SchemeQ3, QuarterlyInputs.SchemeQ4]
        }, {
            name: 'Target',
            data: [16,35,54,65]
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

	<p class="KPI-Title" align="left">
		C&I Quality Engineering Key Process Indicators</p>

	<p class="blog-content" align="left">
		Updated
		<script language="JavaScript">
		document.write(QuarterlyInputs.InputDate);
		</script><br>

		KPIs represent data through 
		<script language="JavaScript">
		document.write(QuarterlyInputs.PeriodEnding);
		</script>
	</p>

	<p class="blog-date">Internal Quality Audit</p>
	<table>
	<tr>
		<td>
			<div id="container1" style="width:25%; height:300px;">IQA Survey</div>
		</td>
		<td>
			<div id="container9" style="width:400px; height: 300px; margin: 0 auto">Scheme Coverage</div>
		</td>
	</tr>
	</table>

	<br>
	View: <a href="http://usnbkiqas100p/departments/snk5212/IQA/AuditSurvey_Metrics.cfm?Year=All" target="_blank">IQA Customer Statisfaction Survey Details</a><br>
	View: <a href="http://usnbkiqas100p/departments/snk5212/IQA/prog_plan.cfm" target="_blank"> Scheme Coverage Details</a><br><br>

	<p class="blog-date">Corrective Action Process</p>
	<table>
	<tr>
		<td>
			<div id="container4" style="width:22%; height:300px;"></div>
		</td>
		<td>
			<div id="container5" style="width:22%; height:300px;"></div>
		</td>
		<td>
			<div id="container6" style="width:22%; height:300px;"></div>
		</td>
		<td>
			<div id="container2" style="width:22%; height:300px;"></div>
		</td>
	</tr>
	</table>

	<br>
	View: <a href="http://usnbkiqas100p/departments/snk5212/IQA/CARSurvey_Metrics.cfm?Year=All" target="_blank">Corrective Action Customer Survey Details</a><br>
	View: <a href="http://usnbkiqas100p/departments/snk5212/IQA/CARSurvey_Metrics.cfm?Year=All" target="_blank">GCAR Metrics Data</a><br><Br>

	<p class="blog-date">DAP/CTF/External CBTL Audit</p>
	<table>
	<tr>
		<td>
			<div id="container3" style="width:25%; height:300px;"></div>
		</td>
		<!---
			<td>
				<div id="container8" style="width:25%; height:200px;"></div>
			</td>
		--->
		<td>
			<div id="container7" style="width:25%; height:300px;"></div>
		</td>

	</tr>
	</table>

<br><br>
	<p class="blog-date">DAP/CTF/External CBTL Audit Resource</p>
	<table>
	<tr>
		<td>
			<div id="container10" style="width:25%; height:300px;"></div>
		</td>
		<td>
			<div id="container11" style="width:25%; height:300px;"></div>
		</td>

	</tr>
	</table><br><br>

<b>Data Refresh Schedule</b><br>
All KPIs are updated monthly; except for Schemes/Programs Coverage (Quarterly).<br><br>
	
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->