<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Approve Audit Assignment">
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

<Cfoutput query="Audit">
<b>Audit Due Date</b><br>
#dateformat(AuditDueDate, "mm/dd/yyyy")#<br><br>

<b>Auditor</b><br>
#Auditor#<Br><br>

<b>Project Number</b><br />
#ProjectNumber#<br /><br />

<b>File Number</b><br />
#FileNumber#<br /><br />

<FORM ACTION="TechnicalAudits_Email_AuditorAssignment_Review.cfm?#CGI.Query_String#" METHOD="POST" NAME="SaveTable">
    <input type="submit" align="absmiddle" border="0" value="Accept Assignment" />
</form><br>

If you wish to edit any of this information, please go to the <a href="TechnicalAudits_AuditDetails.cfm?#CGI.QUERY_STRING#">Audit Details</a> page for this audit and edit the fields above.<br /><br />
</Cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->