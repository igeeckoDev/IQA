<cfinclude template="#IQADir#cfscript_queryStringRemoveItem.cfm">
<cfset qs = cgi.query_string>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditPlanning.cfm?#qs#'>#URL.Year# Audit Planning</a> - Coverage Matrix">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>View Year</b>
<cfoutput>
	<cfloop from=2015 to=#nextYear# index=i>
		 :: <a href="AuditPlanning_Coverage.cfm?Year=#Year#">#i#</a>&nbsp;
	</cfloop><br><br>

<b>Planning Matrix</b> <a href="AuditPlanning.cfm?#qs#">View</a> Audit Planning Matrix<br>
<b>Auditor Days</b> - <a href="AuditPlanning_AuditorDays.cfm?Year=#URL.Year#">View</a> Auditor Days<br><br>
</cfoutput>

<cfoutput>
<cfset newURL = queryStringDeleteVar("Month", qs)>

<b>Month</b>: <cfif isDefined("URL.Month")><b>#monthAsString(url.Month)#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
<SELECT NAME="MonthJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Month Below
	<option value="javascript:document.location.reload();">
		<cfloop index="i" from="1" to="12">
			<OPTION VALUE="#CGI.ScriptName#?#newURL#&Month=#i#">#MonthAsString(i)#</OPTION>
		</cfloop>
</SELECT><br><br>

<cfset newURL = queryStringDeleteVar("AuditType2", qs)>

<b>Audit Type</b>: <cfif isDefined("URL.AuditType2")><b>#URL.AuditType2#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Audit Type Below
	<option value="javascript:document.location.reload();">

	<Option value="#CGI.ScriptName#?#newURL#">:: View All Audit Types</Option>
	<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Global Function/Process">Global Function/Process</Option>
	<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Local Function">Local Function</Option>
	<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Program">Program</Option>
	<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Scheme Documentation">Scheme Documentation Audits</Option>
	<Option value="#CGI.ScriptName#?#newURL#&AuditType2=CB Audits">Certification Body (CB) Audits</Option>
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
			AND AuditType2 = 'Program' AND AuditArea LIKE '%Scheme Documentation%'
		<cfelseif URL.AuditType2 eq "CB Audits">
			AND AuditType2 = 'Local Function' AND AuditArea = 'Certification Body (CB) Audit'
		<cfelse>
			AND AuditType2 = '#URL.AuditType2#'
		</cfif>
	</cfif>
	<cfif isDefined("Month")>
		AND Month = #URL.Month#
	</cfif>
	ORDER BY Month, AuditType2, OfficeName, Area
</cfquery>

<cfset fromValue = #URL.Year#>
<cfset toValue = #URl.Year# - 3>

