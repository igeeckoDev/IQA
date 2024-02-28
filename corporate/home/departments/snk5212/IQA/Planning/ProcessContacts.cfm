<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Planning - Programs Audited by IQA in #url.year#">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="qEmailProcessesList" Datasource="Corporate">
SELECT DISTINCT GlobalFunctions.Owner as Contact
From AuditSchedule, GlobalFunctions
WHERE GlobalFunctions.Status IS NULL
AND GlobalFunctions.Function = AuditSchedule.Area
AND AuditSchedule.AuditType2 = 'Global Function/Process'
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.Status IS NULL
<!---AND (AuditSchedule.RescheduleNextYear IS NULL OR AuditSchedule.RescheduleNextYear = 'No')--->
AND AuditSchedule.Year_ = #url.Year#
</CFQUERY>

<!---<cfdump var="#qEmailProgList#">--->

<cfset ProcIDList = "">

<cfoutput query="qEmailProcessesList">
<cfif Len(Contact)>
    #Contact#<br>
    
    <cfquery Datasource="Corporate" name="Processes"> 
    SELECT ID, Function
    FROM GlobalFunctions
    WHERE Owner = '#Contact#'
    </cfquery>
    
    <cfif Processes.RecordCount GT 0>
        <cfloop query="Processes">
		<cfset ProcIDList = ListAppend(ProcIDList, "#ID#")>

        #ID# #Function#<br>
        </cfloop>
        [#ProcIDList#]<br><br>
    <cfelse>
        None<br><br>
    </cfif>

<!---    
Contact = '#Contact#'<br>
ProcIDList = '#ProcIDList#'<Br><br>
--->

<cfset ProcIDList = "">
<cfset temp = "">
</cfif>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->