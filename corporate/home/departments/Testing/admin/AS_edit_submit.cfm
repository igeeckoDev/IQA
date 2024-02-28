<cfif isDefined("Form.StartDate") AND isDefined("Form.EndDate")>
	<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

<!---
<cfif NOT len(Form.StartDate) AND NOT len(Form.EndDate)>
    StartDate=null,
    EndDate=null,
    Month=#form.e_month#,
<cfelseif len(Form.StartDate) AND NOT len(Form.EndDate)>
	StartDate=#CreateODBCDate(FORM.StartDate)#,
	EndDate=#CreateODBCDate(FORM.StartDate)#,
	<cfset m = #DateFormat(CreateODBCDate(Form.StartDate), 'mm')#>
	Month='#m#',
<cfelseif len(Form.Startdate) AND len(Form.EndDate)>
	<cfif CompareDate eq -1>
		StartDate=#CreateODBCDate(FORM.StartDate)#,
		EndDate=#CreateODBCDate(FORM.EndDate)#,
		<cfset m = #DateFormat(CreateODBCDate(Form.StartDate), 'mm')#>
		Month='#m#',
	<cfelseif CompareDate eq 0>
		StartDate=#CreateODBCDate(FORM.StartDate)#,
		EndDate=#CreateODBCDate(FORM.EndDate)#,
		<cfset m = #DateFormat(CreateODBCDate(Form.StartDate), 'mm')#>
		Month='#m#',	
	<cfelseif CompareDate eq 1>
		StartDate=#CreateODBCDate(FORM.EndDate)#,
		EndDate=#CreateODBCDate(FORM.StartDate)#,
		<cfset m = #DateFormat(CreateODBCDate(Form.EndDate), 'mm')#>
		Month='#m#',
	</cfif>
<cfelseif NOT len(Form.Startdate) AND len(Form.EndDate)>
	StartDate=#CreateODBCDate(FORM.EndDate)#,
	EndDate=#CreateODBCDate(FORM.EndDate)#,
	<cfset m = #DateFormat(CreateODBCDate(Form.EndDate), 'mm')#>
	Month='#m#',
</cfif>
--->

<cfset S1 = #ReplaceNoCase(Form.Scope,chr(13),"<br>", "ALL")#>
Scope='#S1#',

<cfif form.auditedby is "AS">
	AuditType='#FORM.e_AuditType#',
</cfif>

<cfif form.e_ASContact NEQ "NoChanges">
	ASContact='#Form.e_ASContact#',
</cfif>

<cfif form.E_OfficeName NEQ "NoChanges">
	OfficeName='#Form.e_OfficeName#',
</cfif>

<cfif form.auditedby is "AS">
	SiteContact='#Form.e_SiteContact#'
<cfelse>
	SiteContact=''
</cfif>

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?#CGI.QUERY_STRING#" ADDTOKEN="No">