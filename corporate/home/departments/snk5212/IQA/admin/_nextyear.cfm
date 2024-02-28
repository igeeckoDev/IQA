<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audits"> 
SELECT *
 FROM AuditSchedule
 WHERE Status IS NULL 
 AND AuditedBy = 'IQA'
 AND YEAR_ = 2010
 ORDER BY ID
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="addguid">
SELECT MAX(xGUID) AS xy FROM AuditSchedule
</CFQUERY>

<cfset i = 1>
<cfset xy = #addguid.xy# + 1>

<cfoutput query="Audits">
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
INSERT INTO AuditSchedule(ID, Year_, AuditedBy, xGUID)
VALUES(#i#, 2011, 'IQA', #xy#)
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
UPDATE AuditSchedule
SET

<cfif audits.audittype2 is NOT "">
AuditType2='#Audits.AuditType2#',
</cfif>
<cfif audits.area is NOT "">
Area='#Audits.Area#',
</cfif>
<cfif audits.officename is NOT "">
Officename='#Audits.OfficeName#',
</cfif>
<cfif audits.externallocation is NOT "">
ExternalLocation='#Audits.ExternalLocation#',
</cfif>
<cfif audits.auditarea is NOT "">
AuditArea='#Audits.AuditArea#',
</cfif>
Status=null,
<cfif audits.auditor is NOT "">
Auditor='#Audits.Auditor#',
</cfif>
LeadAuditor='#Audits.LeadAuditor#',
KP='#Audits.KP#',
Scope='#Audits.Scope#',
<cfif audits.email is NOT "">
Email='#Audits.Email#',
</cfif>
<cfif audits.email2 is NOT "">
Email2='#Audits.Email2#',
</cfif>
Month='#Audits.Month#',
Approved='Yes',
AuditType='#Audits.AuditType#',
Scheduler='Auto Add<br><u>Username:</u> IQA Admin (Auto)<br><u>Time:</u> #CurTimeDate#'

WHERE
ID = #i#
AND Year_ = 2011
</cfquery>

#Year_#-#ID#-#AuditedBy# :: 2011-#i#-#AuditedBy#<br>
<cfset i = i + 1>
<cfset xy = #xy# + 1>
</cfoutput>