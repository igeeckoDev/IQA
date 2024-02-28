<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning - Programs Audited by IQA in #url.year#">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<cfquery Datasource="Corporate" name="qEmailProgList">
SELECT AuditSchedule.Year_, AuditSchedule.ID as AuditID, ProgDev.ID as ProgID, ProgDev.Program as Program, ProgDev.Type,
ProgDev.POEmail, ProgDev.PMEmail, ProgDev.SEMail, ProgDev.Region
FROM AuditSchedule, ProgDev
WHERE AuditSchedule.Area = Program
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL
AND AuditSchedule.Year_ = #url.Year#
ORDER BY Program
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="StartID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID
FROM AuditPlanning2016_Users
</CFQUERY>

<cfif NOT len(StartID.NewID)>
	<cfset StartID.NewID = 1>
</cfif>

<cfset i = StartID.NewID>
<cfset previousProgID = 0>

<table border="1">
<tr>
    <th>ID</th>
    <th>pID</th>
	<th>Program</th>
    <th>Sent To</th>
</tr>

<cfoutput query="qEmailProgList">
	<cfset varSentTo = "#POEmail#,#PMEmail#,#SEMail#">
        <!--- remove trailing comma, if any --->
        <cfif right(varSentTo, 1) is ",">
            <cfset varSentTo = left(varSentTo, len(varSentTo)-1)>
        </cfif>
        <!--- /// --->
        <tr>
            <Td valign="top">#i#</Td>
            <td valign="top">#ProgID#</td>
            <td valign="top">#Program#</td>
            <td valign="top">#varSentTo#</td>
        </tr>

<!---
        <CFQUERY BLOCKFACTOR="100" name="AddProgram" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning2016_Users(ID, Type, pID, SurveyType, SentTo)
        VALUES(#i#, 'Program', #ProgID#, 'Program', '#varSentTo#')
        </CFQUERY>
--->

        <cfset i = i+1>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->