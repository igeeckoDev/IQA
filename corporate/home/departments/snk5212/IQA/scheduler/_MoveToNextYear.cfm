<cfset curMonth = #Dateformat(now(), 'mm')#>
<cfset nextYear = URL.MoveYear + 1>
<cfset lastMonth = curMonth - 1>

<cfoutput>Copy Audit to #nextYear#</cfoutput><Br /><Br />

<cfquery name="Audit" datasource="Corporate">
SELECT ID, Year_, Status, RescheduleNextYear, Report
FROM AuditSchedule
WHERE
AuditedBY = 'IQA'
AND (Report = 'Completed' OR Status = 'Deleted')
AND Month < 10

<!---
<!--- all but Jan --->
<cfif curMonth gt 1>
AND Month = #lastMonth#
<cfelse>
<!--- Jan --->
AND Month = 12
</cfif>
--->

AND Year_ = #URL.MoveYear#

ORDER BY Month, ID
</cfquery>

Audits moved: <cfoutput>#audit.recordcount#</cfoutput><br /><br />

<cfquery name="maxGUID" datasource="Corporate">
SELECT MAX(xGUID)+1 as maxGUID FROM AuditSchedule
</cfquery>

<cfset x = maxGUID.maxGUID>

<cfquery name="maxID" datasource="Corporate">
SELECT MAX(ID)+1 as maxID FROM AuditSchedule
WHERE Year_ = #nextYear#
</cfquery>

<cfif NOT len(maxID.maxID)>
    <cfset maxID.maxID = 1>
</cfif>

<cfset y = maxID.maxID>

<cfloop query="Audit">
   	<cfif RescheduleNextYear eq "No" OR NOT len(RescheduleNextYear)>
           <cfquery name="AuditDetails" datasource="Corporate">
           SELECT
           xGUID, ID, Year_, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, OfficeName, Area, AuditArea, Month, Email, Email2, Desk, BusinessUnit, report, status

           FROM
           AuditSchedule

           WHERE
           Year_ = #Year_#
           AND ID = #ID#
           </cfquery>

           <cfoutput query="AuditDetails">
           #xGUID# #Year_#-#ID# (#monthasstring(Month)#) #OfficeName# #AuditType2# #Area# #AuditArea# #Report# <b>#status#</b><br>

           <cfif AuditType2 is "MMS - Medical Management Systems">
               <cfset ScopeStatement = "#Request.MMSScope#">
           <cfelse>
               <cfset ScopeStatement = "#Request.IQAScope2013#">
           </cfif>

			<cfquery name="AddNewToSched" datasource="Corporate">
            INSERT INTO AuditSchedule (xGUID, ID, Year_, lastYear, Approved, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, OfficeName, Area, AuditArea, Month, Scope, Email, Email2, Desk, BusinessUnit, Scheduler)
            VALUES(#x#, #y#, #nextYear#, #xGUID#, 'Yes', '#AuditedBy#', '#AuditType#', '#AuditType2#', '#LeadAuditor#', '#Auditor#', '#OfficeName#', '#Area#', '#AuditArea#', #Month#, '#ScopeStatement#', '#Email#', '#Email2#', '#Desk#', '#BusinessUnit#', '<u>Username:</u> Auto-Copy (IQA Admin) of Audit #Year_#-#ID# to #nextYear#<br><u>Date:</u> #curdate#')
            </cfquery>

           Added: #nextYear#-#y#-#AuditedBy# (#x#)<br />
           <a href="../auditdetails.cfm?ID=#y#&Year=#nextYear#">View Audit</a><br><br>
           </cfoutput>

           <cfset y = y+1>
           <cfset x = x+1>
       </cfif>
</cfloop>