<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Edit Audit - <cfoutput>#URL.Year#-#URL.ID#</cfoutput>">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfoutput>
    <script
        language="javascript"
        type="text/javascript"
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>

    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFQUERY BLOCKFACTOR="100" NAME="ExternalLocation" Datasource="Corporate">
	SELECT ExternalLocation FROM ExternalLocation
	ORDER BY ExternalLocation
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="KP" Datasource="Corporate">
	SELECT KP FROM KP
	ORDER BY KP
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="RD">
SELECT RD.ID, RD.KPID, RD.RDNumber, RD.RD, KP.KP, KP.ID FROM RD, KP
WHERE KP.ID = RD.KPID
ORDER BY KP.KP, RD.RD
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year
FROM AuditSchedule
WHERE ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

<cfif scheduleedit.AuditType2 is "Field Services">
<CFQUERY BLOCKFACTOR="100" NAME="FUS" Datasource="Corporate">
	SELECT * FROM FUSAreas
	ORDER BY Area
</cfquery>
</cfif>

<cflock scope="SESSION" timeout="60">
	<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
	SELECT * FROM IQAtblOffices
	WHERE Exist <> 'No'
	AND CB = 'No'
    <cfif SESSION.Auth.AccessLevel NEQ "SU"
		AND SESSION.Auth.AccessLevel NEQ "Admin"
		AND SESSION.Auth.AccessLevel NEQ "IQAAuditor">
		<cfif isDefined("SESSION.Auth.SubRegion")>
			AND SubRegion = '#SESSION.Auth.SubRegion#'
	    </cfif>
    </cfif>
	ORDER BY OfficeName
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" NAME="Auditor" Datasource="Corporate">
	SELECT *
    FROM AuditorList
	WHERE (Status = 'Active' OR Status = 'In Training')
    <cfif SESSION.Auth.AccessLevel NEQ "SU"
		AND SESSION.Auth.AccessLevel NEQ "Admin"
		AND SESSION.Auth.AccessLevel NEQ "IQAAuditor">
		<cfif isDefined("SESSION.Auth.SubRegion")>
            AND SubRegion = '#SESSION.Auth.SubRegion#'
        </cfif>
	</cfif>
	<cfif ScheduleEdit.audittype2 is "Corporate"
		OR ScheduleEdit.audittype2 is "Program"
		OR ScheduleEdit.audittype2 is "Scheme Documentation Audit"
		OR ScheduleEdit.audittype2 is "Local Function"
		OR ScheduleEdit.audittype2 is "Local Function FS"
		OR ScheduleEdit.audittype2 is "Global Function/Process">
		AND QUALIFIED LIKE '%Quality System%'
	<cfelseif ScheduleEdit.audittype2 is "Local Function CBTL">
		AND QUALIFIED LIKE '%CBTL%'
	<cfelse>
		AND QUALIFIED LIKE '%#ScheduleEdit.AuditType2#%'
	</cfif>
    <cfif ScheduleEdit.AuditedBy NEQ "IQA">
        <!--- Adding an audit for another region --->
        AND SubRegion = '#ScheduleEdit.AuditedBy#'
        <!--- /// --->
    </cfif>
	ORDER BY LastName
	</cfquery>
</cflock>

<div align="Left" class="blog-time">
Schedule/Edit an Audit Help - <A HREF="javascript:popUp('../webhelp/webhelp_scheduleaudit.cfm')">[?]</A></div>

<!--- audit details output open--->
<cfoutput query="ScheduleEdit">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="edit2.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">

<!--- Month Edit--->
Month Scheduled: (required)<br>
<SELECT NAME="e_Month" displayname="Month">
		<option value="">Select Month Below
		<option value="">---
<cfloop index="i" to="12" from="1">
		<OPTION VALUE="#i#" <cfif Month is i>SELECTED</cfif>>#MonthAsString(i)#
</cfloop>
</SELECT>
<br><br>

<!--- Date Edit--->
Start Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="StartDate" VALUE="<cfset Start = #StartDate#>#DateFormat(Start, 'mm/dd/yyyy')#" onChange="return ValidateSDate()"><br><br>

