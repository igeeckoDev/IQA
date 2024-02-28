    <CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
        SELECT * FROM AuditorList
        WHERE 
        <cfif isdefined("url.view")>
            <cfif url.view is "ALL">
            (Status = 'Active' OR Status = 'Inactive' OR Status = 'In Training')
            <cfelseif url.view is "Active">
            Status = 'Active'
            <cfelseif url.view is "Inactive">
            Status = 'Inactive'
            <cfelseif url.view is "In Training">
            Status = 'In Training'
            <cfelseif url.view is "Field Services">
            Region = 'Field Services'
            <cfelseif url.view is "Lead">
            Lead = 'Yes'
            </cfif>
        <cfelse>
	        (Status = 'Active' OR Status = 'Inactive' OR Status = 'In Training')
        </cfif>
        ORDER BY Status, SubRegion, LastName
	</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>
						  
<br>
<div class="blog-time">Auditor List Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditorlist.cfm')">[?]</A></div><br>

View:<br>
<cfif isdefined("url.view")>
<cflock scope="SESSION" timeout="5">
	<CFIF SESSION.Auth.AccessLevel is "Field Services">
		&nbsp;&nbsp;:: <cfif url.view is NOT "Field Services"><a href="Aprofiles.cfm?view=Field Services">Field Services</a><cfelse><b>Field Services</b></cfif> Auditor Profiles<br><br>
        <a href="Aprofiles_add.cfm">Add</a> a new Auditor<br>
	<cfelse>
        &nbsp;&nbsp;:: <cfif url.view is NOT "All"><a href="Aprofiles.cfm?view=All">All</a><cfelse><b>All</b></cfif> Auditor Profiles<br>
        &nbsp;&nbsp;:: <cfif url.view is NOT "Active"><a href="Aprofiles.cfm?view=Active">Active</a><cfelse><b>Active</b></cfif> Auditor Profiles<br>
        &nbsp;&nbsp;:: <cfif url.view is NOT "Inactive"><a href="Aprofiles.cfm?view=Inactive">Inactive</a><cfelse><b>Inactive</b></cfif> Auditor Profiles<br>
        &nbsp;&nbsp;:: <cfif url.view is NOT "In Training"><a href="Aprofiles.cfm?view=In Training">In Training</a><cfelse><b>In Training</b></cfif> Auditor Profiles<br>
        &nbsp;&nbsp;:: <cfif url.view is NOT "Lead"><a href="Aprofiles.cfm?view=Lead">Lead Auditors</a><cfelse><b>Lead Auditors</b> - </cfif> Auditor Profiles<br>
	</cfif>
</cflock>
</cfif>

<cflock scope="SESSION" timeout="5">
	<CFIF SESSION.Auth.AccessLevel is "SU">
		<br><a href="Aprofiles_add.cfm">Add</a> a new Auditor
	</CFIF>
</cflock>
<br><Br>

<table width="650" border="1" cellpadding="1" cellspacing="1" valign="top">

 <tr align="center" valign="top">
	<td width="35%" class="sched-title">Auditor Name and Profile</td>
	<td width="25%" class="sched-title">
<cflock scope="SESSION" timeout="5">
	<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
	    Sub Region
    <cfelse>
    	Location
    </cfif>
</cflock>
	</td>
	<td width="25%" class="sched-title">Qualified</td>
	<td width="15%" class="sched-title">Status</td>
	
 </tr>
<CFOUTPUT QUERY="AuditorProfile">
	<tr>
        <td width="35%" class="sched-content" valign="top">#Auditor# - <a href="Aprofiles_detail.cfm?ID=#ID#">View Profile</a></td>
		<td width="25%" class="sched-content" valign="top">
			<cfif Region is "Field Services">
            	Field Services
            <cfelse>
                <cflock scope="SESSION" timeout="5">
                	<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
                		#SubRegion#
                	<cfelse>
                		#Location#
                	</cfif> 
					<cfif IQA eq "Yes">(IQA)</cfif>
				</cflock>
			</cfif>
		</td>
		<td width="25%" class="sched-content" valign="top">
<cfif isDefined("Lead")>
	<cfif Lead eq 1>
	Lead Auditor<br>
	</cfif>
</cfif>
<cfset Dump = #replace(Qualified, ",", "<br>", "All")#>
<cfset Dump1 = #replace(Dump, "- None -", "None", "All")#>
<cfif len(dump1)>
#Dump1#
<cfelse>
No Qualifications Listed
</cfif>
</td>
<td width="15%" class="sched-content" valign="top">#Status#&nbsp;</td>
</tr>
</CFOUTPUT>
																															
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->