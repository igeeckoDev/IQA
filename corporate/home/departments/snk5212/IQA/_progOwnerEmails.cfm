<CFQUERY BLOCKFACTOR="100" name="output" Datasource="Corporate">
SELECT DISTINCT POEmail
FROM ProgDev
WHERE (Status IS NULL OR Status = 'Under Review')
</cfquery>

<cfset xyz = #valueList(output.POEmail, ', ')#>

<cfoutput>
#xyz#
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="output" Datasource="Corporate">
SELECT DISTINCT SEmail
FROM ProgDev
WHERE (Status IS NULL OR Status = 'Under Review')
</cfquery>

<cfset xyz = #valueList(output.SEmail, ', ')#>

<cfoutput>
#xyz#
</cfoutput>