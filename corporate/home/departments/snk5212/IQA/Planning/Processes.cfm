<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning - Processes Audited by IQA in #url.year#">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Processes" Datasource="Corporate">
SELECT GlobalFunctions.Function as Function, GlobalFunctions.Owner, AuditSchedule.Year_, AuditSchedule.ID as AuditID, AuditSchedule.AuditArea,
GlobalFunctions.ID as ID, AuditSchedule.Email
From AuditSchedule, GlobalFunctions
WHERE GlobalFunctions.Status IS NULL
AND GlobalFunctions.Function = AuditSchedule.Area
AND AuditSchedule.AuditType2 = 'Global Function/Process'
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL
<!---AND (AuditSchedule.RescheduleNextYear IS NULL OR AuditSchedule.RescheduleNextYear = 'No')--->
AND AuditSchedule.Year_ = #url.Year#
Order BY GlobalFunctions.Function
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="StartID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID
FROM AuditPlanning2016_Users
</CFQUERY>

<cfset i = 1>
<cfset previousProcessID = 0>

<table border="1">
<tr>
    <th>ID</th>
    <th>pID</th>
	<th>Process</th>
    <th>Sent To</th>
</tr>
<cfoutput query="Processes">
<!--- in case there is the same program twice, do not add it twice! --->
<cfif ID NEQ PreviousProcessID>
    <tr>
        <td valign="top">#i#</td>
        <td valign="top">#ID#</td>
        <td valign="top">#Function#</td>
        <Td valign="top">#Email#<br>#replace(Owner, ",", "<br />", "All")#</Td>
    </tr>

<!---
    <CFQUERY BLOCKFACTOR="100" name="AddProcess" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO AuditPlanning2016_Users(ID, Type, pID, SurveyType, SentTo)
    VALUES(#i#, 'Process', #ID#, 'Process', '#Owner#')
    </CFQUERY>
--->

    <cfset i = i+1>
</cfif>

<cfset previousProcessID = ID>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->