<table border="1" width="1000">
	<tr>
		<th colspan="8">Audit Planning Information</th>
		<th colspan="4">Audit Schedule - Coverage<br>(Year, Audit Number, Audit Days)</th>
	</tr>
	<tr>
		<th>Audit Number</th>
		<th>Month</th>
		<th>Audit Type</th>
		<th>Office Name</th>
		<th>Area</th>
		<th>Business Units</th>
		<th>Audit Team</th>
		<th>Audit Days</th>
		<cfloop from=#fromValue# to=#toValue# index=i step=-1>
		<th><cfoutput>#i#</cfoutput></th>
		</cfloop>
	</tr>

	<cfset i = 1>

	<cfoutput query="viewAudits">
	<tr valign="top">
		<td>#Year_#-#ID#<br><br>

			<cfif Desk is "Yes">Desk Audit<br><br></cfif>

			<cfif len(Status)>
				<cfif Status is "Deleted" or Status is "Removed">
					<img src="#IQARootDir#images/black.jpg" border="0">
				</cfif>
				 - #Status#
			<cfelse>
				<img src="#IQARootDir#images/green.jpg" border="0">
			</cfif>
		</td>
		<td>
			#MonthAsString(Month)#
		</td>
		<td>#AuditType2#</td>
		<td>#OfficeName#</td>
		<td>#Area#<br><br>(#AuditArea#)</td>
		<td>
			<cfif len(BusinessUnit)>
				#replace(BusinessUnit, ",", ", ", "All")#
			<cfelse>
				None Listed
			</cfif>
		</td>
		<td>
			<u>Lead</u>: #LeadAuditor#<br><br>
			<cfif len(Auditor)>
				<cfif Auditor neq "- None -" AND AuditorInTraining neq "None">
					<u>Auditor(s)</u>: #replace(Auditor, ",", "<br>", "All")#<br><br>
				</cfif>
			</cfif>
			<cfif len(AuditorInTraining)>
				<cfif AuditorInTraining neq "- None -" AND AuditorInTraining neq "None">
					<u>Auditor(s) In Training</u>: #replace(AuditorInTraining, ",", "<br>", "All")#
				</cfif>
			</cfif>
		</td>
		<td align="center">
			<cfif len(AuditDays)>
				#AuditDays#
			<cfelse>
				None Listed
			</cfif><br><br>
		</td>

		<!--- url.year --->
		<td width="60">
			<CFQUERY BLOCKFACTOR="100" NAME="getAudit" Datasource="Corporate">
			SELECT ID, Year_, Status, lastYear, xGUID, RescheduleNextYear, AuditDays, LeadAuditor, Auditor, AuditorInTraining
			FROM AuditSchedule
			WHERE xGUID = #xGUID#
			</cfquery>

			<cfset AuditTeam = valueList(getAudit.LeadAuditor)>
			<cfset AuditTeam = listAppend(AuditTeam, getAudit.Auditor)>
			<cfset AuditTeam = listAppend(AuditTeam, getAudit.AuditorInTraining)>

			<cfif getAudit.recordCount EQ 1>
			<a href="auditDetails.cfm?ID=#getAudit.ID#&Year=#getAudit.Year_#">#getAudit.Year_#-#getAudit.ID#</a><br>
				Days:
				<cfif len(getAudit.AuditDays)>
					#getAudit.AuditDays#
				<cfelse>
					None Listed
				</cfif><br>

				Team: #listLen(AuditTeam)#<br>

				<cfif len(getAudit.Status)>
					<br><cfif getAudit.Status eq "Deleted">Cancelled<cfelse>#getAudit.Status#</cfif> - <img src="#IQARootDir#images/black.jpg" border="0">
				</cfif>

				<cfif getAudit.RescheduleNextYear eq "Yes">
					<cfset RescheduleYear = #getAudit.Year_# + 1>
					<br>Rescheduled for #RescheduleYear# - <img src="#IQARootDir#images/red.jpg" border="0">
				</cfif>
			<cfelse>
			N/A
			</cfif>
		</td>

		<cfset getValue.lastYear = getAudit.lastYear>

		<!--- -1 --->
		<td>
			<cfif len(getAudit.lastYear)>
				<CFQUERY BLOCKFACTOR="100" NAME="getValue" Datasource="Corporate">
				SELECT lastYear
				FROM AuditSchedule
				WHERE xGUID = #xGUID#
				</cfquery>

				<CFQUERY BLOCKFACTOR="100" NAME="getAudit" Datasource="Corporate">
				SELECT ID, Year_, Status, lastYear, xGUId, RescheduleNextYear, AuditDays, LeadAuditor, Auditor, AuditorInTraining
				FROM AuditSchedule
				WHERE xGUID = #getValue.lastYear#
				</cfquery>

				<cfset AuditTeam = valueList(getAudit.LeadAuditor)>
				<cfset AuditTeam = listAppend(AuditTeam, getAudit.Auditor)>
				<cfset AuditTeam = listAppend(AuditTeam, getAudit.AuditorInTraining)>

				<cfif getAudit.recordCount EQ 1>
				<a href="auditDetails.cfm?ID=#getAudit.ID#&Year=#getAudit.Year_#">#getAudit.Year_#-#getAudit.ID#</a>
					Days:
					<cfif len(getAudit.AuditDays)>
						#getAudit.AuditDays#<br>
					<cfelse>
						None Listed
					</cfif>

					Team: #listLen(AuditTeam)#<br>

					<cfif len(getAudit.Status)>
						<br><cfif getAudit.Status eq "Deleted">Cancelled<cfelse>#getAudit.Status#</cfif> - <img src="#IQARootDir#images/black.jpg" border="0">
					</cfif>

					<cfif getAudit.RescheduleNextYear eq "Yes">
						<cfset RescheduleYear = #getAudit.Year_# + 1>
						<br>Rescheduled for #RescheduleYear# - <img src="#IQARootDir#images/red.jpg" border="0">
					</cfif>
				<cfelse>
				N/A
				</cfif>
			<cfelse>
				N/A
			</cfif>
		</td>
		<!--- -2 --->
		<td>
			<cfif len(getAudit.lastYear)>
				<CFQUERY BLOCKFACTOR="100" NAME="getValue" Datasource="Corporate">
				SELECT lastYear
				FROM AuditSchedule
				WHERE xGUID = #getAudit.xGUID#
				</cfquery>

				<cfif len(getValue.lastYear)>
					<CFQUERY BLOCKFACTOR="100" NAME="getAudit" Datasource="Corporate">
					SELECT ID, Year_, Status, lastYear, xGUID, RescheduleNextYear, AuditDays, LeadAuditor, Auditor, AuditorInTraining
					FROM AuditSchedule
					WHERE xGUID = #getValue.lastYear#
					</cfquery>

					<cfset AuditTeam = valueList(getAudit.LeadAuditor)>
					<cfset AuditTeam = listAppend(AuditTeam, getAudit.Auditor)>
					<cfset AuditTeam = listAppend(AuditTeam, getAudit.AuditorInTraining)>


					<cfif getAudit.recordCount EQ 1>
					<a href="auditDetails.cfm?ID=#getAudit.ID#&Year=#getAudit.Year_#">#getAudit.Year_#-#getAudit.ID#</a>
						<cfif len(getAudit.AuditDays)>
							Days: #getAudit.AuditDays#<br>
						</cfif>

						Team: #listLen(AuditTeam)#<br>

						<cfif len(getAudit.Status)>
							<br><cfif getAudit.Status eq "Deleted">Cancelled<cfelse>#getAudit.Status#</cfif> - <img src="#IQARootDir#images/black.jpg" border="0">
						</cfif>

						<cfif getAudit.RescheduleNextYear eq "Yes">
							<cfset RescheduleYear = #getAudit.Year_# + 1>
							<br>Rescheduled for #RescheduleYear# - <img src="#IQARootDir#images/red.jpg" border="0">
						</cfif>
					<cfelse>
					N/A
					</cfif>
				<cfelse>
					N/A
				</cfif>
			<cfelse>
				N/A
			</cfif>
		</td>
		<!--- -3 --->
		<td>
			<cfif len(getAudit.lastYear)>
				<CFQUERY BLOCKFACTOR="100" NAME="getValue" Datasource="Corporate">
				SELECT lastYear
				FROM AuditSchedule
				WHERE xGUID = #getAudit.xGUID#
				</cfquery>

				<CFQUERY BLOCKFACTOR="100" NAME="getAudit" Datasource="Corporate">
				SELECT ID, Year_, Status, lastYear, xGUID, RescheduleNextYear, AuditDays, LeadAuditor, Auditor, AuditorInTraining
				FROM AuditSchedule
				WHERE xGUID = #getValue.lastYear#
				</cfquery>

				<cfset AuditTeam = valueList(getAudit.LeadAuditor)>
				<cfset AuditTeam = listAppend(AuditTeam, getAudit.Auditor)>
				<cfset AuditTeam = listAppend(AuditTeam, getAudit.AuditorInTraining)>


				<cfif getAudit.recordCount EQ 1>
				<a href="auditDetails.cfm?ID=#getAudit.ID#&Year=#getAudit.Year_#">#getAudit.Year_#-#getAudit.ID#</a>
					<cfif len(getAudit.AuditDays)>
						Days: #getAudit.AuditDays#<br>
					</cfif>

					Team: #listLen(AuditTeam)#<br>

					<cfif len(getAudit.Status)>
						<br><cfif getAudit.Status eq "Deleted">Cancelled<cfelse>#getAudit.Status#</cfif> - <img src="#IQARootDir#images/black.jpg" border="0">
					</cfif>

					<cfif getAudit.RescheduleNextYear eq "Yes">
						<cfset RescheduleYear = #getAudit.Year_# + 1>
						<br>Rescheduled for #RescheduleYear# - <img src="#IQARootDir#images/red.jpg" border="0">
					</cfif>
				<cfelse>
				N/A
				</cfif>
			<cfelse>
				N/A
			</cfif>
		</td>
	</tr>
	</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->