<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditPlanning.cfm?Year=#URL.year#'>Audit Planning</a> - Edit Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif structKeyExists(form,'submit')>
	<cfdump var="#Form#">

	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="updateAudit" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update AuditSchedule_Planning
	SET
	<!---AuditArea = '#Form.AuditArea#',--->
	<!--- Email = <cfif len(Form.Email)>'#Form.Email#'<cfelse>NULL</cfif>,--->
	<!---Email2 = <cfif len(Form.Email2)>'#Form.Email2#'<cfelse>NULL</cfif>,--->
	<cfif Form.SME neq "NoChanges" AND form.SME neq "None">
			SME = '#Form.SME#',
	<cfelseif Form.SME eq "None">
			SME = NULL,
	</cfif>
	AuditDays = '#Form.AuditDays#',
	Desk = '#Form.Desk#',
	Month = #Form.Month#,
	BusinessUnit = '#Form.BusinessUnit#',
	LeadAuditor = '#Form.LeadAuditor#',
	Auditor = <cfif form.Auditor eq "None">NULL<cfelse>'#Form.Auditor#'</cfif>,
	AuditorInTraining = <cfif form.AuditorInTraining eq "None">NULL<cfelse>'#Form.AuditorInTraining#'</cfif>,
	Notes = <cfqueryparam value="#Form.Notes#" CFSQLTYPE="cf_sql_clob">,
	NotesToLeadAuditor = <cfqueryparam value="#Form.NotesToLeadAuditor#" CFSQLTYPE="cf_sql_clob">

	WHERE xGUID = #URL.AuditID#
	</cfquery>

	<cfinclude template="#IQADir#cfscript_queryStringRemoveItem.cfm">
	<cfset qs = cgi.query_string>
	<cfset newURL = queryStringDeleteVar("auditID", qs)>

	<cflocation url="AuditPlanning.cfm?#newURL#" addtoken="no">
<cfelse>
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="viewAudit" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT *
		FROM AuditSchedule_Planning
		WHERE xGUID = #URL.AuditID#
	</cfquery>

	<cfoutput query="viewAudit">
	<B>#Year_#-#ID#-IQA</B><Br>
	<u>Audit Type</u> - #AuditType2#<br>
	<u>Location</u> - #OfficeName#<br>
	<u>Area</u> - #Area#<br><br>

<table border=1 width="850">
<tr>
	<th>&nbsp;</th>
	<th>Audit Days</th>
	<th>Month</th>
	<th>Lead Auditor</th>
	<th>Auditor(s)</th>
	<th>Auditor(s) In Training</th>
	<th>Business Units</th>
	<th>Desk Audit</th>
</tr>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="#CGI.Script_Name#?#CGI.Query_String#">
<tr valign="top">
	<td>
	<b>Current Values</b><br><br>
	</td>

	<td align="center">
	<cfif len(AuditDays)>#AuditDays#<cfelse>None Listed</cfif>
	</td>

	<td>
	#MonthAsString(Month)#
	</td>

	<td>
	#leadAuditor#
	</td>

	<td>
	<cfif len(Auditor) AND Auditor neq "- None -">#Auditor#<cfelse>None Listed</cfif>
	</td>

	<td>
	<cfif len(AuditorInTraining) AND AuditorInTraining neq "- None -">#AuditorInTraining#<cfelse>None Listed</cfif>
	</td>

	<td>
	<cfif len(BusinessUnit)>#replace(BusinessUnit, ",", "<br>", "All")#<cfelse>None Listed</cfif>
	</td>

	<td>
	<cfif len(Desk)>
		#Desk#
	<cfelse>
		N/A
	</cfif>
	</td>
