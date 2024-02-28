<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset subTitle = "Quality Engineering Related Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- / --->

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#CARDir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<CFQUERY DataSource="Corporate" Name="GF">
SELECT Function FROM GlobalFunctions
WHERE Status IS NULL
ORDER BY Function
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="IQAProgs">
SELECT Program FROM ProgDev
WHERE IQA = 1
ORDER BY Program
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="AuditTypes">
SELECT * FROM AuditType
ORDER BY AuditType
</CFQUERY>

<cfif isDefined("Form.GF") OR isDefined("FORM.AuditTypes") OR isDefined("FORM.IQAProgs")>

<cfif Form.GF NEQ "None">
	<cfset var1 = #Form.GF#>
<cfelseif Form.AuditTypes NEQ "None">
	<cfset var1 = #Form.AuditTypes#>
<cfelseif Form.IQAProgs NEQ "None">
	<cfset var1 = #Form.IQAProgs#>
</cfif>
    
<CFQUERY DataSource="Corporate" Name="AddCategory"> 
UPDATE CARFiles
SET

PlanType = '#var1#', 
PlanNotes = '#Form.PlanNotes#'

WHERE DocNumber = #URL.DocNumber# AND
RevNo = #URL.Rev#
</CFQUERY>

	<cflocation url="CARFiles.cfm?uploaded=Yes&DocNumber=#URL.DocNumber#&Rev=1" addtoken="No">

<!--- end of upload section--->
<cfelse>
<!--- FORM --->

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">

Please select the type of Audit Program from one of the following drop down lists below.<br><br>

Global Functions:<br />
    <cfselect 
        name="GF" 
        multiple="No" 
        query="GF" 
        required="Yes"
        message="Global Function is Required, select None if not applicable"
        display="Function" 
        value="Function" 
        class="blog-content_dropdown"
        queryPosition="below">
        <option value="None" selected>None
    </cfselect><br><br>

IQA Programs:<br />
    <cfselect 
        name="IQAProgs" 
        multiple="No" 
        query="IQAProgs" 
        required="Yes"
        message="Program Name is Required, select None if not applicable"
        display="Program" 
        value="Program" 
        class="blog-content_dropdown"
        queryPosition="below">
        <option value="None" selected>None
    </cfselect><br><br>

Type of Audit:<br />
    <cfselect 
        name="AuditTypes" 
        multiple="No" 
        query="AuditTypes" 
        required="Yes"
        message="Audit Type is Required, select None if not applicable"
        display="AuditType" 
        value="AuditType" 
        class="blog-content_dropdown"
        queryPosition="below">
        <option value="None" selected>None
    </cfselect><br><br>

Notes</font><br>
<textarea wrap="physical" name="PlanNotes" rows="8" cols="60">Please provide any notes to describe the Audit Plan document, if necessary. </textarea>
<br><br>

<INPUT TYPE="Submit" value="Save Audit Plan Type" Name="Submit">

</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->