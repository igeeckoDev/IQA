<Cfset Auditor = "Christopher Nicastro, Alan Purvey, Kyle Huang, Tovia Bat-Leah">
<cfoutput>#listlen(Auditor)#</cfoutput>

<Cfset AuditorCCEmails = "">
<cfloop index = "ListElement" list = "#Auditor#"> 
    <Cfoutput>
    #ListElement# - 
        <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
        SELECT Email 
        FROM AuditorList
        WHERE Auditor = '#trim(ListElement)#'
        </CFQUERY>
        
        <cfset AuditorCCEmails = listAppend(AuditorCCEmails, "#AuditorEmail.Email#")>
        #AuditorEmail.Email#<Br>
	</cfoutput>
</cfloop><br>

<Cfoutput>#AuditorCCEmails#</Cfoutput>