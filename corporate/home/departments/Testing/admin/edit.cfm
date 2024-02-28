<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Edit Audit - #URL.Year#-#URL.ID#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<cfoutput>
<script language="JavaScript" src="#IQADir#webhelp/webhelp.js"></script>
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

<!---
<CFQUERY BLOCKFACTOR="100" NAME="ExternalLocation" Datasource="Corporate">
	SELECT ExternalLocation FROM ExternalLocation
	ORDER BY ExternalLocation
</cfquery>
--->

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
SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year
FROM AuditSchedule
WHERE ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

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
		
		<cfif ScheduleEdit.auditedby eq "IQA">
			AND IQA = 'Yes'
		</cfif>
			
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

<cfif scheduleedit.AuditType2 is "Field Services">
    <CFQUERY BLOCKFACTOR="100" NAME="FUS" Datasource="Corporate">
       SELECT * FROM FUSAreas
       ORDER BY Area
    </cfquery>
</cfif>

<div class="blog-time">
Schedule/Edit an Audit Help - <A HREF="javascript:popUp('#IQARootDir#webhelp/webhelp_scheduleaudit.cfm')">[?]</A></div><br />

<cfoutput query="ScheduleEdit">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="edit2.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">
<INPUT TYPE="Hidden" NAME="ID" VALUE="#ID#">
<INPUT TYPE="Hidden" NAME="Year" VALUE="#Year#">
<INPUT TYPE="Hidden" NAME="e_Month" VALUE="#Month#">
<input type="hidden" name="AuditedBy" value="#AuditedBy#">

<cfif ScheduleEdit.AuditType is "TPTDP">
<input type="hidden" name="AuditType2" value="N/A">
<cfelse>
<input type="hidden" name="AuditType2" value="#AuditType2#">
</cfif>

<b>Month Scheduled</b>: #MonthAsString(Month)#<br>
<b>Start Date</b>: <cfif len(StartDate)>#DateFormat(StartDate, 'mm/dd/yyyy')#<cfelse>None Listed</cfif>
<cfif audittype2 is NOT "Global Function/Process">
	<br><b>End Date</b>: <cfif len(EndDate)>#DateFormat(EndDate, 'mm/dd/yyyy')#<cfelse>None listed</cfif>
<cfelse>
	<br><b>End Date</b>: Not recorded for a Global Desk Audit, the Audit Report date will be used as the End Date.
</cfif>
<br><br>

<input type="hidden" name="StartDate" value="#StartDate#">
<input type="hidden" name="EndDate" value="#EndDate#">
</cfoutput>

<cflock scope="SESSION" timeout="60">
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
<b>Lead Auditor</b>: #leadauditor#<br />
</cfoutput>

<SELECT NAME="LeadAuditor">
	<Option Value="NoChanges" selected>No Changes
		<OPTION value="- None -">- None -
		<CFOUTPUT QUERY="Auditor">
        	<cfif Status is "Active" AND Lead is "Yes">
            	<OPTION VALUE="#Auditor#" <!---<cfif Auditor is SESSION.Auth.Name>selected</cfif>--->>#Auditor#
			</cfif>
		</CFOUTPUT>
</SELECT>
<!---</cfif>--->
</cflock>
<br><br>

<cfoutput query="ScheduleEdit">
<b>Auditor(s)</b>:<br />
#replace(auditor, ",", "<br />", "All")#<br>
</cfoutput>
<SELECT NAME="Auditor" multiple="multiple">
	<Option Value="NoChanges" selected>No Changes
	<OPTION VALUE="- None -">- None -
		<CFOUTPUT QUERY="Auditor">
			<cfif status is "Active">
				<OPTION VALUE="#Auditor#">#Auditor#
			</cfif>
		</CFOUTPUT>
</SELECT><br><br>

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

<!--- SME and auditDays--->
<cfif URL.AuditedBy eq "IQA" AND URL.Year GTE 2015>
Audit Days - Number of On-Site Days: (required)<br>
<cfoutput query="ScheduleEdit">
	<u>Current</u>:
	<cfif isdefined("AuditDays") AND len(AuditDays)>
		#AuditDays#
	<cfelse>
		None Listed
	</cfif><br><br>
