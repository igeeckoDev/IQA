<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Test Chart</title>

		<Cfoutput>
		<!--[if IE]><script src="#SiteDir#SiteShared/js/excanvas.compiled.js"></script><![endif]-->
		<script type="text/javascript" src="#SiteDir#SiteShared/js/jquery-1.4.4.min.js"></script>
		</cfoutput>

<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        chart: {
            type: 'scatter',
            plotBorderWidth: 1
        },
        credits: {
        	enabled: false
        },
        title: {
            text: 'Report Card - [Year]<br>[Program / CB Name]'
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
                text: 'Effectiveness'
            }
        },
        legend: {
        	enabled: false
        },
        plotOptions: {
            series: {
            	dataLabels: {
            		enabled: true,
            		format: '{series.name}', //make it show the name
            		x: 10, // place it on the right side
            		y: 25
            	},
            },
            scatter: {
                marker: {
                    radius: 5,
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
                    pointFormat: 'Effectiveness: {point.x}, Approach: {point.y}'
                }
            }
        },
        series: [{
            name: 'Scheme Documentation',
            color: 'rgba(62,198,199,0.9)',
            data: [[2, 1]]
        }, {
            name: 'Management Review',
            color: 'rgba(176,0,219,0.9)',
            data: [[3, 4]]
        }, {
            name: 'Corrective / Preventive Action',
            color: 'rgba(0,0,219,0.9)',
            data: [[5, 2]]
		}, {
            name: 'Records',
            color: 'rgba(123,216,53,0.9)',
            data: [[3, 3]]
		}, {
            name: 'Metrics',
            color: 'rgba(255,216,53,0.9)',
            data: [[5, 5]]
		}, {
            name: 'Training',
            color: 'rgba(215,141,53,0.9)',
            data: [[1, 4]]
        }, {
            name: 'Overall',
            color: 'rgba(215,44,44,0.9)',
            data: [[3.17, 2.67]]
		}]
    });
});
</script>
	</head>
	<body>

<cfoutput>
<script src="#SiteDir#SiteShared/js/highcharts.js"></script>
<script src="#SiteDir#SiteShared/js/modules/exporting.js"></script>
</cfoutput>

<div id="container" style="min-width: 310px; height: 500px; max-width: 800px; margin: 0 auto"></div>

	</body>
</html>