<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
SELECT Auditor FROM AuditorList
WHERE ID = #URL.ID#
ORDER BY LastName
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor Profile - #AuditorProfile.Auditor#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Profile" Datasource="Corporate">
SELECT * FROM AuditorList
WHERE ID = #URL.ID#
ORDER BY LastName
</cfquery>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

Auditor Profile
<cflock scope="SESSION" timeout="5">
	<CFOUTPUT Query="Profile">
		<CFIF SESSION.Auth.accesslevel is "SU">
            <cfif Status is "NotApproved" or Status is "Requested">
                : <a href="Aprofiles_edit.cfm?ID=#URL.ID#">edit</a> :
                <!--- : <a href="Aprofiles_delete.cfm?id=#URL.ID#">delete</a> : --->
                : <a href="Auditor_req_status.cfm?id=#URL.ID#&action=approved">approve</a> :
                : <a href="Auditor_req_status.cfm?id=#URL.ID#&action=denied">deny</a> :
            <cfelse><!--- if approved --->
                : <a href="Aprofiles_edit.cfm?ID=#URL.ID#">edit</a> :
                <!--- : <a href="Aprofiles_delete.cfm?id=#URL.ID#">delete</a> : --->
            </cfif>
        <cfelseif SESSION.Auth.Accesslevel is "RQM">
        	<cfif SESSION.Auth.Region is "#Region#" OR SESSION.Auth.Region is "Europe" AND Region eq "Latin America">
                <cfif Status is "NotApproved" or Status is "Requested">
                    : <a href="Aprofiles_edit.cfm?ID=#URL.ID#">edit</a> :
                    <!--- : <a href="Aprofiles_delete.cfm?id=#URL.ID#">delete</a> : --->
                    : <a href="Auditor_req_status.cfm?id=#URL.ID#&action=approved">approve</a> :
                    : <a href="Auditor_req_status.cfm?id=#URL.ID#&action=denied">deny</a> :
                <cfelse><!--- if approved --->
                    : <a href="Aprofiles_edit.cfm?ID=#URL.ID#">edit</a> :
                    <!--- : <a href="Aprofiles_delete.cfm?id=#URL.ID#">delete</a> : --->
                </cfif>
            </cfif>
        <cfelseif SESSION.Auth.AccessLevel is "Field Services" AND Region is "Field Services">
            : <a href="Aprofiles_edit.cfm?ID=#URL.ID#">edit</a> :
		<cfelseif SESSION.auth.accesslevel is "Admin">
            : <a href="Aprofiles_edit.cfm?ID=#URL.ID#">edit</a> :
        <cfelseif SESSION.Auth.AccessLevel is "RQM" AND SESSION.Auth.Name is "#Auditor#">
            : <a href="Aprofiles_edit.cfm?ID=#URL.ID#">edit</a> :
        <cfelseif SESSION.Auth.Accesslevel is "RQM" AND SESSION.Auth.Region is "#Region#">
            : <a href="Aprofiles_edit.cfm?ID=#URL.ID#">edit</a> :
        </CFIF>
	</cfoutput>
</cflock>

<table width="650" border="1" cellpadding="1" cellspacing="1" valign="top" style="border-collapse: collapse;">
<div class="blog-time">Auditor List Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditorlist.cfm')">[?]</A></div><br>

<u>Options</u><br>
<CFOUTPUT QUERY="Profile">
	<cfif IQA eq "Yes">
	:: <a href="_Quals_View.cfm?ID=#URL.ID#&Action=Auditor">Auditor Qualifications Table</a><br>
	</cfif>

	<cflock scope="SESSION" timeout="5">
		<cfif SESSION.Auth.AccessLevel is "Field Services">
	    	:: <a href="Aprofiles.cfm?view=Field Services">Auditor List</a><br>
	    <cfelse>
	    	:: <a href="Aprofiles.cfm?view=All">Auditor List</a><br>
		</cfif>
	</cflock>

	<cfif IQA eq "Yes">
	:: Audits conducted by #Auditor# <a href="audit_list2.cfm?type=auditor&type2=#Auditor#&year=#curYear#">Yearly Audit List</a> :: <a href="calendar.cfm?type=auditor&type2=#Auditor#&year=#curYear#">Calendar</a> :: <a href="schedule.cfm?Year=#curYear#&AuditedBy=IQA&auditor=#Auditor#">Schedule</a><br />
	<cfelse>
		<br>
	</cfif>
	
