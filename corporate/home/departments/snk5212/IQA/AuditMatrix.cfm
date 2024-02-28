<cfif NOT isDefined("URL.Year")>
	<cfset URL.Year = curYear>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start OF PAGE HTML --->
<cfset subTitle = "Internal Quality Audits (IQA) AUDIT SCHEDULE - #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfinclude template="#IQADir#cfscript_queryStringRemoveItem.cfm">

<cfset qs = cgi.query_string>
<b>
	View Year
</b>
<cfoutput>
	<cfloop from=2012 to=#nextYear# index=i>
		-
		<a href="#CGI.ScriptName#?Year=#i#">
			#i#
		</a>
		&nbsp;
	</cfloop>
	<br>
	<Br>
</cfoutput>

<cfoutput>
	<cfset newURL = queryStringDeleteVar("Month", qs)>
	<b>
		Month
	</b>
	:
	<cfif isDefined("URL.Month")>
		<b>
			#monthAsString(url.Month)#
		</b>
		[
		<A href="#CGI.ScriptName#?#newURl#">
			remove
		</A>
		]
	<cfelse>
		All
	</cfif>
	<br>
	<SELECT NAME="MonthJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">
			Select Month Below
		<option value="javascript:document.location.reload();">
			<cfloop index="i" from="1" to="12">
		<OPTION VALUE="#CGI.ScriptName#?#newURL#&Month=#i#">#MonthAsString(i)#</OPTION> </cfloop>
	</SELECT>
	<br>
	<br>
	<cfset newURL = queryStringDeleteVar("AuditType2", qs)>
	<b>
		Audit Type
	</b>
	:
	<cfif isDefined("URL.AuditType2")>
		<b>
			#URL.AuditType2#
		</b>
		[
		<A href="#CGI.ScriptName#?#newURl#">
			remove
		</A>
		]
	<cfelse>
		All
	</cfif>
	<br>
	<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">
			Select Audit Type Below
		<option value="javascript:document.location.reload();">
		<Option value="#CGI.ScriptName#?#newURL#">
			:: View All Audit Types
		</Option>
		<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Global Function/Process">
			Global Function/Process
		</Option>
		<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Local Function">
			Local Function
		</Option>
		<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Program">
			Program
		</Option>
		<Option value="#CGI.ScriptName#?#newURL#&AuditType2=Scheme Documentation">
			Scheme Documentation Audits
		</Option>
		<Option value="#CGI.ScriptName#?#newURL#&AuditType2=CB Audits">
			Certification Body (CB) Audits
		</Option>
	</select>
	<br>
	<br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
    SELECT * FROM AuditorList
	WHERE (Status = 'Active' OR Status = 'In Training')
	AND IQA = 'Yes'
	ORDER BY Auditor
</CFQUERY>
<Cfoutput>
	<cfset newURL = queryStringDeleteVar("Auditor", qs)>
	<b>
		Auditor
	</b>
	:
	<cfif isDefined("URL.Auditor")>
		<b>
			#URL.Auditor#
		</b>
		[
		<A href="#CGI.ScriptName#?#newURl#">
			remove
		</A>
		]
	<cfelse>
		All
	</cfif>
	<br>
</Cfoutput>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">
		Select Auditor Below
	<option value="javascript:document.location.reload();">
		<cfoutput>
	<Option value="#CGI.ScriptName#?#newURl#">:: VIEW ALL Auditors</Option> </cfoutput>
	<cfoutput query="Auditor">
		<Option value="#CGI.ScriptName#?#newURl#&Auditor=#Auditor#">
			#Auditor#
		</Option>
	</cfoutput>
</select>
<br>
<br>

<CFQUERY BLOCKFACTOR="100" NAME="Offices" Datasource="Corporate">
    SELECT DISTINCT OfficeName FROM AuditSchedule
	WHERE AuditArea <> 'Certification Body (CB) Audit'
	AND OfficeName <> 'Global'
	AND AuditedBy = 'IQA'
	AND Year_ = '#URL.Year#'
	AND Month > 0
	ORDER BY OfficeName
</cfquery>
<Cfoutput>
	<cfset newURL = queryStringDeleteVar("OfficeName", qs)>
	<b>
		Office
	</b>
	:
	<cfif isDefined("URL.Officename")>
		<b>
			#URL.Officename#
		</b>
		[
		<A href="#CGI.ScriptName#?#newURl#">
			remove
		</A>
		]
	<cfelse>
		All
	</cfif>
	<br>