</tr>
<tr valign="top">
	<td>
	<b>New Values</b>
	</td>

	<td>
	<SELECT NAME="AuditDays">
		<cfloop from="1" to="15" index="i">
			<Option value="#i#" <cfif i eq AuditDays> selected</cfif>>#i#<cfif i eq AuditDays></cfif></Option>
		</cfloop>
	</select>
	</td>

	<td>
	<SELECT NAME="Month">
		<cfloop from="1" to="12" index="i">
			<Option value="#i#" <cfif i eq Month>selected</cfif>>#monthAsString(i)#</Option>
		</cfloop>
	</select>
	</td>

	<td>
	<CFQUERY BLOCKFACTOR="100" NAME="AuditorList" Datasource="Corporate">
	SELECT Auditor as queryAuditor
	FROM AuditorList
	WHERE Status = 'Active'
	AND IQA = 'Yes'
	AND Lead = 'Yes'
	ORDER BY Auditor
	</CFQUERY>

	<SELECT NAME="LeadAuditor">
		<cfloop query="AuditorList">
			<Option value="#queryAuditor#" <cfif queryAuditor eq viewAudit.LeadAuditor>selected</cfif>>#queryAuditor#</Option>
		</cfloop>
	</select>
	</td>

	<td>
	<CFQUERY BLOCKFACTOR="100" NAME="AuditorList" Datasource="Corporate">
	SELECT *
	FROM AuditorList
	WHERE Status = 'Active'
	AND IQA = 'Yes'
	ORDER BY Auditor
	</CFQUERY>

	<cfset selectSize = AuditorList.recordCount + 2>

	<SELECT NAME="Auditor" multiple="multiple" size="#SelectSize#">
		<OPTION Value="#Auditor#" selected>Keep Current Selection
		<OPTION value="None">No Auditor(s)
		<cfloop query="AuditorList">
 	       <OPTION VALUE="#Auditor#">#Auditor#
        </cfloop>
	</SELECT>
	</td>

	<td>
	<CFQUERY BLOCKFACTOR="100" NAME="AuditorList" Datasource="Corporate">
	SELECT *
	FROM AuditorList
	WHERE Status = 'In Training'
	AND IQA = 'Yes'
	ORDER BY Auditor
	</CFQUERY>

	<SELECT NAME="AuditorInTraining" multiple="multiple" size="#SelectSize#">
		<OPTION Value="#AuditorInTraining#" selected>Keep Current Selection
		<OPTION value="None">No Auditor(s) In Training
		<cfloop query="AuditorList">
 	       <OPTION VALUE="#Auditor#">#Auditor#
        </cfloop>
	</SELECT>
	</td>
	<td>
		<SELECT NAME="BusinessUnit" multiple="multiple" size="6">
			<OPTION Value="#BusinessUnit#" selected="selected">Keep Current Selection
			<OPTION VALUE="Retail and Industry">Retail and Industry</OPTION>
			<OPTION VALUE="Connected Technology">Connected Technology</OPTION>
	<OPTION VALUE="Corporate/Field Services">Corporate/Field Services</OPTION>
		</SELECT><br /><br />
	</td>
	<td>
		<cfswitch expression="#Desk#">
			<cfcase value="Yes">
				Yes <INPUT TYPE="Radio" name="Desk" value="Yes" checked> No <INPUT TYPE="Radio" name="Desk" value="No">
			</cfcase>
			<cfcase value="No">
				Yes <INPUT TYPE="Radio" name="Desk" value="Yes"> No <INPUT TYPE="Radio" name="Desk" value="No" checked>
			</cfcase>
			<cfcase value="">
				Yes <INPUT TYPE="Radio" name="Desk" value="Yes"> No <INPUT TYPE="Radio" name="Desk" value="No">
			</cfcase>
		</cfswitch>
	</td>
	</tr>

<!---
	<tr>
		<td colspan="8" align="left">
			<b>Audit Area</b>
		</td>
	</tr>
		<td colspan="8">
			<input type="text" value="#AuditArea#" Name="AuditArea" size="80">
		</td>
	</tr>
--->

<!---
<!--- primary contact --->
	<tr>
		<td colspan="8" align="left">
			<b>Primary Contact</b> - UL External Email addresses only [<a href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_Blank">Look Up Email</a>]
		</td>
	</tr>
		<td colspan="8">
			<input type="text" value="#Email#" Name="Email" size="80">
		</td>
	</tr>

<!--- other contacts --->
	<tr>
		<td colspan="8" align="left">
			<b>Other Contact(s)</b> - UL External Email addresses only, separate with a comma [<a href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_Blank">Look Up Email</a>]
		</td>
	</tr>
		<td colspan="8">
			<input type="text" value="#Email2#" Name="Email2" size="120">
		</td>
	</tr>
--->
	
<!--- SME --->

	<CFQUERY Name="SMEList" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT *
	FROM SME
	WHERE Status IS NULL
	ORDER BY SME
	</cfquery>

	<cfset selectSize = SMEList.recordCount + 2>

	<tr>
		<td colspan="8" align="left">
			<b>SME</b> - Current Selection: <cfif len(SME) AND SME neq "- None -"><b>#SME#</b><cfelse>None</cfif>
		</td>
	</tr>
		<td colspan="8">
			<SELECT NAME="SME" size="#SelectSize#">
				<OPTION Value="NoChanges" selected>Keep Current Selection
				<OPTION value="None">None
				<cfloop query="SMEList">
		 	       <OPTION VALUE="#SME#">#SME#
		        </cfloop>
			</SELECT>
		</td>
	</tr>

<!--- Planning Notes --->
	<tr>
		<th colspan="8" align="left">
		Planning Notes
		</th>
	</tr>
	<tr>
		<td colspan="8">
			<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="Notes" displayname="Notes" value="">#Notes#</textarea>
		</td>
	</tr>

<!--- notes to lead auditor --->
	<tr>
		<th colspan="8" align="left">
		Notes to Lead Auditor
		</th>
	</tr>
	<tr>
		<td colspan="8">
			<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="NotesToLeadAuditor" displayname="Notes" value="">#NotesToLeadAuditor#</textarea>
		</td>
	</tr>
	</table>
	<br>

	<input name="Submit" type="Submit" value="Submit">
	</form>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->