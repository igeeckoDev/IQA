<cfif form.audittype is "Field Services">
<cflocation URL="FUSSummary.cfm?Year=#CurYear#">
<cfelse>
<cflocation URL="AuditTypeSummary.cfm?Year=#CurYear#&AuditType=#Form.AuditType#">
</cfif>