<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor Requests - View">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			  
<cflock scope="SESSION" timeout="60">
    <CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
        SELECT * 
        FROM AuditorList
		WHERE 
		<cfif SESSION.Auth.AccessLevel is "RQM">
		(Region = '#SESSION.AUTH.Region#' <cfif SESSION.AUth.Region is "Europe">OR Region = 'Latin America'</cfif>) AND
	        </cfif>
        Status = 'Requested'
        ORDER BY status, SubRegion, Status
    </cfquery>
        
    <!--- AND Status NOT IN ('Active', 'Inactive', 'In Training', 'Suspended') --->
</cflock>

<table width="650" border="1" cellpadding="1" cellspacing="1" valign="top">
	 <tr align="center" valign="top">
		<td width="35%" class="sched-title">Auditor Name and Profile</td>
		<td width="25%" class="sched-title">Location</td>
		<td width="25%" class="sched-title">Region</td>
		<td width="15%" class="sched-title">Status</td>
	 </tr>
	<CFOUTPUT QUERY="AuditorProfile">
	<tr>
		<td width="35%" class="sched-content">#Auditor# - <a href="Aprofiles_detail.cfm?ID=#ID#">View</a></td>
		<td width="25%" class="sched-content">#Location#</td>
		<td width="25%" class="sched-content">#SubRegion#</td>
		<td width="15%" class="sched-content">#Status#&nbsp;</td>
	</tr>
	</CFOUTPUT>																													
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->