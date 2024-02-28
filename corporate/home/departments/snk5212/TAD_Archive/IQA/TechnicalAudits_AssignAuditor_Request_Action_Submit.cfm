<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ID" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID) + 1 AS newid FROM Auditors
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="AddID" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO Auditors(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Add" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE Auditors
SET 
Type='TechnicalAudit',
Auditor='#Form.Auditor#',
Location='#Form.Location#',
Email='#Form.Email#',
EmpNo='#Form.EmpNo#',
Dept='#Form.Department#',
<cflock scope="SESSION" timeout="6">
History='Auditor Requested #curdate#<br>Auditor=#Form.Auditor#<br>Email=#Form.Email#<cfif isDefined('SESSION.Auth')><br>Added by: #SESSION.Auth.Name#/#Session.Auth.UserName#</cfif>'
</cflock>

WHERE ID=#ID.newid#
</CFQUERY>

<!--- assign auditor to audit --->
<CFQUERY Name="Auditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, Location, Dept, Email
From Auditors
WHERE EmpNo = '#Form.EmpNo#'
</CFQUERY>

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History, AuditType2
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfoutput query="Auditor">
    <!--- insert auditor into audit schedule table --->
    <CFQUERY NAME="AddAuditor" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    Auditor = '#Auditor#',
    AuditorOfficeName = '#Location#',
    AuditorDept = '#Dept#',
    AuditorEmail = '#Email#',
    AuditorRequested = 'Yes',
    AuditorRequestedDate = #createODBCDate(curdate)#,        
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br>
    	Auditor Requested<br />
        Auditor: #Auditor# / #Location# / #Dept#<Br />
        Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
        Date: #curdate# #curTime#" CFSQLTYPE="CF_SQL_CLOB"> 
        
    WHERE 
    ID = #URL.ID# 
    AND Year_ = #URL.Year#
    </cfquery>
</cfoutput>

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

<cfmail
	to="#ReplyTo#"
    from="#Request.TechnicalAuditMailbox#"
    cc="#ReplyTo#"
    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Auditor Requested"
    query="Auditor">
    A new Auditor has been requested for this audit<br /><br />
    
    Audit Number: #URL.Year#-#URL.ID#<Br />
</cfmail>

<cflocation url="#IQADir#TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">