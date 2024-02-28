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
	Corporate.IQARegion.TechnicalAudits_ROM as ROM, Corporate.IQAtblOffices.TechnicalAudits_SQM as SQM
FROM 
	Corporate.IQARegion, Corporate.IQASubRegion, Corporate.IQAtblOffices, UL06046.TechnicalAudits_AuditSchedule
WHERE 
	Corporate.IQARegion.Region = Corporate.IQASubRegion.Region
	AND Corporate.IQASubRegion.SubRegion = Corporate.IQAtblOffices.SubRegion
	AND Corporate.IQAtblOffices.OfficeName = UL06046.TechnicalAudits_AuditSchedule.OfficeName
    AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = '#Audit.OfficeName#'
</CFQUERY>

<!--- set replyTo address --->
<cfif len(Audit.TAM)>
	<cfset ReplyTo = "#Audit.TAM#">
    <cfset AssignTaskTo = ReplyTo>
<cfelse>
	<cfset ReplyTo = "#Request.TechnicalAuditMailbox#">
    <cfset AssignTaskTo = "Technical Audit Manager">
</cfif>

<cfmail 
	to="#AuditorEmail#"
    cc="#AuditorManagerEmail#, #ReplyTo#, #Audit.ROM#"
    from="#Request.TechnicalAuditMailbox#"
    replyto="#ReplyTo#"
    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Audit Assignment"
    query="Audit"
    type="HTML">
    
    <cfif isDefined("Form.EmailText")>
        <cfoutput>
    		#Form.EmailText#
    	</cfoutput>
    <cfelse>
		<cfinclude template="#IQADir#TechnicalAudits_EmailText_AuditorAssignment.cfm">
    </cfif>
</cfmail>

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT AuditDueDate, History 
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfset HistoryUpdate = "Audit Assignment Letter Sent to Auditor: #dateformat(curdate, "mm/dd/yyyy")#<br />
    Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
    Date: #curdate# #curTime#">

<CFQUERY BLOCKFACTOR="100" NAME="HistoryUpdate" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE 
	TechnicalAudits_AuditSchedule
SET
	AuditorAssignmentLetterDate = #CreateODBCDate(curdate)#,
    Flag_CurrentStep = 'Audit Assignment Sent to Auditor',
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">
    
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cflocation url="TechnicalAudits_AuditDetails.cfm?#CGI.Query_String#" addtoken="no">