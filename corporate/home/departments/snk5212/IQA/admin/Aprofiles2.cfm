<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
	SELECT * FROM AuditorList
	WHERE Status <> 'NotApproved' AND Status <> 'Denied'
	ORDER BY SubRegion, Status, LastName
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "RQM" OR SESSION.Auth.AccessLevel is "OQM">
<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
	SELECT * FROM AuditorList
	WHERE SubRegion = '#SESSION.AUTH.SubRegion#'
	AND Status <> 'NotApproved' AND Status <> 'Denied'
	ORDER BY SubRegion, Status, LastName
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "Europe">
<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
	SELECT * FROM AuditorList
	WHERE SubRegion = 'NUKE' OR SubRegion = 'Central Europe' OR SubRegion = 'Mediterranean'
	AND Status <> 'NotApproved' AND Status <> 'Denied'
	ORDER BY SubRegion, Status, LastName
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "Asia Pacific">
<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
	SELECT * FROM AuditorList
	WHERE SubRegion = 'China' OR SubRegion = 'Japan' OR SubRegion = 'Korea' OR SubRegion = 'Taiwan' OR SubRegion = 'Hong Kong' OR SubRegion = 'SMI'
	AND Status <> 'NotApproved' AND Status <> 'Denied'
	ORDER BY SubRegion, Status, LastName
</cfquery>
<cfelse>
</cfif>
</cflock>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Auditor List">
<cfinclude template="SOP.cfm">

<!--- / --->

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin">
<br><p><a href="Aprofiles_add.cfm">Add</a> a new Auditor.</p>
<cfelse>
</CFIF>
</cflock>
						  
<table width="650" border="1" cellpadding="1" cellspacing="1" valign="top">

						 <tr align="center" valign="top">
							<td width="35%" class="sched-title">Auditor Name and Profile</td>
							<td width="25%" class="sched-title">Location</td>
							<td width="25%" class="sched-title">Region</td>
							<td width="15%" class="sched-title">Status</td>
							
						 </tr>
			

						<CFOUTPUT QUERY="AuditorProfile">
						<CFIF Trim(Auditor) is NOT "- None -">
						<tr>
							<td width="35%" class="sched-content">#Auditor# - <a href="Aprofiles_detail.cfm?ID=#ID#">View Profile</a></td>
							<td width="25%" class="sched-content">#Location#</td>
							<td width="25%" class="sched-content">#SubRegion#</td>
							<td width="15%" class="sched-content">#Status#&nbsp;</td>
						</tr>
						<cfelse>
						</cfif>
						</CFOUTPUT>
																															
</table>

 
						  
 <br>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->