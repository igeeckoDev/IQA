<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='AuditMatrix.cfm?Year=#URL.year#'>Audit Schedule</a> - Edit Audit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif structKeyExists(form,'submit')>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewAudit">
	SELECT Year_, ID, LeadAuditor, Auditor, AuditorInTraining, Approved, AuditedBy
	FROM AuditSchedule
	WHERE xGUID = #URL.AuditID#
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="updateAudit">
	Update AuditSchedule
	SET
	<!---AuditArea = '#Form.AuditArea#',--->
	Email = <cfif len(Form.Email)>'#Form.Email#'<cfelse>NULL</cfif>,
	Email2 = <cfif len(Form.Email2)>'#Form.Email2#'<cfelse>NULL</cfif>,
		<cfif Form.SME neq "NoChanges" AND form.SME neq "None">
				SME = '#Form.SME#',
		<cfelseif Form.SME eq "None">
				SME = NULL,
		</cfif>
	Desk = '#Form.Desk#',
	BusinessUnit = '#Form.BusinessUnit#',
	LeadAuditor = '#Form.LeadAuditor#',
	Auditor = <cfif form.Auditor eq "None">NULL<cfelse>'#Form.Auditor#'</cfif>,
	AuditorInTraining = <cfif form.AuditorInTraining eq "None">NULL<cfelse>'#Form.AuditorInTraining#'</cfif>,
	Notes = <cfqueryparam value="#Form.Notes#" CFSQLTYPE="cf_sql_clob">

	WHERE xGUID = #URL.AuditID#
	</cfquery>

	<!--- Did Auditors Change? --->
	<cfif form.LeadAuditor NEQ "#viewAudit.LeadAuditor#" AND form.LeadAuditor NEQ "NoChanges">
    	<!---Lead Auditor = #FORM.LeadAuditor#<br />--->
		<cfset LeadChange = "Yes">
		<cfset Orig.LeadAuditor = viewaudit.LeadAuditor>
    <cfelse>
        <cfset LeadChange = "No">
    </cfif>

	<cfif form.Auditor NEQ "#viewAudit.Auditor#" AND Form.Auditor NEQ "NoChanges">
		<cfset AuditorChange = "Yes">
		<cfset Orig.Auditor = viewaudit.Auditor>
    <cfelse>
		<cfset AuditorChange = "No">
	</cfif>

	<cfif form.AuditorInTraining NEQ "#viewAudit.AuditorInTraining#" AND Form.AuditorInTraining NEQ "NoChanges">
        <cfset InTrainingChange = "Yes">
		<cfset Orig.AuditorInTraining = viewaudit.AuditorInTraining>
    <cfelse>
		<cfset InTrainingChange = "No">
	</cfif>

