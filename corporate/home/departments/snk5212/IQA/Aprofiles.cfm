<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor List - Auditor Profiles">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif NOT isdefined("url.view")>
	<cfset url.view = "All">
</cfif>

   <cflock scope="session" timeout="6">
       <cfif isDefined("SESSION.Auth.isLoggedIn")>
           <cfif SESSION.Auth.AccessLevel eq "SU"
               OR SESSION.Auth.AccessLevel eq "Admin"
               OR SESSION.Auth.AccessLevel eq "IQAAuditor">
               <cfoutput>
                   You are currently logged in:<br />
                   Go To <b><a href="#IQADir_Admin#AProfiles.cfm?#CGI.QUERY_STRING#">Admin View</a></b><br /><br />
               </cfoutput>
           </cfif>
       </cfif>
   </cflock>

<CFQUERY BLOCKFACTOR="100" NAME="AuditorList" Datasource="Corporate">
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
            <cfelseif url.view is "IQA">
            IQA = 'Yes'
			<!--- DAP --->
		    <cfelseif url.view is "DAP Reviewer">
		    Qualified LIKE '%DAP Reviewer%'
		    <cfelseif url.view is "DAP Qualifier">
		    Qualified LIKE '%DAP Qualifier%'
		    <cfelseif url.view is "DAP Trainer">
		    Qualified LIKE '%DAP Trainer%'
		    <cfelseif url.view is "DAP Lead Auditor">
		    Qualified LIKE '%DAP Lead Auditor%'
		    <!--- CBTL--->
		    <cfelseif url.view is "CBTL Reviewer">
		    Qualified LIKE '%CBTL Reviewer%'
		    <cfelseif url.view is "CBTL Qualifier">
		    Qualified LIKE '%CBTL Qualifier%'
		    <cfelseif url.view is "CBTL Trainer">
		    Qualified LIKE '%CBTL Lead Auditor%'
		    <cfelseif url.view is "CBTL Lead Auditor">
		    Qualified LIKE '%CBTL Lead Auditor%'
		    <!--- CTF --->
		    <cfelseif url.view is "CTF Reviewer">
		    Qualified LIKE '%CTF Reviewer%'
		    <cfelseif url.view is "CTF Qualifier">
		    Qualified LIKE '%CTF Qualifier%'
		    <cfelseif url.view is "CTF Trainer">
		    Qualified LIKE '%CTF Trainer%'
		    <cfelseif url.view is "CTF Lead Auditor">
		    Qualified LIKE '%CTF Lead Auditor%'
		    <!--- OSHA SNAP Project Review --->
	        <cfelseif url.view is "SNAPQualified">
	        QualifiedSNAP = 'Yes'
	        <!--- Certification  Project Review --->
			<cfelseif url.view is "CertQualified">
	        QualifiedCert = 'Yes'
			<!--- if something is listed in url.view but its not listed above... show all --->
		    <cfelse>
		    (Status = 'Active' OR Status = 'Inactive' OR Status = 'In Training')
            </cfif>
		<!--- if there is no url.view variable whatsoever, show all --->
        <cfelse>
	        (Status = 'Active' OR Status = 'Inactive' OR Status = 'In Training')
        </cfif>
	ORDER BY IQA DESC, Status, Region, SubRegion, LastName
</cfquery>

<script language="JavaScript" src="webhelp/webhelp.js"></script>

<br>
<div class="blog-time">Auditor List Help - <A HREF="javascript:popUp('webhelp/webhelp_auditorlist.cfm')">[?]</A></div><br>

