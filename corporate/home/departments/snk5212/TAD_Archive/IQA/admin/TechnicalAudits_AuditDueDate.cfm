<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Set Audit Due Date">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<div align="Left" class="blog-time">
<br />
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.5 Set audit due date and send assignment to the auditor<br /><br />
</cfoutput>
</div>

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<cfif isDefined("URL.msg")>
	<cfoutput>
        <font class="warning"><u>Validation Error</u>: #URL.Msg#</font><br /><br />
    </cfoutput>
</cfif>

<!--- build form --->
<cfform action="TechnicalAudits_AuditDueDate_Action.cfm?#CGI.Query_String#">

Set Audit Due Date:<br />
<div style="position:relative; z-index:3">
<cfinput type="datefield" name="DueDate" required="yes" value="#dateformat(Audit.AuditDueDate, 'mm/dd/yyyy')#" message="Please include the due date" validate="date">
</div>

<br /><br /><Br>

<cfinput type="Submit" name="Submit" value="Save Audit Due Date">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->