<cfif audittype2 is NOT "Global Function/Process">
End Date (please use this format - mm/dd/yyyy)<br>
<INPUT TYPE="Text" NAME="EndDate" VALUE="<cfset End = #EndDate#>#DateFormat(End, 'mm/dd/yyyy')#" onChange="return ValidateEDate()"><br><br>
<cfelse>
* - End Date is not recorded for a Global Document Desk Audit, the Audit Report date will be used as the End Date.<br><br>
<INPUT TYPE="hidden" NAME="EndDate" VALUE="">
</cfif>
</cfoutput>

<!--- Lead Auditor Edit--->
<cflock scope="SESSION" timeout="60">
<!--- Auditor Edit is not available if you are logged in as the auditor of the audit --->
<!--- No longer used
<cfif SESSION.Auth.AccessLevel is "IQAAuditor">
<cfoutput query="ScheduleEdit">
<input type="hidden" name="LeadAuditor" value="#LeadAuditor#">
Lead Auditor:<br>
#LeadAuditor#
</cfoutput>
<cfelse>
--->
<cfoutput query="ScheduleEdit">
Lead Auditor: #leadauditor# (required)<br>
</cfoutput>
<!--- audit details output closed--->
<SELECT NAME="LeadAuditor">
	<Option Value="NoChanges" selected>No Changes
	<OPTION value="- None -">- None -
		<!--- auditor list output open--->
        <CFOUTPUT QUERY="Auditor">
        	<cfif Lead eq "Yes" AND Status eq "Active">
	        	<OPTION VALUE="#Auditor#" <!---<cfif Auditor eq SESSION.Auth.Name>selected</cfif>--->>#Auditor#
    		</cfif>
        </CFOUTPUT>
		<!--- auditor list output closed--->
</SELECT>
<!---</cfif>--->
</cflock>
<br><br>

<!--- auditor edit--->
<!--- audit details output Open--->
<cfoutput query="ScheduleEdit">
Auditor(s):<br />
	<cfif len(auditor)>
        <cfif Auditor eq "- None -">
            None Listed
        <cfelse>
            #replace(auditor, ",", "<br />", "All")#
        </cfif>
    <cfelse>
    	None Listed
    </cfif><br />
</cfoutput>
<!--- audit details output closed--->
<SELECT NAME="Auditor" multiple="multiple">
	<Option Value="NoChanges" selected>No Changes
	<OPTION VALUE="- None -">- None -
		<!--- auditor list output open--->
        <CFOUTPUT QUERY="Auditor">
        	<cfif Status eq "Active">
	            <OPTION VALUE="#Auditor#">#Auditor#
    		</cfif>
        </CFOUTPUT>
        <!--- auditor list output closed--->
</SELECT>
<br><br>

<!--- auditor in training edit--->
<!--- audit details output Open--->
<cfoutput query="ScheduleEdit">
Auditor(s) In Training:<br />
	<cfif isDefined("AuditorInTraining")>
		<cfif len(auditorInTraining)>
            <cfif AuditorInTraining eq "- None -">
                None Listed
            <cfelse>
                #replace(auditorInTraining, ",", "<br />", "All")#
            </cfif>
        <cfelse>
            None Listed
        </cfif>
	<cfelse>
    	None Listed
    </cfif><br />
</cfoutput>
<!--- audit details output closed--->
<SELECT NAME="AuditorInTraining" multiple="multiple">
	<Option Value="NoChanges" selected>No Changes
	<OPTION VALUE="- None -">- None -
		<!--- auditor list output open--->
        <CFOUTPUT QUERY="Auditor">
        	<cfif Status eq "In Training">
	            <OPTION VALUE="#Auditor#">#Auditor#
    		</cfif>
        </CFOUTPUT>
        <!--- auditor in training list output closed--->
</SELECT>
<br><br>

<!--- SME and AuditDays--->
<cfif URL.AuditedBy eq "IQA" AND URL.Year GTE 2015>
Audit Days - Number of On-Site Days: (required)<br>
<cfoutput query="ScheduleEdit">
	<u>Current</u>:
	<cfif isdefined("AuditDays") AND len(AuditDays)>
		#AuditDays#
		<input type="hidden" value="#AuditDays#" name="AuditDays">
	<cfelse>
		None Listed
		<input type="hidden" value="" name="AuditDays">
	</cfif><br><br>
</cfoutput>