<u>View Internal Quality Auditors</u><br>
<cfif isdefined("url.view")>
        &nbsp;&nbsp;:: <cfif url.view is NOT "All"><a href="Aprofiles.cfm?view=All">All</a><cfelse><b>All</b></cfif><br>
        &nbsp;&nbsp;:: <cfif url.view is NOT "Active"><a href="Aprofiles.cfm?view=Active">Active</a><cfelse><b>Active</b></cfif><br>
        &nbsp;&nbsp;:: <cfif url.view is NOT "Inactive"><a href="Aprofiles.cfm?view=Inactive">Inactive</a><cfelse><b>Inactive</b></cfif><br>
        &nbsp;&nbsp;:: <cfif url.view is NOT "In Training"><a href="Aprofiles.cfm?view=In Training">In Training</a><cfelse><b>In Training</b></cfif><br>
        &nbsp;&nbsp;:: <cfif url.view is NOT "Lead"><a href="Aprofiles.cfm?view=Lead">Lead Auditors</a><cfelse><b>Lead Auditors</b></cfif><br>
        &nbsp;&nbsp;:: <cfif url.view is NOT "IQA"><a href="Aprofiles.cfm?view=IQA">IQA Auditors</a><cfelse><b>IQA Auditors</b></cfif><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "SNAPQualified"><a href="Aprofiles.cfm?view=SNAPQualified">OSHA SNAP Project Review Auditors</a><cfelse><b>OSHA SNAP Project Review Auditors</b></cfif><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "CertQualified"><a href="Aprofiles.cfm?view=CertQualified">US/Canada Safety Scheme - Certification Project Review Auditors</a><cfelse><b>US/Canada Safety Scheme - Certification Project Review Auditors</b></cfif><br><br>

Note - All Active/Qualified IQA Auditors have "OSHA SNAP Project Review" and "US/Canada Safety Scheme - Certification Project Review" Qualification. These are listed separately for staff that are listed as "IQA Auditors In-Training".<br><br>

		<u>DAP</u><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "DAP Reviewer"><a href="Aprofiles.cfm?view=DAP Reviewer">DAP Reviewers</a><cfelse><b>DAP Reviewers</b></cfif><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "DAP Qualifier"><a href="Aprofiles.cfm?view=DAP Qualifier">DAP Qualifiers</a><cfelse><b>DAP Qualifiers</b></cfif><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "DAP Trainer"><a href="Aprofiles.cfm?view=DAP Trainer">DAP Trainers</a><cfelse><b>DAP Trainers</b></cfif><br>
		&nbsp;&nbsp;:: See 00-OP-S0056 for DAP Lead Auditor Details<br><br>
		<!---
		&nbsp;&nbsp;:: <cfif url.view is NOT "DAP Lead Auditor"><a href="Aprofiles.cfm?view=DAP Lead Auditor">DAP Lead Auditor</a><cfelse><b>DAP Lead Auditor</b></cfif><br>
		--->

		<u>CBTL</u><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "CBTL Reviewer"><a href="Aprofiles.cfm?view=CBTL Reviewer">CBTL Reviewers</a><cfelse><b>CBTL Reviewers</b></cfif><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "CBTL Qualifier"><a href="Aprofiles.cfm?view=CBTL Qualifier">CBTL Qualifiers</a><cfelse><b>CBTL Qualifiers</b></cfif><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "CBTL Trainer"><a href="Aprofiles.cfm?view=CBTL Trainer">CBTL Trainers</a><cfelse><b>CBTL Trainers</b></cfif><br>
		&nbsp;&nbsp;:: See 00-OP-S0056 for CBTL Lead Auditor Details<br><br>
		<!---
		&nbsp;&nbsp;:: <cfif url.view is NOT "CBTL Lead Auditor"><a href="Aprofiles.cfm?view=CBTL Lead Auditor">CBTL Lead Auditor</a><cfelse><b>CBTL Lead Auditor</b></cfif><br>
		--->

		<u>CTF</u><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "CTF Reviewer"><a href="Aprofiles.cfm?view=CTF Reviewer">CTF Reviewers</a><cfelse><b>CTF Reviewers</b></cfif><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "CTF Qualifier"><a href="Aprofiles.cfm?view=CTF Qualifier">CTF Qualifiers</a><cfelse><b>CTF Qualifiers</b></cfif><br>
		&nbsp;&nbsp;:: <cfif url.view is NOT "CTF Trainer"><a href="Aprofiles.cfm?view=CTF Trainer">CTF Trainers</a><cfelse><b>CTF Trainers</b></cfif><br>
		&nbsp;&nbsp;:: See 00-OP-S0056 for CTF Lead Auditor Details<br><br>

<u>IQA Auditor Training</u><br>
 :: <a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FIQA%20Related%20Information%2FScheme%20Training%20Records%2FStaff%20Training%20Records&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D">View</a> IQA Auditor Training Records <br><br>

