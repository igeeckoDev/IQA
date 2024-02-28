<cfif form.DueDate gt curDate>

    <CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT AuditDueDate, History 
    FROM TechnicalAudits_AuditSchedule
    WHERE ID = #URL.ID#
    AND Year_ = #URL.Year#
    </cfquery>

	<!--- same audit due date --->
	<cfif FORM.DueDate eq #History.AuditDueDate#>
        <cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
    <cfelse>
    
    <cfset HistoryUpdate = "Audit Due Date: #dateformat(Form.DueDate, "mm/dd/yyyy")#<br />
        <cfif len(History.AuditDueDate)>
            Previous Audit Due Date: #dateformat(History.AuditDueDate, "mm/dd/yyyy")#<br />
        </cfif>
        Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
        Date: #curdate# #curTime#">
    
        <!--- add due date --->
        <CFQUERY Name="Assign" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE TechnicalAudits_AuditSchedule
        SET
        
        CurrentDueDate = #CreateODBCDate(Form.DueDate)#,
        CurrentDueDateFIeld = 'AuditDueDate',
        AuditDueDate = #CreateODBCDate(Form.DueDate)#,
        History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">
        
        WHERE 
        Year_ = #URL.Year#
        AND ID = #URL.ID#
        </CFQUERY>
    
        <cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
    </cfif>

<!--- due date in the past --->
<cfelse>
	<cflocation url="TechnicalAudits_AuditDueDate.cfm?ID=#URL.ID#&Year=#URL.Year#&msg=Audit Due Date must be a future date" addtoken="no">
</cfif>