</cfoutput>

<cfif SESSION.Auth.Username eq "Chris"
	OR SESSION.Auth.Username eq "Huang"
	OR SESSION.Auth.Username eq "Echols">
	<SELECT NAME="AuditDays" displayname="Audit Days">
		<Option Value="NoChanges" selected>No Changes
		<option value="">Select Audit Days
		<option value="">---
		<cfloop index="i" to="10" from="1">
			<Cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
		</cfloop>
	</SELECT><br><br>
<cfelse>
	<cfoutput query="ScheduleEdit">
		<input type="hidden" name="AuditDays" Value="#AuditDays#">
	</cfoutput>
</cfif>

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

<cfif ScheduleEdit.audittype2 NEQ "Field Services">
<cfoutput query="ScheduleEdit">
<!---desk audit--->
<b>Is this a Desk Audit?</b> <u>Currently</u>: <cfif Desk eq 0>No<cfelseif Desk eq 1>Yes</cfif><br />
<cfswitch expression="#Desk#">
	<cfcase value="Yes">
	Yes <INPUT TYPE="Radio" name="Desk" value="Yes" checked> No <INPUT TYPE="Radio" name="Desk" value="No">
	</cfcase>
	<cfcase value="No">
	Yes <INPUT TYPE="Radio" name="Desk" value="Yes"> No <INPUT TYPE="Radio" name="Desk" value="No" checked>
	</cfcase>
</cfswitch><br><br>
</CFOUTPUT>
</cfif>

<!---<cfif ScheduleEdit.AuditType is "TPTDP">
Audit Type - TPTDP
<INPUT TYPE="Hidden" NAME="AuditType" VALUE="TPTDP"><br><br>

<cfoutput query="ScheduleEdit">
Third Party - #externallocation#<br><br>
</CFOUTPUT>

<cfelse>--->

<cfoutput query="ScheduleEdit">
<INPUT TYPE="Hidden" NAME="AuditType" VALUE="#audittype#">
<INPUT TYPE="Hidden" NAME="AuditType" VALUE="#audittype2#">
<b>Type of Audit</b>: #audittype#<br>
<b>Specific Audit Type</b>: #audittype2#<br><br>
</cfoutput>

<cfif ScheduleEdit.AuditType2 is "Field Services">
	<cfoutput query="ScheduleEdit">

		<b>Area(s) to be Audited</b>: (this will be listed on the audit schedule)<br>
        <INPUT TYPE="Text" NAME="AuditArea" size="125" VALUE="#AuditArea#"><br /><br />


    	<!---
        <b>Field Service Region</b>: #OfficeName#<br><br>
        <input type="Hidden" name="e_OfficeName" value="#OfficeName#">
        --->

        <b>Field Service Location</b>:<br>
        <SELECT NAME="OfficeName">
            <OPTION VALUE="#OfficeName#">#OfficeName#
            <OPTION VALUE="">----
    </cfoutput>
    <CFOUTPUT QUERY="FUS">
            <OPTION VALUE="#Area#">#Area#
    </CFOUTPUT>
    </SELECT>

<cfelse>
	<cfoutput>
        <b>UL Location</b>: #ScheduleEdit.OfficeName#
        <cfif ScheduleEdit.AuditType2 is "Program">
            <SELECT NAME="OfficeName">
                <OPTION VALUE="#ScheduleEdit.OfficeName#" selected="selected">#ScheduleEdit.OfficeName#
                <OPTION>--</OPTION>
                <CFLoop QUERY="OfficeName">
                    <cfif OfficeName NEQ "test location">
                        <OPTION VALUE="#OfficeName#">#OfficeName#
                    <cfelse>
                        <cfif SESSION.Auth.AccessLevel is "SU">
                            <OPTION VALUE="#OfficeName#">#OfficeName# <cfif CB eq "Yes">(Certification Body)</cfif>
                        </cfif>
                    </cfif>
                </CFloop>
            </SELECT>
        <cfelse>
            <input type="Hidden" name="OfficeName" value="#ScheduleEdit.OfficeName#">
        </cfif>
        <br><br>

        <cfif ScheduleEdit.AuditedBy is "IQA">
                <B>Business Unit(s) Audited</B><br>
				(Select at least one - hold control to select more than one)<br /><br>

				Current: #ScheduleEdit.BusinessUnit#<br>
				<SELECT NAME="BusinessUnit" multiple="multiple" size="7" displayname="Business Unit">
                    <OPTION VALUE="#ScheduleEdit.BusinessUnit#" selected="selected">No Changes</OPTION>
                    <OPTION VALUE="Retail and Industry">Retail and Industry</OPTION>

					<OPTION VALUE="Connected Technology">Connected Technology</OPTION>