<u>Other Auditor Lists</u><br />
&nbsp;&nbsp;:: <a href="Auditors.cfm?type=LTA">Laboratory Technical Audit (OSHA SNAP)</a> (Historical)<br />
&nbsp;&nbsp;:: <a href="Auditors.cfm?type=VS">Verification Services (VS)</a> (Historical)<br />
&nbsp;&nbsp;:: <a href="Auditors.cfm?type=ULE">UL Environment (ULE)</a>  (Historical)<br />
&nbsp;&nbsp;:: <a href="Auditors.cfm?type=WiSE">WiSE</a>
</cfif>
<br><Br>

<u>Quality System Qualification Status</u> - The fourth column in the table below shows the qualification status for the "Quality System" qualification. Auditors may be qualified in other areas, see "Qualifications" column.<br><br>

<u>Qualifications - All areas other than Quality System</u> - Auditors listed in the table below with qualifications other than "Quality System" are <b>qualified</b> in this area. Those "In Training" for any qualification other than "Quality System" do not have these qualifications listed in the table.<br><br>

<u>CAR Administrators</u> - Auditors who are also CAR Administrators are listed in the table below, including their status - Active, In Training.<br><br>

<style type="text/css">
	tr.shade:nth-child(even) {background: #FFF}
	tr.shade:nth-child(odd) {background: #EEE}
</style>

<table width="750" border="1" cellpadding="1" cellspacing="1" valign="top" style="border-collapse: collapse;">

 <tr align="center" valign="top">
    <td width="20%" class="sched-title">Auditor Name and Profile</td>
    <td width="30%" class="sched-title">Location</td>
    <td width="25%" class="sched-title">Qualifications</td>
    <td width="25%" class="sched-title">"Quality System" Qualification Status</td>
 </tr>

<CFOUTPUT QUERY="AuditorList">
<CFIF Trim(Auditor) is NOT "- None -">
<tr class="shade">
    <td width="25%" class="sched-content" valign="top">#Auditor#</td>
    <td width="35%" class="sched-content" valign="top"><cfif IQA eq 1>Corporate / Internal Quality Audits<cfelse><cfif Region is "Field Services">Field Services<cfelse>#Region# / #SubRegion#</cfif></cfif></td>
    <td width="25%" class="sched-content" valign="top">
        <cfif isDefined("Lead")>
            <cfif Lead eq 1>
                Lead Auditor<br>
            </cfif>
        </cfif>
    <cfset Dump = #replace(Qualified, ",", "<br>", "All")#>
    <cfset Dump0 = #replace(Dump, "- None -", "None", "All")#>
	#Dump0#

	<!--- check if CAR Admin --->
    <CFQUERY BLOCKFACTOR="100" NAME="CARAdmin" Datasource="Corporate">
    SELECT Name, Status
    FROM CARAdminList
    WHERE Name like '#Auditor#'
    AND (Status = 'Active' OR Status = 'In Training' OR Status = 'CAR Administration Support')
    </cfquery>
    <!--- /// --->

    <cfif CARAdmin.recordcount eq 1>
        <cfloop query="CARAdmin">
            <br />
            CAR Admin (#Status#)<br />
        </cfloop>
    </cfif>

		<cfif IQA eq "Yes" AND Status eq "In Training">
		<Br><br>
		<u>17025 Qualification Status</u>: <cfif Qualified17025 eq "Yes">Qualified<cfelse>In-Training</cfif><br>
		<u>17065 Qualification Status</u>: <cfif Qualified17065 eq "Yes">Qualified<cfelse>In-Training</cfif><br>

			<cfif QualifiedSNAP eq "Yes">
				<u>OSHA SNAP Project Review - Qualification Status</u>: Qualified
			</cfif><br>

			<cfif QualifiedCert eq "Yes">
			<u>Certification Project Review - Qualification Status</u>: Qualified
			</cfif><br>

		</cfif>
    </td>
<td width="15%" class="sched-content" valign="top">#Status#&nbsp;</td>
</tr>
<cfelse>
</cfif>
</CFOUTPUT>

</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->