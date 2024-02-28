<!--- check due date vs current date --->
<cfif Form.SRCARClosedDueDate lte curdate>
	<cflocation url="TechnicalAudits_SRCAR_Edit.cfm?#CGI.QUERY_STRING#&msg=The Due Date must be a future date" addtoken="no">
</cfif>

<CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_SRCAR
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
</CFQUERY>

<cfif SRCAR.SRCARNumber eq Form.SRCARNumber>
	<Cfset SRCAR_Check = "No Change">
<cfelse>
	<cfset SRCAR_Check = "Change">
</cfif>

<cfif SRCAR.SRCARClosedDueDate eq Form.SRCARClosedDueDate>
	<Cfset SRCAR_Check = "No Change">
<cfelse>
	<cfset SRCAR_Check = "Change">
</cfif>

<cfif SRCAR.SRCAR_AdditionalNumbers eq Form.SRCAR_AdditionalNumbers>
	<cfset SRCAR_Additional_Check = "No Change">
<cfelse>
	<cfset SRCAR_Additional_Check = "Change">
</cfif>

<cfif SRCAR_Check eq "No Change" AND SRCAR_Additional_Check eq "No Change" AND SRCAR.SRCARClosedDueDate eq Form.SRCARClosedDueDate>
	<cflocation url="TechnicalAudits_SRCAR_Edit.cfm?#CGI.QUERY_STRING#&msg=No Changes Made" addtoken="No">
<cfelseif SRCAR_Check eq "Change" OR SRCAR_Additional_Check eq "Change" OR SRCAR.SRCARClosedDueDate eq Form.SRCARClosedDueDate>
   
    <!--- add details --->
    <CFQUERY NAME="AddRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_SRCAR
    SET
    
    <cfif len(Form.SRCAR_AdditionalNumbers)>
    SRCAR_AdditionalNumbers = '#Form.SRCAR_AdditionalNumbers#',
    </cfif>
    SRCARNumber = '#Form.SRCARNumber#',
    IssueType = '#Form.IssueType#',
    SRCARClosedDueDate = #createODBCDate(Form.SRCARClosedDueDate)#,
    SRCAREnteredDate = #createODBCDate(curdate)#
    
    WHERE 
    ID = #URL.SRCAR_ID#
    </cfquery>
       
    <!--- history update --->
    <CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT History 
    FROM TechnicalAudits_AuditSchedule
    WHERE ID = #URL.ID#
    AND Year_ = #URL.Year#
    </cfquery>
    
    <!--- indicate if issuetype or srcar_additionalnumbers fields were changed --->
    <cfif SRCAR_Check eq "Change">
    	<cfset History1 = "#Form.IssueType# Number Edited<br>">
    <cfelse>
    	<cfset History1 = "">
    </cfif>
    
    <!--- indicate if issuetype or srcar_additionalnumbers fields were changed --->
    <cfif SRCAR_Additional_Check eq "Change">
    	<cfset History2 = "Additional SRs/CARs Edited<br>">
    <cfelse>
    	<cfset History2 = "">
    </cfif>
    
    <cfset HistoryUpdate = "
        #History1#
		#History2#
        Due Date to indicate #Form.IssueType# is Closed: #dateformat(Form.SRCARClosedDueDate, "mm/dd/yyyy")#<br>
        Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
        Date: #curdate# #curTime#">
    
    <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    SRCARClosedDueDate = #createODBCDate(Form.SRCARClosedDueDate)#,
    History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">
    
    WHERE
    ID = #URL.ID#
    AND Year_ = #URL.Year#
    </CFQUERY>
</cfif>

<cflocation url="#IQADir#TechnicalAudits_AddNC_SelectCategory.cfm?ID=#URL.ID#&Year=#URL.Year#&SRCARStatus=Completed" addtoken="no">