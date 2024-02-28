<CFQUERY BLOCKFACTOR="100" NAME="CARAdmins" DataSource="Corporate">
SELECT * FROM CARAdminList
WHERE STATUS <> 'Removed'
<cflock scope="Session" timeout="5">
	<cfif NOT isDefined("Session.Auth.IsLoggedIn")>
		AND STATUS <> 'Suspended'
    <cfelseif isDefined("Session.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel neq "SU">
       	AND STATUS <> 'Suspended'
	</cfif>
</cflock>
ORDER BY Status, LastName
</cfquery>

<!---<cfinclude template="inc_TOP.cfm">--->

<cfoutput>
<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
		<a href="#CARRootDir#admin/CARAdminAdd.cfm">Add a CAR Administrator</a><br><Br>
	</cfif>
</cflock>
</cfoutput>

View:<br>
 - <a href="CARAdminList.cfm#Active">Active</a><br>
 - <a href="CARAdminList.cfm#Inactive">Inactive</a><br>
 - <a href="CARAdminList.cfm#In Training">In Training</a><br>
 - <a href="CARAdminList.cfm#CAR Administration Support">CAR Administration Support</a><Br />
<cfif isDefined("Session.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
 - <a href="CARAdminList.cfm#Suspended">Suspended</a>
</cfif>

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
	</td></tr><tr><td class="sched-title" align="center" colspan="3">Status - #Status#
<a name="#status#"></a></cfif>
 <tr>
	<td class="sched-content" valign="top">
	#Name#
	<cflock scope="Session" timeout="5">
		<cfif isDefined("Session.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
			 - <a href="#CARAdminDir#CARAdminView.cfm?ID=#ID#">View Profile</a>
		</cfif>
	</cflock>
	</td>

<CFQUERY BLOCKFACTOR="100" NAME="Backup" DataSource="Corporate">
SELECT ID, Name FROM CARAdminList
WHERE ID = #CARAdmins.Backup#
</cfquery>
	<td class="sched-content" valign="top"><cfif backup eq 0>None Listed<cfelse>#Backup.Name#</cfif></td>

	<td class="sched-content" valign="top" align="center">
		<cfif Trainer is "Yes">
			CAR Trainer
		<cfelse>
			<cfif Status is "In Training">
				<cfif len(CARTrainer)>
					CAR Trainer - #CARTrainer#
				<cfelse>
					--
				</cfif>
			<cfelse>
				--
			</cfif>
		</cfif>
	</td>
 </tr>
<cfset curStatus = Status>
</CFOUTPUT>
</table>