<cflock scope="SESSION" timeout="5">
	<CFIF IQA eq 1 OR SESSION.Auth.accesslevel is "SU">
		:: <A href="#IQADir#CVTemplate/CVTemplate.doc">Download</A> Blank CV Form<Br /><br />
	</cfif>
</cflock>

	<tr align="center" valign="top">
		<td width="34%" class="sched-title">Auditor Name</td>
		<td width="33%" class="sched-title">Location / SubRegion / Region</td>
		<td width="33%" class="sched-title">"Quality System" Qualification Status</td>
	</tr>
	<tr valign="top">
		<td width="34%" class="sched-content">
			<b>#Auditor#</b>&nbsp;
		</td>
		<td width="33%" class="sched-content">
			<cfif region is "field services">
				Field Services
			<cfelse>
            	<cfif IQA is "Yes">
                	Corporate / Internal Quality Audits
                <cfelse>
       				#Location#<br />
                    #SubRegion#<br />
                    #Region#
                </cfif>
			</cfif>
		</td>
			<td width="33%" class="sched-content">
			<CFIF Trim(Status) is "">
				No Status Specified
			<cfelse>
				#Status#
			</CFIF>
		</td>
	</tr>
<cfif IQA eq 1 OR IQA eq "Yes">
	<tr align="left" valign="top">
		<td colspan="3" class="sched-title">
			Auditor CV
		</td>
	</tr>
	<tr align="left" valign="top">
		<td colspan="3" class="sched-content">
			<cfif CV eq 1>
				<a href="../Auditors/#ID#/CV.pdf">View</a> CV for #Auditor#<br>
                    <cflock scope="SESSION" timeout="5">
                        <CFIF SESSION.Auth.accesslevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" OR SESSION.Auth.Username eq "Huang">
                            <a href="AProfiles_CV.cfm?ID=#url.id#">Upload</a> CV for #Auditor#
                    	<cfelseif SESSION.Auth.Name is #Auditor#>
                            <a href="AProfiles_CV.cfm?ID=#url.id#">Upload</a> your CV
                        </cfif>
                    </cflock>
			<cfelse>
                <cflock scope="SESSION" timeout="5">
                    <CFIF SESSION.Auth.accesslevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
                            <a href="AProfiles_CV.cfm?ID=#url.id#">Upload</a> CV for #Auditor#
                	<cfelseif SESSION.Auth.Name is #Auditor#>
                        <a href="AProfiles_CV.cfm?ID=#url.id#">Upload</a> your CV
                    </cfif>
                </cflock>
			</cfif>
		</td>
	</tr>
