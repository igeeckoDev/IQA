You can access the report by following the link below:
http://#CGI.Server_Name#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#

Audit Details:
http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#

<cfif audittype is "Local Function" or audittype is "Local Function CBTL" or audittype is "Local Function FS">
The Local Quality Manager is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
<cfelseif audittype is "Program">
The Program Manager and Program Owner are responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
<cfelseif audittype is "Corporate">
The Corporate Process Owner is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
<cfelseif audittype is "Global Function/Process">
The Global Process Owner is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
<cfelseif audittype is "Field Services">
Field Service Quality Rep is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfif>
