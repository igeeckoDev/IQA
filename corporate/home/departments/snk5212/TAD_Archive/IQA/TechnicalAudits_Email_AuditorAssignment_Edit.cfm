<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Approve Audit Assignment - Edit Email Text">
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

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cfquery Datasource="UL06046" name="getROM" username="#OracleDB_Username#" password="#OracleDB_Password#"> 
SELECT 
	Corporate.IQARegion.TechnicalAudits_ROM as ROM
FROM 
	Corporate.IQARegion, Corporate.IQASubRegion, Corporate.IQAtblOffices, UL06046.TechnicalAudits_AuditSchedule
WHERE 
	Corporate.IQARegion.Region = Corporate.IQASubRegion.Region
	AND Corporate.IQASubRegion.SubRegion = Corporate.IQAtblOffices.SubRegion
	AND Corporate.IQAtblOffices.OfficeName = UL06046.TechnicalAudits_AuditSchedule.OfficeName
    AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = '#Audit.OfficeName#'
</CFQUERY>

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<Cfoutput query="Audit">
<b>Audit Due Date</b><br>
#dateformat(AuditDueDate, "mm/dd/yyyy")#<br><br>

<b>Auditor</b><br>
#Auditor#<Br><br>

<b>To</b>: #AuditorEmail#<br />
<b>From</b>: Technical Audit Manager<br />
<b>CC</b>: #AuditorManagerEmail#, #ROM#, #Request.TechnicalAuditManager#<br />
<b>Subject</b>: Internal Technical Audit (#AuditType2#) - Audit Assignment<br /><br />

<cfsavecontent variable="EmailText">
	<cfinclude template="#IQADir#TechnicalAudits_EmailText_AuditorAssignment.cfm">
</cfsavecontent>

<form METHOD="POST" action="TechnicalAudits_Email_AuditorAssignment_Send.cfm?#CGI.Query_String#" enctype="multipart/form-data">

<textarea name="EmailText" rows="30" cols="65">#EmailText#</textarea><br><br>

<input name="submit" type="submit" value="submit"> 
</form>

</Cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->