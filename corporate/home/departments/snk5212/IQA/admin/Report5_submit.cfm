<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
SELECT ID, Year_ as "Year"
FROM Report5
WHERE ID = #URL.ID# 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif a.recordcount is 0>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
INSERT INTO Report5(ID, Year_, AuditedBy)
VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">, '#URL.AuditedBy#')
</cfquery>
</cfif>

<cfquery name="Input" Datasource="Corporate">
UPDATE Report5
SET 

<cfloop index="x" list="#form.fieldnames#">
<cfoutput>
<cfif x is "Comments">
<cfset C1 = #ReplaceNoCase(Form.Comments,chr(13),"<br>", "ALL")#>
Comments='#C1#',
<cfelse>
#x# = #form[x]#,
</cfif>
</cfoutput>
</cfloop>
Placeholder='N/A'

WHERE
Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID=#URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Report='Entered'

WHERE ID = #URL.ID# 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cflocation url="Report_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">