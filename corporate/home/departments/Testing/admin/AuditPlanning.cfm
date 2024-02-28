<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning -  #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfset nextYear = curyear + 1>

<cfinclude template="#IQADir#cfscript_queryStringRemoveItem.cfm">
<cfset qs = cgi.query_string>

<b>View Year</b>
<cfoutput>

<cfset endYear = curyear + 1>
	<cfloop from=2015 to=#endYear# index=i>
		 - <a href="AuditPlanning.cfm?Year=#i#">#i#</a>&nbsp;
	</cfloop><br>

<b>Coverage Matrix</b> - <a href="AuditPlanning_Coverage.cfm?Year=#URL.Year#">View</a> Coverage Matrix<br>
<b>Auditor Days</b> - <a href="AuditPlanning_AuditorDays.cfm?Year=#URL.Year#">View</a> Auditor Days<br>
<b><font class="warning">Add Audit</font></b> - <a href="addaudit.cfm?AuditedBy=IQA" target="_blank">Add Audit</a> - This link will take you out of the planning module. Audits are added to the schedule, and are replicated to the Planning List.<br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Status" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM AuditSchedule_Planning_Status
WHERE Year_ = #URL.Year#
</cfquery>

<cfif Status.RecordCount GT 0>
	<cfoutput query="Status">
		<b>Publish Status</b>:
		<cfif len(PublishStatus) AND len(PublishDate)>
			<font class="warning">Published on #dateformat(PublishDate, "mm/dd/yyyy")# by #PublishUser#</font><br><br>
			
			Additional Steps to follow after Publication - do each only once!!<br>

			<cfif url.year eq curyear>
			:: 1 - <A href="_AuditSchedule_UpdateContactsFromCompletedAuditYear.cfm?Year=#curYear#">Copy Audit Contacts from Previous Year's Completed Schedule to Current Year's Audits (#curYear#)</a><br>
			:: 2 - <A href="_AuditScheduleCopy_ToNextYear.cfm?Year=#curYear#">Copy Published Schedule (#curyear#) to the following year</a><br>
			:: 3 - <A href="AuditPlanning_moveFromScheduleToPlanning.cfm?Year=#nextYear#">Copy Published Schedule to next year's Planning</a><br><br>

			Note : Each time an audit is added to the schedule, it is added to the planning.
			</cfif>
		<cfelse>
			<cfif len(readyToPublish)>
				Not Published - <b>Ready to Publish</b><br>
				Ready to Publish set by: #ReadyToPublishUser# on #dateformat(ReadyToPublishDate, "mm/dd/yyyy")#
				<cflock scope="SESSION" timeout="60">
					<CFIF SESSION.Auth.accesslevel is "SU">
						[<a href="AuditPlanning_readytoPublish_Action.cfm?Year=#URL.Year#&Action=Undo">Undo Link</a>]
					
						<Br>
						<a href="AuditPlanning_moveToAuditSchedule.cfm?Year=#URL.Year#">Publish the Schedule</a>
					</CFIF>
				</cflock>
			<cfelse>
				Not Published
				<cflock scope="SESSION" timeout="60">
					<CFIF SESSION.Auth.accesslevel is "SU">
					 - <a href="AuditPlanning_readytoPublish.cfm?Year=#URL.Year#&Action=Ready">Set "Ready to Publish" Value</a>
					</cfif>
				</cflock>
			</cfif>
		</cfif><br><br>
	</cfoutput>
</cfif>

<b>Note</b>: Auditor Independence is reviewed during the Audit Planning process, to ensure that the auditors are not auditing their own work, or 
their recent group/management.<br><br>

<cfoutput>
	<b>Audit Days Filter</b>
	<Cfif isDefined("URL.NoAuditDays") AND URL.NoAuditDays eq "No" OR NOT isDefined("URL.NoAuditDays")>
		<cfset newURL = queryStringDeleteVar("NoAuditDays", qs)>
		 - Viewing All Audits<br>
		 - <a href="AuditPlanning.cfm?#newURL#&NoAuditDays=Yes">View</a> Audits with Audit Days listed as 'None Listed'<br><br>
	<cfelse>
		<cfset newURL = queryStringDeleteVar("NoAuditDays", qs)>
		- Viewing Audits with Audit Days listed as 'None Listed'<br>
		- <a href="AuditPlanning.cfm?#newURL#&NoAuditDays=No">Remove</a> Audit Days Filter<br><br>
	</cfif>

	<!---
	<b>Primary Contact Filter</b>
	<Cfif isDefined("URL.NoPrimaryContact") AND URL.NoPrimaryContact eq "No" OR NOT isDefined("URL.NoPrimaryContact")>
		<cfset newURL = queryStringDeleteVar("NoPrimaryContact", qs)>
		 - Viewing All Audits<br>
		 - <a href="AuditPlanning.cfm?#newURL#&NoPrimaryContact=Yes">View</a> Audits with Primary Contact listed as 'TBD'<br><br>
	<cfelse>
		<cfset newURL = queryStringDeleteVar("NoPrimaryContact", qs)>
		- Viewing Audits with Primary Contact listed as 'TBD'<br>
		- <a href="AuditPlanning.cfm?#newURL#&NoPrimaryContact=No">Remove</a> Primary Contact Filter<br><br>
	</cfif>
	--->
	
	<b>Lead Auditor Filter</b>
	<Cfif isDefined("URL.NoLead") AND URL.NoLead eq "No" OR NOT isDefined("URL.NoLead")>
		<cfset newURL = queryStringDeleteVar("NoLead", qs)>
		 - Viewing All Audits<br>
		 - <a href="AuditPlanning.cfm?#newURL#&NoLead=Yes">View</a> Audits with no Lead Auditor Listed<br><br>
	<cfelse>
		<cfset newURL = queryStringDeleteVar("NoLead", qs)>
		- Viewing Audits with no Lead Auditor Listed<br>
		- <a href="AuditPlanning.cfm?#newURL#&NoLead=No">Remove</a> Lead Auditor Filter<br><br>
	</cfif>
</cfoutput>

<cfoutput>
<cfset newURL = queryStringDeleteVar("Month", qs)>

<b>Month</b>: <cfif isDefined("URL.Month")><b>#monthAsString(url.Month)#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
<SELECT NAME="MonthJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Month Below
	<option value="javascript:document.location.reload();">
		<cfloop index="i" from="1" to="12">
			<OPTION VALUE="AuditPlanning.cfm?#newURL#&Month=#i#">#MonthAsString(i)#</OPTION>
		</cfloop>
</SELECT><br><br>

<cfset newURL = queryStringDeleteVar("AuditType2", qs)>

<b>Audit Type</b>: <cfif isDefined("URL.AuditType2")><b>#URL.AuditType2#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Audit Type Below
	<option value="javascript:document.location.reload();">

	<Option value="AuditPlanning.cfm?#newURL#">:: View All Audit Types</Option>
	<Option value="AuditPlanning.cfm?#newURL#&AuditType2=Global Function/Process">Global Function/Process</Option>
	<Option value="AuditPlanning.cfm?#newURL#&AuditType2=Local Function">Local Function</Option>
	<Option value="AuditPlanning.cfm?#newURL#&AuditType2=Program">Program</Option>
	<Option value="AuditPlanning.cfm?#newURL#&AuditType2=Scheme Documentation">Scheme Documentation Audits</Option>
	<Option value="AuditPlanning.cfm?#newURL#&AuditType2=CB Audits">Certification Body (CB) Audits</Option>
</select><br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
SELECT *
FROM AuditorList
WHERE (Status = 'Active' OR Status = 'In Training')
AND IQA = 'Yes'
ORDER BY Auditor
</CFQUERY>

<Cfoutput>
<cfset newURL = queryStringDeleteVar("Auditor", qs)>

<b>Auditor</b>: <cfif isDefined("URL.Auditor")><b>#URL.Auditor#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
</Cfoutput>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Auditor Below
	<option value="javascript:document.location.reload();">
	<cfoutput>
		<Option value="#CGI.ScriptName#?#newURl#">:: View All Auditors</Option>
	</cfoutput>
	<cfoutput query="Auditor">
		<Option value="#CGI.ScriptName#?#newURl#&Auditor=#Auditor#">#Auditor#</Option>
	</cfoutput>
</select><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="Offices" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DISTINCT OfficeName
FROM AuditSchedule_Planning
WHERE AuditArea <> 'Certification Body (CB) Audit'
AND OfficeName <> 'Global'
ORDER BY OfficeName
</cfquery>

<Cfoutput>
<cfset newURL = queryStringDeleteVar("OfficeName", qs)>

<b>Office</b>: <cfif isDefined("URL.Officename")><b>#URL.Officename#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
</Cfoutput>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Office Below
	<option value="javascript:document.location.reload();">
	<cfoutput>
		<Option value="#CGI.ScriptName#?#newURl#">:: View All Offices</Option>
	</cfoutput>
	<cfoutput query="Offices">
		<Option value="#CGI.ScriptName#?#newURl#&OfficeName=#OfficeName#">#OfficeName#</Option>
	</cfoutput>
</select><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="Programs" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DISTINCT Area
FROM AuditSchedule_Planning
WHERE AuditType2 = 'Program'
ORDER BY Area
</cfquery>

<Cfoutput>
<cfset newURL = queryStringDeleteVar("Program", qs)>

<b>Programs</b>: <cfif isDefined("URL.Program")><b>#URL.Program#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
</Cfoutput>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Programs Below
	<option value="javascript:document.location.reload();">
	<cfoutput>
		<Option value="#CGI.ScriptName#?#newURl#">:: View All Programss</Option>
	</cfoutput>
	<cfoutput query="Programs">
		<Option value="#CGI.ScriptName#?#newURl#&Program=#Area#">#Area#</Option>
	</cfoutput>
</select><br><br>

See the Notes below this table for useful information<br><br>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudits" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT *
	FROM AuditSchedule_Planning
	WHERE Year_ = #URL.Year#
	<Cfif isDefined("URL.NoAuditDays") AND URL.NoAuditDays eq "Yes">
		AND AuditDays IS NULL
	</cfif>
	<Cfif isDefined("URL.NoPrimaryContact") AND URL.NoPrimaryContact eq "Yes">
		AND (Email = 'TBD' OR Email IS NULL)
	</cfif>
	<Cfif isDefined("URL.NoLead") AND URL.NoLead eq "Yes">
		AND LeadAuditor IS NULL
	</cfif>
	<cfif isDefined("URL.Auditor")>
		AND
		(LeadAuditor = '#URL.Auditor#'
			OR Auditor LIKE '%#URL.Auditor#%'
			OR AuditorInTraining LIKE '%#URL.Auditor#%')
	</cfif>
	<cfif isDefined("URL.OfficeName")>
		AND Officename = '#URL.OfficeName#'
	</cfif>
	<cfif isDefined("URL.Program")>
		AND Area = '#URL.Program#'
	</cfif>
	<cfif isDefined("URL.AuditType2")>
		<cfif URL.AuditType2 eq "Scheme Documentation">
			AND AuditType2 = 'Program' AND AuditArea = 'Scheme Documentation Audit'
		<cfelseif URL.AuditType2 eq "CB Audits">
			AND AuditType2 = 'Local Function' AND AuditArea = 'Certification Body (CB) Audit'
		<cfelseif URL.AuditType2 eq "Local Function">
			AND AuditType2 = 'Local Function' AND AuditArea <> 'Certification Body (CB) Audit'
		<cfelseif URL.AuditType2 eq "Program">
			AND AuditType2 = 'Program' AND AuditArea <> 'Scheme Documentation Audit'
		<cfelse>
			AND AuditType2 = '#URL.AuditType2#'
		</cfif>
	</cfif>
	<cfif isDefined("Month")>
		AND Month = #URL.Month#
	</cfif>
	ORDER BY Month, AuditType2, OfficeName, Area
</cfquery>

<table border="1" width="1000">
	<tr>
		<th>Audit Number</th>
		<th>Month</th>
		<th>Audit Type</th>
		<th>Office Name / Legal Entity</th>
		<th>Area</th>
		<th>Business Units</th>
		<th>Audit Team</th>
		<th>Audit Days</th>
		<!---
		<th>Primary/Other Contacts</th>
		--->
		<th>Actions</th>
	</tr>

	<cfset i = 1>

	<cfoutput query="viewAudits">
	<tr valign="top">
		<td>#Year_#-#ID#<br><br>

			<cfif Desk is "Yes">Desk Audit<br><br></cfif>

			<cfif len(Status)>
				<cfif Status is "Removed">
					<img src="#IQARootDir#images/black.jpg" border="0"> - Removed
				<cfelseif Status is "Deleted">
					<img src="#IQARootDir#images/blue.jpg" border="0"> - Cancelled<br><br>

					<a href="#IQADir#CancelFiles_Planning/#CancelFile#">View Cancellation File</a>
				</cfif>
			<cfelse>
				<img src="#IQARootDir#images/green.jpg" border="0">
			</cfif>
		</td>
		<td>
			#MonthAsString(Month)#

			<!---
			<cfif isDefined("URL.View") AND URL.View eq "Edit">
			<br><br>
				<SELECT NAME="AuditDays">
					<cfloop from="1" to="12" index="i">
						<Option value="#i#" <cfif i eq Month>selected</cfif>>#monthAsString(i)#</Option>
					</cfloop>
				</select>
			</cfif>
			--->
		</td>
		<td>
			<cfif auditArea is "Certification Body (CB) Audit">
				Certification Body (CB) Audit
			<cfelse>
				#AuditType2#
			</cfif>
		</td>
		<td>
			<cfif auditArea is "Certification Body (CB) Audit">
				<u>Legal Entity</u><br>#OfficeName#
			<cfelse>
				#OfficeName#
			</cfif>
		</td>
		<td>
			<!--- not CB and not Scheme Documentation --->
			<cfif auditArea neq "Certification Body (CB) Audit" AND AuditArea neq "Scheme Documentation Audit">
				#Area#<br><br>(#AuditArea#)
			</cfif>

			<!--- CB Audits - list programs --->
			<cfif auditArea is "Certification Body (CB) Audit">
				Certification Body (CB) Audit of #OfficeName#<br><br>

				<CFQUERY BLOCKFACTOR="100" NAME="CBSchemes" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Corporate.ProgDev.Program
				FROM Corporate.ProgDev, CBAudits, CBAudits_SchemeAssignment
				WHERE CBAudits.ID = CBAudits_SchemeAssignment.CB_ID
				AND CBAudits_SchemeAssignment.programID = Corporate.ProgDev.ID
				AND CBAudits.Name = '#OfficeName#'
				AND CBAudits_SchemeAssignment.Status IS NULL
				ORDER BY Corporate.ProgDev.Program
				</cfquery>

				<u>Included Schemes</u><Br>
				<cfloop query="CBSchemes">
				 :: #Program#<br>
				</cfloop><br>
			</cfif>

			<!--- Scheme Documentation Audit --->
			<cfif auditArea is "Scheme Documentation Audit">
				#Area#<Br><br>

				Scheme Documentation Audit

				<cfif NOT len(Status)>
					<br><br>
					<u>Legal Entity</u><br>

					<CFQUERY BLOCKFACTOR="100" NAME="CBName" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
					SELECT CBAudits.Name
					FROM Corporate.ProgDev, CBAudits, CBAudits_SchemeAssignment
					WHERE CBAudits.ID = CBAudits_SchemeAssignment.CB_ID
					AND CBAudits_SchemeAssignment.programID = Corporate.ProgDev.ID
					AND ProgDev.Program = '#Area#'
					</cfquery>

					<cfloop query="CBName">
						#Name#
					</cfloop>
				</cfif>
			</cfif>
		</td>
		<td>
			<cfif len(BusinessUnit)>
				- #replace(BusinessUnit, ",", "<br> - ", "All")#
			<cfelse>
				None Listed
			</cfif>
		</td>
		<td>
			<u>Lead</u><br>- #LeadAuditor#<br><br>
			<cfif len(Auditor)>
				<cfif Auditor neq "- None -">
					<u>Auditor(s)</u><br>- #replace(Auditor, ",", "<br>- ", "All")#<br><br>
				</cfif>
			</cfif>
			<cfif len(AuditorInTraining)>
				<cfif AuditorInTraining neq "- None -">
					<u>Auditor(s) In Training</u><Br>- #replace(AuditorInTraining, ",", "<br>- ", "All")#
				</cfif>
			</cfif>
			<cfif len(SME)>
				<cfif len(SME) AND SME neq "- None -">
					<u>Subject Matter Expert</u><Br>- #replace(SME, ",", "<br>- ", "All")#
				</cfif>
			</cfif>
		</td>
		<td align="center">
			<cfif len(AuditDays)>
				#AuditDays#
			<cfelse>
				None Listed
			</cfif><br><br>

			<!---<cfif isDefined("URL.View") AND URL.View eq "Edit">
			<br><br>
				<SELECT NAME="AuditDays">
					<cfloop from="1" to="15" index="i">
						<Option value="#i#">#i#</Option>
					</cfloop>
				</select>
			</cfif>
			--->
		</td>
		
		<!---
		<td>
			<cfif auditArea is "Certification Body (CB) Audit">
				<u>Primary Contact (Top Management)</u><br>- #Email#<br><br>
				<cfif len(Email2)>
					<u>Other</u><br>- #replace(Email2, ",", "<br>- ", "All")#<br><br>
				</cfif>
			<Cfelse>
				<u>Primary Contact</u><br>- #Email#<br><br>
				<cfif len(Email2)>
					<u>Other</u><br>- #replace(Email2, ",", "<br>- ", "All")#<br><br>
				</cfif>
			</cfif>

			<!--- Scheme Documentation Audits - Identify the Scheme Owner --->
			<cfif auditArea is "Scheme Documentation Audit">
				<CFQUERY BLOCKFACTOR="100" NAME="SchemeOwner" Datasource="Corporate">
				SELECT SchemeOwner From ProgDev
				WHERE Program = '#Area#'
				</cfquery>

				<u>Scheme Owner</u><Br>
				 - <cfif len(SchemeOwner.SchemeOwner)>#SchemeOwner.SchemeOwner#<cfelse>None Listed</cfif><br><br>
			</cfif>
		</td>
		--->
		
		<td width="150">
			<cfif len(Status.ReadyToPublish) AND Status.ReadytoPublish is "Yes"
				OR len(Status.PublishStatus) AND Status.PublishStatus is "Yes">
				:: Audits cannot be edited<br>
				
				<cflock scope="SESSION" timeout="60">
					<cfif SESSION.Auth.UserName eq "Chris" or SESSION.Auth.Username eq "Superuser">
						<br>
						:: <a href="AuditPlanning_Edit.cfm?auditID=#xGUID#&Year=#URl.Year#">Superuser Edit</a> - this will not affect the Audit Schedule!<br><br>
					</cfif>
				</cflock>
			<cfelse>
				<cflock scope="SESSION" timeout="60">
					<CFIF SESSION.Auth.accesslevel is "SU"or SESSION.Auth.accesslevel is "Admin">
						:: <a href="AuditPlanning_Edit.cfm?auditID=#xGUID#&Year=#URl.Year#">Edit</a><br>

						<cfif auditArea is "Scheme Documentation Audit">
						:: <a href="AuditPlanning_SchemeOwner_Edit.cfm?auditID=#xGUID#&Year=#URl.Year#">Add/Edit Scheme Owner</a><br>
						</cfif>

						<cfif len(Status) AND Status is "Deleted">
							:: <a href="AuditPlanning_Uncancel.cfm?auditID=#xGUID#&Year=#URL.Year#">Uncancel</a><br>
						<cfelse>
							:: <a href="AuditPlanning_Cancel.cfm?auditID=#xGUID#&Year=#URl.Year#">Cancel</a><br />
						</cfif>

						<cfif len(Status) AND Status is "Removed">
							:: <a href="AuditPlanning_Reinstate.cfm?auditID=#xGUID#&Year=#URl.Year#">Reinstate</a><br>
						<cfelse>
							:: <a href="AuditPlanning_Remove.cfm?auditID=#xGUID#&Year=#URl.Year#">Remove</a><br>
						</cfif>
					</cfif>
				</cflock>
			</cfif>
			:: <a href="#IQADir#AuditHistory.cfm?xGUID=#xGUID#">View Audit History</a><br><br>

			<cfif len(Notes)><u>Planning Notes</u>:<br>#Notes#</cfif><br><br>

			<cfif len(NotesToLeadAuditor)><u>Notes to Lead</u>:<br>#NotesToLeadAuditor#</cfif>
		</td>
	</tr>
	</cfoutput>
</table>
<br><br>

<b>Notes for 2016 Planning</b>:<Br>
<u>Audit Days</u> were imported from 2015 completed audits and remaining audits for the year as of 8/12/2015. The number of Audit Days can be changed when the planning activity has begun for 2016.
Those audits with 'None Listed' for Audit Days can be edited on the 'Edit' page.<br><br>

<u>'Notes' and 'Notes to Lead' fields</u>: The Notes field is for Planning only. It is not transferred to the Audit Schedule. The 'Notes to Lead' field is tranferred to the
Audit Schedule and will be available in the Admin view for the Audit Team to see. This is intended to pass along any useful information for the audit.<br><bR>

<u>Cancel/Reschedule Audits</u>: In order to maintain a trail of audits with cancellation/reschedule history, you cannot perform these audits in the Planning Module.
The audit must be published to the Audit Schedule and then follow the Cancel/Reschedule workflow. (The month of the Audit can be changed in the Planning Module)<br><br>

<u>Removing an Audit</u>: Audits can be removed in the Planning Module, as long as there is appropriate history in the Audit Schedule. You can reverse this action by selecting
'Reinstate' Audit.<Br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->