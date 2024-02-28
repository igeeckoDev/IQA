<cfoutput>
<br>
	<cfif url.showPerf eq "Yes">
		<b>CAR Performance Legend</b><br>
		For CARs with <B>#perfvarLabel#</B><br>
		<img src="images/green_dot.jpg" height="8"> :: Greater than or equal to #NumberFormat(green * 100, "999.9")#% - Acceptable<br>
		<img src="images/yellow_dot.jpg" height="8"> :: Less than #NumberFormat(green * 100, "999.9")#% and greater than or equal to #NumberFormat(red * 100, "999.9")#% - Improvement Recommended<br>
		<img src="images/red_dot.jpg" height="8"> :: Less than #NumberFormat(red * 100, "999.9")#% - Improvement Required<br><br>
	</cfif>

<b><cfif url.showPerf eq "No">Add<cfelse>Change</cfif> CAR Performance Data</b>:<br>

<u>Escalation</u><br>
 - CARS with <a href="#CGI.Script_Name#?#queryString1#&showPerf=Yes&Perf=Escalations&perfVar=Response">No Response Escalations</a><br>
 - CARS with <a href="#CGI.Script_Name#?#queryString1#&showPerf=Yes&Perf=Escalations&perfVar=Implementation">No Implementation Escalations</a><br><br>

<u>Overdue</u><br>
 - CARS with <a href="#CGI.Script_Name#?#queryString1#&showPerf=Yes&Perf=Overdue&perfVar=Response">No Overdue Response Notifications</a><br>
 - CARS with <a href="#CGI.Script_Name#?#queryString1#&showPerf=Yes&Perf=Overdue&perfVar=Implementation">No Overdue Implementation Notifications</a><br><br>
</cfoutput>