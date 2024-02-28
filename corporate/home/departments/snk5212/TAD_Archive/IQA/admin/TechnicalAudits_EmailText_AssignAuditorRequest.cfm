<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Full'
</cfquery>

<cfoutput>
Greetings,<br /><br />

A new Full Technical audit has been created in the Technical Audit Database and you have been assigned the task of assigning an auditor.<br /><br />

Task assigned to: #Audit.ROM# (Regional Operations Manager)<br /><br />

Click here to open the audit:<br />
<a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

This task has a due date of #dateformat(DueDate, "mm/dd/yyyy")#<br /><br />

Global CAS Technical Auditors: <a href="#DocumentLinks.HTTPLINKNAME#">Link to Auditor List</a><br /><br />

Note:  Any new staff member that will be functioning as a technical auditor will be requested to take the online Oracle based ‘Conducting Internal Technical Audits’ course. Further instructions will be provided to the staff when they are assigned the projects for audit.<br /><br />

I would appreciate you completing the assignment of the auditors by the due date to keep these audits moving forward.<br /><br />

Thanks,<br /><br />

Technical Audit Team<br /><Br />

<cfif len(Audit.TAM)>
	#Audit.TAM# (Technical Audit Manager)
<cfelse>
	#Request.TechnicalAuditMailbox# (Technical Audit Manager)
</cfif><br />
</cfoutput>