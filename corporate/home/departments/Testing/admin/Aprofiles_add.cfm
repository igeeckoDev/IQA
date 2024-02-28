<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor Profiles - Add">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

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
</cfoutput>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cflock scope="SESSION" timeout="10">
	<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin" OR SESSION.Auth.Username is "Jessen" OR SESSION.Auth.Region is "Medical" OR SESSION.Auth.Region is "UL Environment">
    <CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
        SELECT OfficeName
        FROM IQAtbloffices
        WHERE OfficeName <> '- None -'
        ORDER BY OfficeName
    </cfquery>
    <cfelseif SESSION.Auth.AccessLevel is "RQM" OR SESSION.Auth.AccessLevel is "OQM" OR SESSION.Auth.Username is "Jessen">
    <CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
        SELECT OfficeName
        FROM IQAtbloffices
        WHERE Region = '#SESSION.AUTH.Region#'
        ORDER BY OfficeName
    </cfquery>
    </cfif>
</cflock>

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

<div class="blog-time">Add an Auditor Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditorlist.cfm')">[?]</A></div><br>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Aprofiles_addnew.cfm">

<u>Auditor Name</u>:<br>
<INPUT TYPE="TEXT" NAME="e_Auditor" size="75" VALUE="" displayname="Auditor Name"><br><br>

Email:<br>
<INPUT TYPE="TEXT" NAME="e_Email" size="75" VALUE="" displayname="Auditor's External UL Email Address"><br><br>

<!---
Phone:<br>
<INPUT TYPE="TEXT" NAME="e_Phone" VALUE="" displayname="Phone Number"><br><br>
Manager Name:<br>
<INPUT TYPE="TEXT" NAME="e_Manager" VALUE="" displayname="Manager"><br><br>
--->

<u>Status</u>:<br>
<SELECT NAME="e_Status" displayname="Auditor Status">
		<OPTION VALUE="">Select Below
		<OPTION VALUE="">----
<CFOUTPUT QUERY="Status">
		<OPTION VALUE="#Status#">#Status#
</CFOUTPUT>
</SELECT>
<br><br>

<cflock scope="SESSION" timeout="10">
	<CFIF SESSION.Auth.AccessLevel is NOT "Field Services">
    	<u>Type of Audits Qualified to Conduct</u>: (Hold Control to choose more than one)<br><br>
    	<SELECT NAME="e_AuditType" multiple="multiple" size="10" displayname="Qualified Types of Audits">
            <OPTION VALUE="">Select Audit Types Below
            <OPTION VALUE="">----
    		<CFOUTPUT QUERY="AuditType">
            	<OPTION VALUE="#AuditType#">#AuditType#
    		</CFOUTPUT>
    	</SELECT>
    <br /><br />
    * <u>Quality System</u> - includes Local Function, Global Function/Process, and Program Audits.<br />
    ** Program Audits may have additional auditor requirements/training<br /><br />
    <cfelse>
        <u>Type of Audits Qualified to Conduct</u>: Field Services
        <br><br>
    </cfif>
</cflock>

<!--- lead auditor status - yes/no 4/1/2008 --->
<u>Lead Auditor?</u><br>
Yes <input type="Radio" Name="Lead" Value="1"> No <INPUT TYPE="Radio" NAME="Lead" value="0" checked><br><br>

<cflock scope="SESSION" timeout="10">
	<CFIF SESSION.Auth.AccessLevel is "SU" or SESSION.Auth.AccessLevel is "Admin" OR SESSION.Auth.Username is "Jessen">
		<u>IQA Auditor?</u><br>
		Yes <input type="Radio" Name="Corporate" Value="Yes"> No <INPUT TYPE="Radio" NAME="Corporate" value="No" checked><br><br>
	<cfelse>
		<INPUT TYPE="hidden" NAME="Corporate" value="No">
	</cfif>

	<CFIF SESSION.Auth.AccessLevel is NOT "Field Services">
		<u>Location:</u><br>
		<SELECT NAME="e_OfficeName" displayname="Auditor's Location">
			<OPTION VALUE="">Select Below
			<OPTION VALUE="">----
		<CFOUTPUT QUERY="OfficeName">
			<OPTION VALUE="#OfficeName#">#OfficeName#
		</CFOUTPUT>
		</SELECT><br><br>
	</cfif>
</cflock>

<u>Expertise</u>:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Expertise" Value=""></textarea><br><br>

<u>Training</u>:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Training" Value=""></textarea><br><br>

<u>Comments</u>:<br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="70" NAME="Comments" Value=""></textarea><br><br>

<u>Confirm Auditor Last Name</u>:<br>
<INPUT TYPE="TEXT" NAME="e_LastName" VALUE="" displayname="Last Name"><br><br>

<br><br>
<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->