<OPTION VALUE="Corporate/Field Services">Corporate/Field Services</OPTION>

                </SELECT><br /><br />
        </cfif>

        <b>Area to be Audited</b>: (this will be listed on the audit schedule)<br>
		#ScheduleEdit.AuditArea#
		<cfif SESSION.Auth.Username eq "Chris"
			OR SESSION.Auth.Username eq "Huang"
			OR SESSION.Auth.Username eq "Echols">

	        <cfif ScheduleEdit.audittype2 is "Local Function CBTL">
	            <INPUT TYPE="Hidden" NAME="AuditArea" size="75" VALUE="#ScheduleEdit.AuditArea#">
	        <cfelseif ScheduleEdit.audittype2 is "Scheme Documentation Audit">
				Scheme Documentation Audit
				<INPUT TYPE="Hidden" NAME="AuditArea" size="75" VALUE="#ScheduleEdit.AuditArea#">
			<cfelse>
	            <INPUT TYPE="Text" NAME="AuditArea" size="75" VALUE="#ScheduleEdit.AuditArea#">
	        </cfif>
		</cfif>
    </cfoutput>
</cfif><br><br>

<!--- Primary Contact --->
<cfoutput query="ScheduleEdit">
<b>Primary Contact</b> ('To' field of Scope Letter: external email addresses, ONE only)<br>
- Audit notification will be sent to this address<br>
<INPUT TYPE="Text" NAME="Email" size="125" VALUE="#Email#"><br>
:: <a href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_Blank">Look Up Email</a> - Use UL External Email addresses Only<br><br>
<!---
:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br>
--->

<b>Other Contacts</b> ('CC' field of Scope Letter: external email addresses)<br>
- Audit notification will be sent to this person or persons (commas between the addresses)<br>
<INPUT TYPE="Text" NAME="Email2" size="125" VALUE="#Email2#"><br>
:: <a href="http://intranet.ul.com/ULSearch/Pages/people.aspx" target="_Blank">Look Up Email</a> - Use UL External Email addresses Only<br><br>
<!---
:: <a href="javascript:popUp('EmailLookup.cfm')">Lookup</a> Email Addresses<br /><br>
--->
</cfoutput>

<cfif URL.Year LTE 2012>
    <b>Key Processes</b>:<br />
    <cfoutput query="ScheduleEdit">#KP#</cfoutput><br>
    <SELECT NAME="KP" multiple="multiple">
        <Option Value="NoChanges" selected>No Changes
        <OPTION VALUE="- None -">- None -
    <CFOUTPUT QUERY="KP">
            <OPTION VALUE=" #KP#">#KP#
    </CFOUTPUT>
    </SELECT>
    <br><br>
</cfif>

<b>Reference Documents</b>:<br />
<cfoutput query="ScheduleEdit">#RD#</cfoutput><br>
<!---</cfif>--->
<br>

<cfoutput query="ScheduleEdit">
<!---
<b>Scope</b>:<br>
<textarea WRAP="PHYSICAL" ROWS="17" COLS="90" NAME="Scope" displayname="Scope" value="">#Scope#</textarea><br><br>
--->

<b>Notes</b>:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="90" NAME="Notes" displayname="Notes" value="">#Notes#</textarea><br><br>
</cfoutput>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->