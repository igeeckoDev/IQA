<CFQUERY BLOCKFACTOR="100" NAME="LoginName" Datasource="Corporate">
select Name, AccessLevel
FROM IQADB_Login
WHERE Status IS NULL
ORDER BY AccessLevel, Name
</CFQUERY>

<cfoutput query="LoginName">
#AccessLevel#: #Name#<br>
    <CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
    SELECT ID, Auditor, Status
    FROM AuditorList
    WHERE Auditor = '#Name#'
    </cfquery>
	
    <cfif AuditorProfile.recordCount gt 0>
        <cfloop query="AuditorProfile">
        #ID# #Auditor# (#Status#)<br /><br>
        </cfloop>
	<cfelse>
    	<b>None</b><br><br>
    </cfif>
</cfoutput>