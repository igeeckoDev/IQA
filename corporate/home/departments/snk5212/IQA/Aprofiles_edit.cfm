<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor Profile - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
	SELECT OfficeName FROM IQAtbloffices
	ORDER BY OfficeName
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="AuditType" Datasource="Corporate">
	SELECT AuditType
    FROM AuditType
	ORDER BY AuditType
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Status" Datasource="Corporate">
	SELECT Status
    FROM AuditorStatus
    WHERE Status = 'Active'
    OR Status = 'Inactive'
    OR Status = 'In Training'
	ORDER BY Status
</cfquery>

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

<CFQUERY BLOCKFACTOR="100" name="AuditorProfile" Datasource="Corporate">
SELECT * FROM AuditorList
WHERE ID=#URL.ID#
</CFQUERY>

<br>
<cfFORM id="f1" METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Aprofiles_update.cfm?ID=#ID#">
<cfoutput query="AuditorProfile">
<b>#Auditor#</b><br><br>
</cfoutput>

<!---
Email:<br>
<INPUT TYPE="TEXT" NAME="e_Email" size="75" VALUE="#Email#"><br><br>

Phone:<br>
<INPUT TYPE="TEXT" NAME="e_Phone" VALUE="#Phone#"><br><br>
Manager Name:<br>
<INPUT TYPE="TEXT" NAME="e_Manager" VALUE="#Manager#"><br><br>

<u>Status</u>: (Current: #status#)<br><br>

<SELECT NAME="e_Status">
		<option value="#status#" selected>#status#</option>
        <option>---</option>
</CFOUTPUT>
<CFOUTPUT QUERY="Status">
		<OPTION VALUE="#Status#">#Status#</option>
</CFOUTPUT>
</SELECT>

<u>Type of Audits Qualified to Conduct</u>:<br />
<cfoutput query="auditorprofile">
#replace(qualified, ",", "<br />", "All")#<br>
</cfoutput><br />

 * <u>Quality System</u> - includes Local Function, Global Function/Process, and Program Audits.<br />
 ** Program Audits may have additional auditor requirements/training<br /><br />

<CFIF SESSION.Auth.AccessLevel is NOT "Field Services">
    <cflock scope="SESSION" timeout="10">
		<SELECT NAME="e_AuditType" multiple="multiple" size="9">
            <Option Value="NoChanges" selected>No Changes</Option>
			<CFOUTPUT QUERY="AuditType">
	            <OPTION VALUE="#AuditType#">#AuditType#</Option>
            </CFOUTPUT>
    	</SELECT>
        <br /><br />
        * <u>Quality System</u> - includes Local Function, Global Function/Process, and Program Audits.<br />
        ** Program Audits may have additional auditor requirements/training<br /><br />
    </cflock>
<cfelse>
	<cfoutput query="auditorprofile">
    #qualified#
    </cfoutput><br /><br />
</cfif>

<cfoutput query="AuditorProfile">
<INPUT TYPE="hidden" NAME="qualified" VALUE="#qualified#">

<cflock scope="SESSION" timeout="10">
	<CFIF SESSION.Auth.AccessLevel is NOT "Field Services">
		<CFIF SESSION.Auth.AccessLevel is "SU" or SESSION.Auth.AccessLevel is "Admin"
		OR SESSION.Auth.Accesslevel is "RQM" AND SESSION.Auth.Region is "#Region#">

			<u>Lead Auditor?</u> (Current: <Cfif Lead eq 1>Yes<cfelse>No</CFIF>)<br>
            <cfset selValue = #Lead#>
            Yes
            <cfinput type="Radio" Name="Lead" Value="Yes" checked="#iif(selvalue eq "Yes", de("true"), de("false"))#">
            No
            <cfINPUT TYPE="Radio" NAME="Lead" value="No" checked="#iif(selvalue eq "No", de("true"), de("false"))#">
            <br><br>

            <u>Corporate IQA Auditor?</u><br>
            <cfif IQA eq "Yes">
            Yes <input type="Radio" Name="Corporate" Value="Yes" checked> No <INPUT TYPE="Radio" NAME="Corporate" value="No">
            <cfelse>
            Yes <input type="Radio" Name="Corporate" Value="Yes"> No <INPUT TYPE="Radio" NAME="Corporate" value="No" checked>
            </cfif>
            <br /><br />
            Note: If yes, the auditor's location will show as "Corporate / Internal Quality Audits".
            <br /><br />
        <cfelse>
        <u>Lead Auditor:</u> <Cfif Lead eq 1>Yes<cfelse>No</CFIF>
        <input type="hidden" name="Lead" value="#Lead#"><br><br>
        </cfif>
	</CFIF>
</cflock>

    <cflock scope="SESSION" timeout="10">
        <CFIF SESSION.Auth.AccessLevel is NOT "Field Services">
        <u>Location</u>: #location#<br>
        </cfif>
    </cflock>
</cfoutput>

<cflock scope="SESSION" timeout="10">
	<CFIF SESSION.Auth.AccessLevel is NOT "Field Services">
	    <SELECT NAME="e_OfficeName">
            <Option Value="NoChanges" selected>No Change</Option>
            <Option>---</Option>
    		<CFOUTPUT QUERY="OfficeName">
            	<OPTION VALUE="#OfficeName#">#OfficeName#</Option>
    		</CFOUTPUT>
    	</SELECT>
    <cfoutput query="AuditorProfile">
    	<INPUT TYPE="hidden" NAME="location" VALUE="#location#">
    </cfoutput>
    <br /><br />
    </cfif>
</cflock>
--->

<cfoutput query="AuditorProfile">

<u>Expertise</u>:<br>
<textarea WRAP="PHYSICAL" ROWS="18" COLS="80" NAME="Expertise">
<cfset Dump = #ReplaceNoCase(Expertise, "<br>", chr(13), "ALL")#>
#Dump#
</textarea><br><br>

<u>Training</u>:<br>
<textarea WRAP="PHYSICAL" ROWS="18" COLS="80" NAME="Training">
<cfset Dump = #ReplaceNoCase(Training, "<br>", chr(13), "ALL")#>
#Dump#
</textarea><br><br>

<u>Comments</u>:<br>
<textarea WRAP="PHYSICAL" ROWS="18" COLS="80" NAME="Comments">
<cfset Dump = #ReplaceNoCase(Comments, "<br>", chr(13), "ALL")#>
#Dump#
</textarea><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</cfoutput>
</cfFORM>
<br /><br />

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->