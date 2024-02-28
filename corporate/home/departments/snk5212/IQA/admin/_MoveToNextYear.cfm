<cfset curMonth = #Dateformat(now(), 'mm')#>
<cfset nextYear = URL.MoveYear + 1>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Copy Audit to #nextYear#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="Audit" datasource="Corporate">
SELECT ID, Year_, Status, RescheduleNextYear
FROM AuditSchedule
WHERE 
AuditedBY = 'IQA'
AND Report = 'Completed'

<!--- Jan-Feb-Mar --->
<cfif curMonth eq 4>
AND Month < 4
<!--- Apr-May-Jun --->
<cfelseif curMonth eq 7>
AND Month < 7 AND Month > 3
<!--- Jul-Aug-Sep --->
<cfelseif curMonth eq 10>
AND Month < 10 AND Month > 6
<!--- Oct - Nov - Dec --->
<cfelseif curMonth eq 1>
AND Month < 13 AND Month > 9
</cfif>

AND Year_ = #URL.MoveYear#

ORDER BY ID
</cfquery>

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
	<cfif NOT len(Status)>
    	<cfif RescheduleNextYear eq "No" OR NOT len(RescheduleNextYear)>
            <cfquery name="AuditDetails" datasource="Corporate">
            SELECT
            ID, Year_, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, OfficeName, Area, AuditArea, Month, Email, Email2, Desk, BusinessUnit
            
            FROM 
            AuditSchedule
            
            WHERE 
            Year_ = #Year_#
            AND ID = #ID#
            </cfquery>
            
            <cfoutput query="AuditDetails">
            #Year_#-#ID# #OfficeName# #AuditType2# #Area# #AuditArea#<br>

            <cfif AuditType2 is "MMS - Medical Management Systems">
                <cfset ScopeStatement = "#Request.MMSScope#">
            <cfelse>
                <cfset ScopeStatement = "#Request.IQAScope2013#">
            </cfif>

            <cfquery name="AddNewToSched" datasource="Corporate">
            INSERT INTO AuditSchedule (xGUID, ID, Year_, Approved, AuditedBy, AuditType, AuditType2, LeadAuditor, Auditor, OfficeName, Area, AuditArea, Month, Scope, Email, Email2, Desk, BusinessUnit)
            VALUES(#x#, #y#, #nextYear#, 'Yes', '#AuditedBy#', '#AuditType#', '#AuditType2#', '#LeadAuditor#', '#Auditor#', '#OfficeName#', '#Area#', '#AuditArea#', #Month#, '#ScopeStatement#', '#Email#', '#Email2#', '#Desk#', '#BusinessUnit#')
            </cfquery>
    
            Added: #nextYear#-#y#-#AuditedBy# (#x#)<br />
            <a href="auditdetails.cfm?ID=#maxID.maxID#&Year=#nextYear#">View Audit</a><br><br>
            </cfoutput>
		
            <cfset y = y+1>
            <cfset x = x+1>
        </cfif>
	</cfif>
</cfloop>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->