</Cfoutput>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">
		Select Office Below
	<option value="javascript:document.location.reload();">
		<cfoutput>
	<Option value="#CGI.ScriptName#?#newURl#">:: VIEW ALL Offices</Option> </cfoutput>
	<cfoutput query="Offices">
		<Option value="#CGI.ScriptName#?#newURl#&OfficeName=#OfficeName#">
			#OfficeName#
		</Option>
	</cfoutput>
</select>
<br>
<br>

<CFQUERY BLOCKFACTOR="100" NAME="Programs" Datasource="Corporate">
    SELECT DISTINCT Area
	FROM AuditSchedule
	WHERE AuditType2 = 'Program'
	AND AuditedBy = 'IQA'
	AND Year_ = #URL.Year#
	AND Month > 0
	ORDER BY Area
</cfquery>
<Cfoutput>
	<cfset newURL = queryStringDeleteVar("Program", qs)>
	<b>
		Programs
	</b>
	:
	<cfif isDefined("URL.Program")>
		<b>
			#URL.Program#
		</b>
		[
		<A href="#CGI.ScriptName#?#newURl#">
			remove
		</A>
		]
	<cfelse>
		All
	</cfif>
	<br>
</Cfoutput>
<SELECT NAME="TypeJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">
		Select Programs Below
	<option value="javascript:document.location.reload();">
		<cfoutput>
	<Option value="#CGI.ScriptName#?#newURl#">:: VIEW ALL Programss</Option> </cfoutput>
	<cfoutput query="Programs">
		<Option value="#CGI.ScriptName#?#newURl#&Program=#Area#">
			#Area#
		</Option>
	</cfoutput>
