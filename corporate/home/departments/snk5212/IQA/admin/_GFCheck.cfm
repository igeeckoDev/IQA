<CFQUERY NAME="Output" Datasource="Corporate">
SELECT DISTINCT Area 
FROM AuditSchedule 
WHERE AuditType2 = 'Global Function/Process' 
AND AuditedBY = 'IQA' 
AND Year_ >= 2008 
ORDER By Area 
</CFQUERY>

<cfoutput query="output">
#Area# - 
    <CFQUERY NAME="FunctionCheck" Datasource="Corporate">
    SELECT Function 
    FROM GlobalFunctions
    WHERE Function = '#Area#'
    </CFQUERY>
    
    <cfif FunctionCheck.recordCount gt 0>
    	Yes
    <cfelse>
    	<b>No</b>
    </cfif><br>
</cfoutput>