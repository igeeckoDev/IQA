<!---
<cfquery Datasource="Corporate" name="qEmailProgList"> 
SELECT AuditSchedule.Year_, AuditSchedule.ID as AuditID, ProgDev.ID as ProgID, ProgDev.Program as Program, ProgDev.POEmail, ProgDev.PMEmail, ProgDev.SEMail, ProgDev.Region
FROM AuditSchedule, ProgDev
WHERE AuditSchedule.Area = Program
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL
AND AuditSchedule.Year_ = 2010
ORDER BY ProgDev.Region, Program
</cfquery>

<cfset i = 1>
<cfoutput query="qEmailProgList" group="Program">
#i# #Program# #ProgID# (#POEmail# #PMEMail# #SEMail#)<br>

<cfset Edit1 = replace(Program, "&lt;", "<", "All")>
<cfset ProgramName = replace(Edit1, "&gt;", ">", "All")>

<cfmail 
	to="#POEmail#, #PMEmail#, #SEmail#" 
	from="global.internalquality@ul.com"
    subject="2011 IQA Audit Planning - #ProgramName#"
    bcc="Christopher.J.Nicastro@ul.com" 
    type="html">
Program Owners/Managers/Specialists:<br><br>

Preparation for 2011 Corporate Internal Quality Audits is in its initial stages.<br><br>

At this time, I am requesting your input for <b>#Program#</b> for the 2011 audit year. This information will be included in our audit plans.<br><br>

Please follow the link below to provide information for <b>#Program#</b>:<br>
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/AuditPlanning_getEmpNo.cfm?Type=Program&ID=#ProgID#">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/Planning/AuditPlanning_getEmpNo.cfm?Type=Program&ID=#ProgID#</a><br><br>

If someone will be providing this information on your behalf, forward this email to them including the link above.<br><br>

Please respond by <b>December 30, 2010</b>.<br><br>

<u>Note</u> - You will receive this email for each program you are the Owner, Manager or Specialist.<br><br>

Contact me if you have any questions or comments.<br><br>

Denise Echols<br>
Underwriters Laboratories Inc.<br>
Corporate Quality Engineering Manager<br>
Phone: 1.847.664.1020<br>
Mobile: 1.847.323.4631<br>
Fax: 1.847.407.1020<br>
Email: global.internalquality@ul.com
</cfmail>

<cfset i = i+1>
</cfoutput>
--->