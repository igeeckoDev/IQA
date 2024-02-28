<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" NAME="CARAdmins" DataSource="Corporate">
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 4eb954af-824f-4246-813e-8ba9e1e4d3bc Variable Datasource name --->
SELECT * FROM CARAdminList
ORDER BY Status, LastName
<!---TODO_DV_CORP_002_End: 4eb954af-824f-4246-813e-8ba9e1e4d3bc Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
		<a href="CARAdminAdd.cfm">Add a CAR Administrator</a><br><Br>
	</cfif>
</cflock>

<table width="650" border="1" valign="top" style="border-collapse: collapse;">

 <tr align="center" valign="top">
	<td class="sched-title">CAR Administrator</td>
	<td class="sched-title">Backup</td>
	<td class="sched-title">CAR Trainer</td>
 </tr>
<cfset curStatus = "">
<CFOUTPUT QUERY="CARAdmins">
<cfif curStatus IS NOT Status>
<cfIf curStatus is NOT ""><br></cfif>
</td></tr><tr><td class="sched-title" align="center" colspan="3">Status - #Status#</cfif>
 <tr>
	<td class="sched-content" valign="top">
	#Name#
	<cflock scope="Session" timeout="5">
		<cfif isDefined("Session.Auth.IsLoggedIn")>
			 - <a href="#CARAdminDir#CARAdminView.cfm?ID=#ID#">View Profile</a>
		</cfif>
	</cflock>
	</td>

<CFQUERY BLOCKFACTOR="100" NAME="Backup" DataSource="Corporate">
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 9875af86-f6c4-4674-a6c5-b90052b189fe Variable Datasource name --->
SELECT ID, Name FROM CARAdminList
WHERE ID = #CARAdmins.Backup#
<!---TODO_DV_CORP_002_End: 9875af86-f6c4-4674-a6c5-b90052b189fe Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
	<td class="sched-content" valign="top"><cfif backup eq 0>None Listed<cfelse>#Backup.Name#</cfif></td>

	<td class="sched-content" valign="top" align="center"><cfif Trainer is "Yes">Yes<cfelse>--</cfif></td>
 </tr>
 <cfset curStatus = Status>
</CFOUTPUT>

</table>