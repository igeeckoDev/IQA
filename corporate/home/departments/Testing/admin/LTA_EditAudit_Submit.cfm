<CFQUERY Datasource="Corporate" Name="Details"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year, AuditSchedule.Scheduler
FROM AuditSchedule
WHERE YEAR_ = #URL.Year#
AND ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

<cflock scope="SESSION" timeout="60">
Scheduler='Edited By <u>Username:</u> #SESSION.AUTH.USERNAME# (#SESSION.AUTH.NAME#)<br><u>Time:</u> #CurTimeDate#<br /><br />#Details.Scheduler#',
</cflock>

Auditor='#Form.e_Auditor#',
<cfset N1 = #ReplaceNoCase(Form.Notes,chr(13),"<br>", "ALL")#>
Notes='#N1#',
AuditArea='#Form.e_AuditArea#',
<!---
RD='#Form.e_Standards#',
--->
AuditType='#FORM.AuditType#',
AuditType2='#FORM.AuditType2#',
OfficeName='#Form.e_OfficeName#',
<cfif len(Form.Email2)>
	Email2='#Form.Email2#',
</cfif>
EmailName='#Form.e_EmailName#',
Email='#Form.e_Email#'

WHERE ID = #URL.ID# 
AND Year_ = #URL.Year#
</CFQUERY>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&year=#URL.Year#" addtoken="no">