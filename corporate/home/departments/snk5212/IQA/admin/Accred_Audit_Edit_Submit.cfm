<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

<cfif Form.StartDate is "">
StartDate=null,
<cfelse>
StartDate=#CreateODBCDate(FORM.StartDate)#,
</cfif>

<cfif Form.EndDate is "">
EndDate=null,
<cfelse>
EndDate=#CreateODBCDate(FORM.EndDate)#,
</cfif>

<cfif form.e_Month is "NoChanges">
<cfelse>
Month='#FORM.e_Month#',
</cfif>

<cfset S1 = #ReplaceNoCase(Form.Scope,chr(13),"<br>", "ALL")#>
Scope='#S1#',
<cfif form.e_AuditType is "NoChanges">
<cfelse>
AuditType='#FORM.e_AuditType#',
</cfif>

<cfif form.E_OfficeName is "NoChanges">
<cfelse>
OfficeName='#Form.e_OfficeName#',
</cfif>
SiteContact='#Form.e_SiteContact#'

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?#CGI.QUERY_STRING#" addtoken="no">