<!---
<SELECT NAME="AuditDays" displayname="Audit Days">
	<Option Value="NoChanges" selected>No Changes
	<option value="">Select Audit Days
	<option value="">---
	<cfloop index="i" to="10" from="1">
		<Cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
	</cfloop>
</SELECT><br><br>
--->

Subject Matter Expert (SME):<br>
<cfoutput query="ScheduleEdit">
	<u>Current</u>:
	<cfif isDefined("SME") AND len(SME)>
		#SME#
	<cfelse>
		None Listed
	</cfif><Br>
</cfoutput>

	<CFQUERY Name="SME" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT *
	FROM SME
	WHERE Status IS NULL
	ORDER BY SME
	</cfquery>

	<SELECT NAME="SME">
		<Option Value="NoChanges" selected>No Changes
		<OPTION value="- None -">---
		<CFOUTPUT QUERY="SME">
		    <OPTION VALUE="#SME#">#SME#
	    </CFOUTPUT>
	</SELECT>
<br><br>
</cfif>

<cfif ScheduleEdit.audittype2 is NOT "Field Services">
<cfoutput query="ScheduleEdit">
<!---desk audit--->
Is this a Desk Audit?<br>
<cfswitch expression="#Desk#">
	<cfcase value="1">
	Yes <INPUT TYPE="Radio" name="Desk" value="1" checked> No <INPUT TYPE="Radio" name="Desk" value="0">
	</cfcase>
	<cfcase value="0">
	Yes <INPUT TYPE="Radio" name="Desk" value="1"> No <INPUT TYPE="Radio" name="Desk" value="0" checked>
	</cfcase>
	<cfcase value="">
	Yes <INPUT TYPE="Radio" name="Desk" value="1"> No <INPUT TYPE="Radio" name="Desk" value="0">
	</cfcase>
</cfswitch><br><br>
</CFOUTPUT>
</cfif>

<!--- TPTDP--->
<cfif ScheduleEdit.AuditType is "TPTDP">
<!--- audit details output Open--->
<cfoutput query="ScheduleEdit">
<input type="hidden" name="AuditType" Value="#AuditType#">
Audit Type - #AuditType#<br><br>
Third Party: #externallocation#
</CFOUTPUT>
<!--- audit details output Closed--->

<!--- Client Edit--->
<br>
<SELECT NAME="ExternalLocation">
<Option Value="NoChanges" selected>No Changes
<!--- TP Client List output Open--->
<CFOUTPUT QUERY="ExternalLocation">
		<OPTION VALUE="#ExternalLocation#">#ExternalLocation#
</CFOUTPUT>
<!--- TP Client List output closed--->
</SELECT>
<br>

<!--- Audit Details output Closed--->
<!--- end of TPTDP section--->
<cfelse>
<!--- Audit Details output Closed--->
<cfoutput query="ScheduleEdit">
<!--- Begin Internal Audit Section--->
<!--- Audit Types--->
Type of Audit: #audittype#<br>
Specific Audit Type: <cfif audittype2 is "">None Selected<cfelse>#audittype2#</cfif>
<br><br>
<input type="hidden" name="audittype2" value="#AuditType2#">
</cfoutput>
<!--- Audit Details Output Closed --->

<!--- Field Services--->
<cfif scheduleedit.audittype2 is "Field Services">
<!--- Audit Details Output Open --->
	<cfoutput query="ScheduleEdit">
	Field Service Location: #OfficeName#
	</CFOUTPUT>
<!--- Audit Details Output Closed --->
	<br>
	<SELECT NAME="OfficeName">
	<Option Value="NoChanges" selected>No Changes
<!--- FS Locations Output Open --->
	<CFOUTPUT QUERY="FUS">
			<OPTION VALUE="#Area#">#Area#
	</CFOUTPUT>
<!--- FS Locations Output Closed --->
	</SELECT>
	<br><br>
<!--- All internal besides FS --->
<cfelse>
<!--- Audit Details Output Open --->
	<cfoutput query="ScheduleEdit">
	UL Location: #OfficeName#
	</CFOUTPUT>
<!--- Audit Details Output Closed --->
	<cfif scheduleedit.audittype2 is "Corporate">
	<input type="hidden" name="OfficeName" Value="Corporate">
	<cfelseif scheduleedit.audittype2 is "Global Function/Process">
	<input type="hidden" name="OfficeName" Value="Global">
	<cfelseif scheduleedit.audittype2 is "Program" OR scheduleedit.audittype2 is "Scheme Documentation Audit">
	<input type="hidden" name="OfficeName" Value="#OfficeName#">
	<cfelse>
	<br>
	<SELECT NAME="OfficeName">
	<Option Value="NoChanges" selected>No Changes
