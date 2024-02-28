<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Audits" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT xSNAPData.AuditOfficeNameID, xSNAPData.AuditYear, xSNAPData.AuditID, xSNAPData.Status, xSNAPData.AssignedTo, xSNAPData.CompletedDate, xSNAPData.DueDate

FROM xSNAPData, Corporate.AuditSchedule

WHERE xSNAPData.AuditYear = 2012
AND (xSNAPData.DueDate IS NOT NULL AND xSNAPData.DueDate < #CreateODBCDate(curdate)#)
AND xSNAPData.Status IS NULL
AND xSNAPData.CompletedDate IS NULL
AND xSNAPData.AssignedTo IS NOT NULL
AND Corporate.AuditSchedule.AuditType2 = 'Global Function/Process'
AND Corporate.AuditSchedule.ID = xSNAPData.AuditID
AND Corporate.AuditSchedule.Year_ = xSNAPData.AuditYear

GROUP BY xSNAPData.AuditOfficeNameID, xSNAPData.AuditYear, xSNAPData.AuditID, xSNAPData.Status, xSNAPData.AssignedTo, xSNAPData.CompletedDate, xSNAPData.DueDate

ORDER BY xSNAPData.AuditID, xSNAPData.AuditOfficeNameID
</cfquery>

<cfdump var="#Audits#">

<cfoutput query="Audits">
    <!--- get auditor email address for notification --->
    <CFQUERY Name="AuditorEmail" Datasource="Corporate">
    SELECT Email
    From AuditorList
    WHERE Auditor = '#AssignedTo#'
    </CFQUERY>

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
    SELECT OfficeName
    FROM IQAtblOffices
    WHERE ID = #AuditOfficeNameID#
    </cfquery>

    <cfset DaysOverdue = dateformat(curdate, "mm/dd/yyyy") - dateformat(DueDate, "mm/dd/yyyy")>
    <cfif DaysOverdue gte 5>
    	<cfset ccRecipients = "Global.InternalQuality@ul.com">
		<!--- global.internalquality@ul.com, Alan.Purvey@ul.com --->
    <cfelse>
    	<cfset ccRecipients = "Global.InternalQuality@ul.com">
    </cfif>

    <cfmail
        to="#AuditorEmail.Email#"
        from="Internal.Quality_Audits@ul.com"
        subject="OSHA SNAP Audit Overdue: #AuditYear#-#AuditID#-#AuditOfficeNameID# (#Office.OfficeName#)"
        cc="#ccRecipients#"
        type="html">
        The OSHA SNAP Audit #AuditYear#-#AuditID#-#AuditOfficeNameID# (#Office.OfficeName#) is overdue.<br><br>

        Current Date: #curDate#<Br>
        Due Date: #dateformat(DueDate, "mm/dd/yyyy")#<br /><br />

        Please contact Kai Huang with any questions regarding this OSHA SNAP Audit.<br /><br />
    </cfmail>
</cfoutput>