<!--- emails if audit team has changed --->
<cfif LeadChange eq "Yes" OR AuditorChange eq "Yes" OR InTrainingChange eq "Yes">
    <cfif ViewAudit.Approved eq "Yes" AND ViewAudit.AuditedBy eq "IQA">

	<Cfset AuditorBeforeEmails = "">

	<!--- add lead auditor field email --->
    <cfif len(ViewAudit.LeadAuditor)>
        <cfloop index = "ListElement" list = "#ViewAudit.LeadAuditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorBeforeEmails = listAppend(AuditorBeforeEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor field emails --->
    <cfif len(ViewAudit.Auditor)>
        <cfloop index = "ListElement" list = "#ViewAudit.Auditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorBeforeEmails = listAppend(AuditorBeforeEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor in training field emails --->
    <cfif len(ViewAudit.AuditorInTraining)>
        <cfloop index = "ListElement" list = "#ViewAudit.AuditorInTraining#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorBeforeEmails = listAppend(AuditorBeforeEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    <!--- /// --->

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewAudit">
	SELECT Year_, ID, LeadAuditor, Auditor, AuditorInTraining, Approved, AuditedBy, AuditArea, AuditType2, Area, OfficeName
	FROM AuditSchedule
	WHERE xGUID = #URL.AuditID#
	</cfquery>

	<Cfset AuditorAfterEmails = "">

	<!--- add lead auditor field email --->
    <cfif len(viewAudit.LeadAuditor)>
        <cfloop index = "ListElement" list = "#viewAudit.LeadAuditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorAfterEmails = listAppend(AuditorAfterEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor field emails --->
    <cfif len(viewAudit.Auditor)>
        <cfloop index = "ListElement" list = "#viewAudit.Auditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorAfterEmails = listAppend(AuditorAfterEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor in training field emails --->
    <cfif len(viewAudit.AuditorInTraining)>
        <cfloop index = "ListElement" list = "#viewAudit.AuditorInTraining#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorAfterEmails = listAppend(AuditorAfterEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    <!--- /// --->

        <cfmail
            to="#AuditorBeforeEmails#, #AuditorAfterEmails#"
            from="Internal.Quality_Audits@ul.com"
            cc="Kai.Huang@ul.com"
            subject="#Year_#-#ID#-IQA - Audit Team Changes"
            query="viewAudit"
            type="html">
        The audit team has changed for this audit. You are being sent this notification because you are part of the audit team.<br /><br />

		Audit Details:<br>
		Audit Type:
		<cfif auditArea IS "Certification Body (CB) Audit">
			Certification Body (CB) Audit
		<cfelseif AuditArea eq "Scheme Documentation Audit">
			Scheme Documentation Audit
		<cfelseif AuditArea eq "Certification Body Operations">
			Certification Body (CB) Audit
		<cfelse>
			#AuditType2#
		</cfif><br>
		Area: #Area#<Br>
		OfficeName: #OfficeName#<br><br>

        Changes:<Br /><Br>
		
        <cfif LeadChange eq "Yes">
			Lead Auditor<br>
			Changed From: <cfif len(Orig.LeadAuditor)>#Orig.LeadAuditor#<cfelse>No Lead Auditor Listed</cfif><br>
			To: <cfif len(LeadAuditor)>#LeadAuditor#<cfelse>No Lead Auditor Listed</cfif>
			<br /><Br>
        </cfif>

        <cfif AuditorChange eq "yes">
			Auditor(s)<br>
			Changed From: <cfif len(Orig.Auditor)>#Orig.Auditor#<cfelse>No Auditor(s) Listed</cfif><br>
			To: <cfif len(Auditor)>#replace(Auditor,",", "<br>", "All")#<cfelse>No Auditor(s) Listed</cfif>		
			<br /><br>
        </cfif>

        <cfif InTrainingChange eq "yes">
			Auditor(s) In Training<br>
			Changed From: <cfif len(#Orig.AuditorInTraining#)>#Orig.AuditorInTraining#<cfelse>No Auditor(s) In Training Listed</cfif><Br>
			To: <cfif len(AuditorInTraining)>#replace(AuditorInTraining,",", "<br>", "All")#<cfelse>No Auditor(s) In Training Listed</cfif><br /><Br>
        </cfif>

        If you believe there is an error in the changes, please contact #LeadAuditor# (Lead Auditor) or Kai Huang.<Br /><br />

        <a href="http://usnbkiqas100p/departments/snk5212/IQA/AuditDetails.cfm?ID=#ID#&Year=#Year_#">Audit Details</a>
        </cfmail>
    </cfif>
</cfif>
<!--- /// --->
	
	<cflocation url="AuditDetails.cfm?ID=#viewAudit.ID#&Year=#viewAudit.Year_#" addtoken="no">
<cfelse>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="viewAudit">
		SELECT *
		FROM AuditSchedule
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
		<cfif Desk eq 1>
			Yes
		<cfelseif Desk eq 0>
			No
		<cfelse>
			#Desk#
		</cfif>
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
		Not Editable
	</td>

	<td>
		To move an audit, please reschedule via the <a href="auditdetails.cfm?ID=#ID#&Year=#Year_#" target="_blank">Audit Details</a> page.
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
			<OPTION VALUE="Commercial and Industrial">Commercial and Industrial</OPTION>
			<OPTION VALUE="Consumer">Consumer</OPTION>
			<OPTION VALUE="Life and Health">Life and Health</OPTION>
			<OPTION VALUE="Supply Chain and Sustainability">Supply Chain and Sustainability</OPTION>
			<OPTION VALUE="UL University">UL University</OPTION>
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

<!--- Notes --->
	<tr>
		<th colspan="8" align="left">
		Notes
		</th>
	</tr>
	<tr>
		<td colspan="8">
			<textarea WRAP="PHYSICAL" ROWS="5" COLS="60" NAME="Notes" displayname="Notes" value="">#Notes#</textarea>
		</td>
	</tr>

<!--- notes to lead auditor --->
	<cfif len(NotesToLeadAuditor)>
		<tr>
			<th colspan="8" align="left">
			Notes to Lead Auditor
			</th>
		</tr>
		<tr>
			<td colspan="8">
				#NotesToLeadAuditor#
			</td>
		</tr>
	</cfif>
	</table>
	<br>

	<input name="Submit" type="Submit" value="Submit">
	</form>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->