</select>
<br>
<br>
See the Notes below this Table FOR useful information
<br>
<br>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewAudits">
    SELECT * FROM AuditSchedule
	WHERE Year_ = #URL.Year#
	AND
	AuditedBY = 'IQA'
	AND Month > 0
	AND (Status IS NULL OR Status = 'Deleted')
		<Cfif isDefined("URL.NoAuditDays")
	        AND URL.NoAuditDays eq "Yes">
	        AND AuditDays IS NULL
		</cfif>
	   	<Cfif isDefined("URL.NoPrimaryContact")
	        AND URL.NoPrimaryContact eq "Yes">
	   		AND (Email = 'TBD'
	        OR Email IS NULL)</cfif>
		<Cfif isDefined("URL.NoLead")>
		    AND URL.NoLead eq "Yes">
   			AND LeadAuditor IS NULL
		</cfif>
		<cfif isDefined("URL.Auditor")>
			AND (LeadAuditor = '#URL.Auditor#'
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
		        AND AuditType2 = 'Program'
				AND AuditArea = 'Scheme Documentation Audit'
			<cfelseif URL.AuditType2 eq "CB Audits">
		        AND AuditType2 = 'Local Function'
		        AND AuditArea = 'Certification Body (CB) Audit'
			<cfelseif URL.AuditType2 eq "Local Function">
		        AND AuditType2 = 'Local Function'
        		AND AuditArea <> 'Certification Body (CB) Audit'
			<cfelseif URL.AuditType2 eq "Program">
				AND AuditType2 = 'Program'
        		AND AuditArea <> 'Scheme Documentation Audit'
			<cfelse>
				AND AuditType2 = '#URL.AuditType2#'
			</cfif>
		</cfif>
		<cfif isDefined("Month")>
        AND MONTH = #URL.Month#
		</cfif>

    ORDER BY
        Month, AuditType2, OfficeName, Area
</cfquery>

<cfset MonthHolder="">
<table border="1" width="1000" style="border-collapse: collapse;">
	<tr>
		<th>
			Audit Number
		</th>
		<th>
			Month / Audit Dates
		</th>
		<th>
			Audit Type
		</th>
		<th>
			<cfif isDefined("URL.AuditType2")>
				<cfif URL.AuditType2 eq "CB Audits">
					Legal Entity / Certification Body
				<cfelse>
					Office Name
				</cfif>
			<cfelse>
				Office Name / Legal Entity
			</cfif>
		</th>
		<th>
			Area
		</th>
		<th>
			Business Units
		</th>
		<th>
			Audit Team
		</th>
		<th>
			Primary/Other Contacts
		</th>
		<th>
			Actions
		</th>
	</tr>
	<cfset i = 1>
	<cfoutput query="viewAudits">
		<cfif MonthHolder IS NOT Month>
			<tr>
				<th colspan="9" align="left">
					#MonthAsString(Month)#
				</th>
			</tr>
		</cfif>
		<tr valign="top">
			<td>
				<A href="AuditDetails.cfm?Year=#Year_#&ID=#ID#">
					#Year_#-#ID#-IQA
				</a>
				<br>
				<br>
			</td>
			<td>
				#MonthAsString(Month)#
				<br>
				<br>
				<!--- uses incDates.cfc --->
				<cfinvoke
					component="IQA.Components.incDates"
					returnvariable="DateOutput"
					method="incDates">
					<cfif len(StartDate)>
						<cfinvokeargument name="StartDate" value="#StartDate#">
					<cfelse>
						<cfinvokeargument name="StartDate" value="">
					</cfif>
					<cfif len(EndDate)>
						<cfinvokeargument name="EndDate" value="#EndDate#">
					<cfelse>
						<cfinvokeargument name="EndDate" value="">
					</cfif>
					<cfinvokeargument name="Status" value="#Status#">
					<cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
				</cfinvoke>
				<!--- OUTPUT OF incDates.cfc --->
				#DateOutput#
				<br />
				<br />
				<!--- ONLY show FOR active audits --->
				<cfif NOT len(Status)>
					<u>
						Audit Days
					</u>
					:
					<br>
					<cfif len(AuditDays)>
						#AuditDays#
					<cfelse>
						None Listed
					</cfif>
				</cfif>
			</td>
			<td>
				<cfif auditArea IS "Certification Body (CB) Audit">
					Certification Body (CB) Audit
				<cfelseif AuditArea eq "Scheme Documentation Audit">
					Scheme
				<cfelseif AuditArea eq "Certification Body Operations">
					Certification Body (CB) Audit
				<cfelse>
					#AuditType2#
				</cfif>
			</td>
			<td>
				<cfif auditArea IS "Certification Body (CB) Audit">
					<u>
						Legal Entity
					</u>
					<br>
					#OfficeName#
				<cfelse>
					#OfficeName#
				</cfif>
			</td>
			<td>
				<!--- NOT CB AND NOT Scheme Documentation --->
				<cfif auditArea neq "Certification Body (CB) Audit" AND AuditArea neq "Scheme Documentation Audit">
					#Area#
					<br>
					<br>
					(#AuditArea#)
				</cfif>
				<!--- CB Audits - list programs --->
				<cfif auditArea IS "Certification Body (CB) Audit">
					Certification Body (CB) Audit of #OfficeName#
					<br>
					<br>

					<CFQUERY BLOCKFACTOR="100" NAME="CBSchemes" Datasource="UL06046" username="#OracleDB_Username#"
					password="#OracleDB_Password#">
           			SELECT
					Corporate.ProgDev.Program
					FROM
					Corporate.ProgDev, CBAudits, CBAudits_SchemeAssignment
					WHERE
					CBAudits.ID = CBAudits_SchemeAssignment.CB_ID
					AND CBAudits_SchemeAssignment.programID = Corporate.ProgDev.ID
						<cfif OfficeName eq "UL LLC (US/Canada Safety Scheme, AECO, Water, Food)">
							AND CBAudits.Name = 'UL LLC (US/Canada Safety Scheme, AECO, Water, Food, Furniture)'
						<cfelse>
							AND CBAudits.Name = '#OfficeName#'
						</cfif>
					AND CBAudits_SchemeAssignment.status IS NULL
					AND (CBAudits_SchemeAssignment.AddYear IS NULL OR CBAudits_SchemeAssignment.AddYear <= #url.year#)
					ORDER BY
					Corporate.ProgDev.Program
					</cfquery>
					<u>
						Included Schemes
					</u>
					<Br>
					<cfloop query="CBSchemes">
						:: #Program#
						<br>
					</cfloop>
					<br>
				</cfif>
				<!--- Scheme Documentation AUDIT --->
				<cfif auditArea IS "Scheme Documentation Audit">
					#Area#
					<Br>
					<br>
					Scheme Documentation Audit
					<cfif NOT len(Status)>
						<br>
						<br>
						<u>
							Legal Entity / Certification Body
						</u>
						<br>

						<CFQUERY BLOCKFACTOR="100" NAME="CBName" Datasource="UL06046" username="#OracleDB_Username#"
						password="#OracleDB_Password#">
            				SELECT CBAudits.Name
							FROM Corporate.ProgDev, CBAudits, CBAudits_SchemeAssignment
							WHERE CBAudits.ID = CBAudits_SchemeAssignment.CB_ID
							AND	CBAudits_SchemeAssignment.programID = Corporate.ProgDev.ID
							AND ProgDev.Program = '#Area#'
						</cfquery>
						
						<cfloop query="CBName">
							:: #Name#<br>
						</cfloop>
					</cfif>
				</cfif>
			</td>
			<td>
				<cfif len(BusinessUnit)>
					- #replace(BusinessUnit, ",", "
					<br>
					- ", "All")#
				<cfelse>
					None Listed
				</cfif>
			</td>
			<td>
				<u>
					Lead
				</u>
				<br>
				- #LeadAuditor#
				<br>
				<br>
				<cfif len(Auditor)>
					<cfif Auditor neq "- None -">
						<u>
							Auditor(s)
						</u>
						<br>
						- #replace(Auditor, ",", "
						<br>
						- ", "All")#
						<br>
						<br>
					</cfif>
				</cfif>
				<cfif len(AuditorInTraining)>
					<cfif AuditorInTraining neq "- None -">
						<u>
							Auditor(s) IN Training
						</u>
						<Br>
						- #replace(AuditorInTraining, ",", "
						<br>
						- ", "All")#
						<br>
						<Br>
					</cfif>
				</cfif>
				<cfif len(SME)>
					<cfif len(SME) AND SME neq "- None -">
						<u>
							Subject Matter Expert
						</u>
						<Br>
						- #replace(SME, ",", "
						<br>
						- ", "All")#
					</cfif>
				</cfif>
			</td>
			<td>
				<cfif auditArea IS "Certification Body (CB) Audit">
					<u>
						Primary Contact (Top Management)
					</u>
					<br>
					- #Email#
					<br>
					<br>
					<cfif len(Email2)>
						<u>
							Other
						</u>
						<br>
						- #replace(Email2, ",", "
						<br>
						- ", "All")#
						<br>
						<br>
					</cfif>
				<Cfelse>
					<u>
						Primary Contact
					</u>
					<br>
					- #Email#
					<br>
					<br>
					<cfif len(Email2)>
						<u>
							Other
						</u>
						<br>
						- #replace(Email2, ",", "
						<br>
						- ", "All")#
						<br>
						<br>
					</cfif>
				</cfif>
				<!--- Scheme Documentation Audits - Identify the Scheme Owner --->
				<cfif auditArea IS "Scheme Documentation Audit">

					<CFQUERY BLOCKFACTOR="100" NAME="SchemeOwner" Datasource="Corporate">
				    SELECT
				        SchemeOwner
				    FROM
				        ProgDev
				    WHERE
				        PROGRAM = '#Area#'
					</cfquery>

					<u>
						Scheme Owner
					</u>
					<Br>
					-
					<cfif len(SchemeOwner.SchemeOwner)>
						#SchemeOwner.SchemeOwner#
					<cfelse>
						None Listed
					</cfif>
					<br>
					<br>
				</cfif>
			</td>
			<td width="150">
				::
				<A href="AuditDetails.cfm?Year=#Year_#&ID=#ID#">
					Audit Details
				</a>
				<br>
				::
				<a href="AuditHistory.cfm?xGUID=#xGUID#">
					Audit History
				</a>
				<br>
				<br>
				
				<!--- Desk AUDIT --->
				<cfif Desk is "Yes">
					Desk Audit
				<cfelseif Desk is "Blended">
					Blended Audit
				<cfelseif Desk is "No">
					On-site Audit
				</cfif><br><br>
				
				<!---
				<cfif Desk IS "Yes">
					Desk Audit
					<br>
					<br>
				</cfif>
				--->
				
				<!--- Status --->
				<cfinclude template="#IQADir#status_colors_matrix.cfm">
				<Br>
				<br>
				<!---<cfif len(NotesToLeadAuditor)><u>Notes TO Lead</u>:<br>#NotesToLeadAuditor#</cfif>--->
			</td>
		</tr>
		<cfset MonthHolder = Month>
	</cfoutput>
</table>
<!--- Footer, END OF PAGE HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
