<CFQUERY Datasource="Corporate" Name="CheckYear">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE YEAR_ = <cfqueryparam value="#Form.e_Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="addguid">
SELECT MAX(xGUID) + 1 AS xy FROM AuditSchedule
</CFQUERY>

<cfif CheckYear.recordcount is 0>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
	INSERT INTO AuditSchedule(ID, Year_, AuditedBy, xGUID)
	VALUES (1, #Form.e_Year#, '#Form.AuditedBy#', #addGUID.xy#)
	</cfquery>
<cfelse>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
	SELECT MAX(ID) + 1 AS newID FROM AuditSchedule
    WHERE Year_ = <cfqueryparam value="#Form.e_Year#" cfsqltype="cf_sql_integer">
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
	INSERT INTO AuditSchedule(ID, Year_, AuditedBy, xGUID)
	VALUES (#Query.newid#, #FORM.e_Year#, '#Form.AuditedBy#', #addGUID.xy#)
	</CFQUERY>
</cfif>
	
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

<cflock scope="SESSION" timeout="60">
Scheduler='<u>Username:</u> #SESSION.AUTH.USERNAME# (#SESSION.AUTH.NAME#)<br><u>Time:</u> #CurTimeDate#',
</cflock>

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

Approved='No',
Month='#FORM.e_Month#',
<cfset S1 = #ReplaceNoCase(Form.Scope,chr(13),"<br>", "ALL")#>
Scope='#S1#',
AuditType='#FORM.e_AuditType#',
AuditType2='#Form.AuditType2#',
OfficeName='#Form.e_OfficeName#',
SiteContact='#Form.e_SiteContact#'

WHERE 
<cfif CheckYear.recordcount is 0>
	ID = 1 
<cfelse>
	ID = #Query.newID#
</cfif>
AND Year_ = <cfqueryparam value="#Form.e_Year#" cfsqltype="cf_sql_integer">
</CFQUERY>
	
<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT AuditSchedule.ID, AuditSchedule.Year_ as "Year" FROM AuditSchedule
<cfif CheckYear.recordcount is 0>
	WHERE ID = 1 
<cfelse>
	WHERE ID = #query.newid# 
</cfif>
AND Year_ = <cfqueryparam value="#Form.e_Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput query="ScheduleEdit">
	<cflocation url="auditdetails.cfm?id=#ID#&year=#Year#" addtoken="no">
</cfoutput>