</cfif>
	<tr align="left" valign="top">
		<td width="34%" class="sched-title" colspan="3">
			Email
		</td>
	</tr>
	<tr>
		<td width="34%" class="sched-content" colspan="3">
			<a href="mailto:#email#">#Email#</a>&nbsp;
		</td>
	</tr>
	<tr align="left" valign="top">
		<td class="sched-title" colspan="3">
			Auditor Qualifications
		</td>
	</tr>
	<tr>
		<td colspan="3" class="sched-content">
		
		<cfif IQA eq "Yes">
			<font class="warning">Note</font> - The auditor is qualified/active in all areas listed below, except for CAR Admin 
			(status listed below, if applicable), and Quality System - see "Quality System Qualification Status" in the first row of this table.
			<br><br>
		</cfif>
		
		<cfif isDefined("Lead")>
			<cfif Lead eq 1>
				Lead Auditor<br>
			</cfif>
		</cfif>
		<cfset Dump = #replace(Qualified, ",", "<br>", "All")#>
		#Dump#

		<!--- check if CAR Admin --->
        <CFQUERY BLOCKFACTOR="100" NAME="CARAdmin" Datasource="Corporate">
        SELECT Name, Status
        FROM CARAdminList
        WHERE Name = '#Auditor#'
        AND (Status = 'Active' OR Status = 'In Training' OR Status = 'CAR Administration Support')
        </cfquery>
        <!--- /// --->

        <cfif CARAdmin.recordcount eq 1>
            <cfloop query="CARAdmin">
                <br />
                CAR Admin (#Status#)<br />
            </cfloop>
        </cfif>
		</td>
	</tr>
	<cfif DAPAuditor eq "Yes"
	 OR IQA eq "Yes" AND Status eq "In Training">
		<tr align="left" valign="top">
			<td class="sched-title" colspan="3">
				DAP / IQA Auditors Only: In-Training Information
			</td>
		</tr>
		<tr>
			<td colspan="3" class="sched-content">
				<u>17025 Qualification Status</u>: <cfif Qualified17025 eq "Yes">Qualified<cfelse>In-Training</cfif><br>
				<u>17065 Qualification Status</u>: <cfif Qualified17065 eq "Yes">Qualified<cfelse>In-Training</cfif><br>
				<u>OSHA SNAP Project Review - Qualification Status</u>: <cfif QualifiedSNAP eq "Yes">Qualified<cfelse>In-Training</cfif><br>
				<u>Certification Project Review - Qualification Status</u>: <cfif QualifiedCert eq "Yes">Qualified<cfelse>In-Training</cfif><br>
			</td>
		</tr>
	</cfif>
	<tr align="left" valign="top">
		<td class="sched-title" colspan="3">
			Expertise
		</td>
	</tr>
	<tr>
		<td colspan="3" class="sched-content">
			#Expertise#&nbsp;
		</td>
	</tr>
	<tr align="left" valign="top">
		<td class="sched-title" colspan="3">
			Training
		</td>
	</tr>
	<tr>
		<td colspan="3" class="sched-content">
			#Training#&nbsp;
		</td>
	</tr>
	<tr align="left" valign="top">
		<td class="sched-title" colspan="3">
			Comments
		</td>
	</tr>
	<tr>
		<td colspan="3" class="sched-content">
			#Comments#&nbsp;
		</td>
	</tr>
	<tr align="left" valign="top">
		<td class="sched-title" colspan="3">
		Attachments - Auditor Qualifications -
	<cflock scope="SESSION" timeout="5">
		<CFIF
			<!--- can edit all users --->
			SESSION.Auth.accesslevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" OR SESSION.Auth.Username eq "Huang"
			OR
			<!--- IQA Auditors can edit themselves --->
			SESSION.Auth.Name is #Auditor#
			AND SESSION.Auth.AccessLevel is "IQAAuditor"
			OR
			<!--- RQM's can edit auditors in their region (not just their specific subregion --->
			SESSION.Auth.AccessLevel is "RQM"
			AND SESSION.Auth.Region is #Region#>
				<a href="Aprofiles_upload.cfm?ID=#ID#">upload files</a>
		</cfif>
	</cflock>
		</td>
	</tr>
	<tr>
		<td colspan="3" class="sched-content">
Auditor Qualification files are listed below.<br><br>
To view, click on the file name. If you wish to remove a file from the listing, please contact <a href="mailto:Global.InternalQuality@ul.com">Global Internal Quality</a>.<br><br>

		<cfinclude template="../Auditors/directory_listing.cfm">
		</td>
	</tr>
</CFOUTPUT>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->