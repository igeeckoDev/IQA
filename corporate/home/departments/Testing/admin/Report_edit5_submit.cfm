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

<cflocation url="Report_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">