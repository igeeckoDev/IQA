<cfif isDefined("Form.StartDate") AND isDefined("Form.EndDate")>
	<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>
</cfif>

<CFQUERY Datasource="Corporate" Name="CheckYear"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE YEAR_ = #FORM.e_Year#
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
	SELECT MAX(ID) + 1 AS newid
	FROM AuditSchedule
	WHERE YEAR_ = #FORM.e_Year#
	</CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
	INSERT INTO AuditSchedule(ID, Year_, AuditedBy, xGUID)
	VALUES (#Query.newid#, #FORM.e_Year#, '#Form.AuditedBy#', #addGUID.xy#)
	</CFQUERY>
</cfif>	
	
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

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

<cflock scope="SESSION" timeout="60">
Scheduler='<u>Username:</u> #SESSION.AUTH.USERNAME# (#SESSION.AUTH.NAME#)<br><u>Time:</u> #CurTimeDate#',
</cflock>

Approved='No',
<cfset S1 = #ReplaceNoCase(Form.Scope,chr(13),"<br>", "ALL")#>
Scope='#S1#',
AuditType='#FORM.e_AuditType#',
<cfif form.auditedby is "AS">
	AuditType2='#FORM.AuditType2#',
	ASContact='#Form.e_ASContact#',
<cfelseif form.auditedby is "Finance">
	AuditType2='Finance',
	ASContact='#Form.e_FContact#',
</cfif>

OfficeName='#Form.e_OfficeName#',

<cfif form.auditedby is "AS">
	SiteContact='#Form.e_SiteContact#'
<cfelse>
	SiteContact=null
</cfif>

WHERE ID = 
<cfif CheckYear.recordcount is 0>
	1
<cfelse>
	#query.newid#
</cfif>
AND Year_ = #form.e_Year#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT AuditSchedule.ID, AuditSchedule.Year_ AS "Year" FROM AuditSchedule

WHERE ID = 
<cfif CheckYear.recordcount is 0>
	1
<cfelse>
	#query.newid#
</cfif>
AND Year_ = #form.e_Year#
</CFQUERY>

<cfoutput query="ScheduleEdit">
	<cflocation url="auditdetails.cfm?id=#ID#&year=#Year#" ADDTOKEN="No">
</cfoutput>
