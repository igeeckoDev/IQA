<ul class="arrow2">
  <li class="arrow2"><a href="index.cfm" class="arrow">IQA Admin - Home</a></li>
</ul>

<cfif left(cgi.script_name, 43) EQ "/departments/snk5212/IQA/admin/Calibration_" AND right(cgi.script_name, 4) EQ ".cfm">
<h2>Calibration Meetings Menu</h2>
<ul class="arrow2">
  <li class="arrow2"><a href="Calibration_Index.cfm" class="arrow">Home - View Meetings</a></li>
<cflock scope="Session" timeout="5">
	<cfif SESSION.Auth.AccessLevel eq "SU"
		OR SESSION.Auth.AccessLevel eq "Admin">
  <li class="arrow2"><a href="Calibration_Meeting_Add.cfm" class="arrow">Add Meeting</a></li>
	</cfif>
</cflock>
  <li class="arrow2"><a href="Calibration_ActionItems.cfm" class="arrow">All Action Items</a></li>
  <li class="arrow2"><a href="Calibration_ActionItems.cfm?View=Open" class="arrow">Open Action Items</a></li>
  <li class="arrow2"><a href="Calibration_ActionItems.cfm?View=Closed" class="arrow">Closed Action Items</a></li>
</ul>
</cfif>