<!--- Office Output Open --->
	<CFOUTPUT QUERY="OfficeName">
			<OPTION VALUE="#OfficeName#">#OfficeName#
	</CFOUTPUT>
<!--- Office Output Closed --->
	</SELECT>
	</cfif>
	<br><br>
</cfif>

<cfoutput>
	<cfif ScheduleEdit.AuditedBy is "IQA">
		<B>Business Unit(s) Audited</B><br>
		(Select at least one - hold control to select more than one)<br /><br>

		Current: #ScheduleEdit.BusinessUnit#<br>
		<SELECT NAME="BusinessUnit" multiple="multiple" size="7" displayname="Business Unit">
			<OPTION VALUE="#ScheduleEdit.BusinessUnit#" selected="selected">No Changes</OPTION>
			<OPTION VALUE="Commercial and Industrial">Commercial and Industrial</OPTION>
			<OPTION VALUE="Consumer">Consumer</OPTION>
			<OPTION VALUE="Ventures/UL Software">Ventures/UL Software</OPTION>
		</SELECT><br /><br />
	</cfif>
</cfoutput>

<!--- Audit Details Output Open --->
<!--- Audit Area --->
<cfoutput query="ScheduleEdit">
	Area(s) to be Audited: (this will be listed on the audit schedule)<br>
<cfif audittype2 is "Local Function CBTL">
	#AuditArea#
	<INPUT TYPE="Hidden" NAME="AuditArea" size="75" VALUE="#AuditArea#">
<cfelseif audittype2 is "Scheme Documentation Audit">
	Scheme Documentation Audit
	<INPUT TYPE="Hidden" NAME="AuditArea" size="75" VALUE="#AuditArea#">
<cfelse>
	<INPUT TYPE="Text" NAME="AuditArea" size="75" VALUE="#AuditArea#">
</cfif>
</cfoutput>
<br><br>

<!--- Primary Contact --->
<cfoutput query="ScheduleEdit">
Primary Contact ('To' field of Scope Letter: external email addresses, ONE only)<br>
- Audit notification will be sent to this address<br>
<INPUT TYPE="Text" NAME="Email" size="125" VALUE="#Email#"><br>
:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br>

Other Contacts ('CC' field of Scope Letter: external email addresses)<br>
- Audit notification will be sent to this person or persons (commas between the addresses)<br>
<INPUT TYPE="Text" NAME="Email2" size="125" VALUE="#Email2#"><br>
:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br>
</cfoutput>
<!--- Audit Details Output Closed --->

<CFIF URL.Year LTE 2012>
	<!--- Key Processes and Reference Docs --->
    Key Processes:
    <br>
    <SELECT NAME="KP" multiple="multiple">
        <Option Value="NoChanges" selected>No Changes
        <OPTION VALUE="- None -">- None -
    <!--- KP Output Open --->
    <CFOUTPUT QUERY="KP">
            <OPTION VALUE=" #KP#">#KP#
    </CFOUTPUT>
    <!--- KP Output Closed --->
    </SELECT>
    <br><br>
</cfif>

Reference Documents:<br>
<cfoutput query="ScheduleEdit">#RD#</cfoutput><br /><br />
</cfif>

<!--- all audits - notes and scope --->
<cfoutput query="ScheduleEdit">
<!---
Scope:<br>
<!---<cfset S1 = #ReplaceNoCase(Scope, "<br>", chr(13), "ALL")#>--->
<textarea WRAP="PHYSICAL" ROWS="17" COLS="90" NAME="Scope" Value="#HTMLEditFormat(Scope)#">#HTMLEditFormat(Scope)#</textarea><br><br>
--->

Notes:<br>
<!---<cfset N1 = #ReplaceNoCase(Notes, "<br>", chr(13), "ALL")#>--->
<textarea WRAP="PHYSICAL" ROWS="4" COLS="90" NAME="Notes" Value="#HTMLEditFormat(Notes)#">#HTMLEditFormat(Notes)#</textarea><br><br>
</cfoutput>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->