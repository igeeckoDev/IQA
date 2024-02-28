<cfoutput>
	<cfif NOT len(AuditDueDate) AND NOT len(Auditor)>
    	Audit Planning - Auditor and Due Date Not Selected
    <cfelseif len(AuditDueDate) AND len(Auditor)>
    	Audit Assigned and Scheduled
	</cfif>
    <!--- Flag_CurrentStep will define this --->
</cfoutput>