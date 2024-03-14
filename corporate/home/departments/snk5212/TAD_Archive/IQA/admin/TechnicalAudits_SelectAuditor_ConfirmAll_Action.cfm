<!--- update row --->
<CFQUERY Name="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

AuditorAssigned = 'Yes',
Flag_CurrentStep = 'Auditor Selected'

WHERE ID = #URL.ID#
AND Year_ = '#URL.Year#'
</CFQUERY>

<!--- Check Audit Type --->
<CFQUERY Datasource="UL06046" NAME="Audit" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<!--- set replyTo address --->
<cfif len(Audit.TAM)>
	<cfset ReplyTo = "#Audit.TAM#">
    <cfset AssignTaskTo = ReplyTo>
<cfelse>
	<cfset ReplyTo = "#Request.TechnicalAuditMailbox#">
    <cfset AssignTaskTo = "Technical Audit Manager">
</cfif>

<cfif Audit.AuditType2 eq "Full">
<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

	<!--- mail to TAM --->
    <cfmail
        to="#ReplyTo#"
        from="#Request.TechnicalAuditMailbox#"
        replyto="#ReplyTo#"
        subject="Internal Technical Audit of Project #ProjectNumber# (#Audit.AuditType2#) - Auditor Assigned"
        type="html"
        query="Audit">
        Audit: #varAuditIdentifier#<br /><br />

		This is notification that an auditor has been assigned for this audit: <br />
        Click here to open the audit: <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

		Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

        Task required: Please set the Audit Due Date and send the Auditor Assignment Email<br /><br />

		You can also log in to the Technical Audit Database to view this audit.<br /><Br />
    </cfmail>
</cfif>

<cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">