<cfquery name="Input" Datasource="Corporate">
UPDATE TPReport6
SET 

<cfloop index="x" list="#form.fieldnames#">
<cfoutput>
<cfif x is "Comments">
<cfelse>
#x# = #form[x]#,
</cfif>
</cfoutput>
</cfloop>
Comments='N/A'

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND ID=#URL.ID#
</cfquery>

<cflocation url="TPReport_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">