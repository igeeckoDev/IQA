<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning - Programs Audited by IQA in #url.year#">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="qEmailProgList">
SELECT DISTINCT ProgDev.POEmail as Contact
FROM AuditSchedule, ProgDev
WHERE AuditSchedule.Area = Program
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL
AND AuditSchedule.Year_ = #url.Year#

UNION

SELECT DISTINCT ProgDev.PMEmail as Contact
FROM AuditSchedule, ProgDev
WHERE AuditSchedule.Area = Program
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL
AND AuditSchedule.Year_ = #url.Year#

UNION

SELECT DISTINCT ProgDev.SEMail as Contact
FROM AuditSchedule, ProgDev
WHERE AuditSchedule.Area = Program
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL
AND AuditSchedule.Year_ = #url.Year#
</cfquery>

<!---<cfdump var="#qEmailProgList#">--->

<cfset ProgIDList = "">
<cfset i = 35>

<cfoutput query="qEmailProgList">
<cfif Len(Contact)>
    #Contact#<br>

    <cfquery Datasource="Corporate" name="Programs">
    SELECT ProgDev.ID as ProgID, ProgDev.Program as Program
    FROM ProgDev
    WHERE POEmail = '#Contact#'
    OR PMEmail = '#Contact#'
    OR SEmail = '#Contact#'
    </cfquery>

    <cfif Programs.RecordCount GT 0>
        <cfloop query="Programs">
		<cfset ProgIDList = ListAppend(ProgIDList, "#ProgID#")>

        #ProgId# #Program#<br>
        </cfloop>
        [#ProgIDList#]<br><br>

<!---
        <CFQUERY BLOCKFACTOR="100" name="AddProcess" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning2014_Users(ID, SurveyType, SubjectID, SentTo)
        VALUES(#i#, 'Program', '#ProgIDList#', '#Contact#')
        </CFQUERY>
--->

        <cfset i = i+1>
    <cfelse>
        None<br><br>
    </cfif>

<cfset ProgIDList = "">
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->