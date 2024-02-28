<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>

<CFQUERY Datasource="Corporate" Name="CheckYear"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM AuditSchedule
 WHERE YEAR_=#FORM.e_Year#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="addguid">
SELECT MAX(xGUID) + 1 AS xy FROM AuditSchedule
</CFQUERY>

<cfif CheckYear.recordcount is 0>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
	INSERT INTO AuditSchedule(ID, Year, AuditedBy, xGUID)
	VALUES (1, #Form.e_Year#, '#Form.AuditedBy#', #addGUID.xy#)
	</cfquery>
	
<cfelse>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT MAX(ID) + 1 AS newid
 FROM AuditSchedule
 WHERE YEAR_=#FORM.e_Year#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
	INSERT INTO AuditSchedule(ID, Year, AuditedBy, xGUID)
	VALUES (#Query.newid#, #FORM.e_Year#, '#Form.AuditedBy#', #addGUID.xy#)
	</CFQUERY>

</cfif>	

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

<cflock scope="SESSION" timeout="60">
Scheduler='<u>Username:</u> #SESSION.AUTH.USERNAME# (#SESSION.AUTH.NAME#)<br><u>Time:</u> #CurTimeDate#',
</cflock>

<cfif Form.StartDate is "" AND Form.EndDate is "">
<!--- if  blank dates --->
StartDate=null,
EndDate=null,
Month='#form.e_month#',
<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
<!--- Start Date but no End Date --->
StartDate='#FORM.StartDate#',
EndDate='#FORM.StartDate#',
<cfset m = #DateFormat(Form.StartDate, 'mm')#>
Month='#m#',
<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
<!--- Both Dates --->
	<cfif CompareDate eq -1>
		<!--- if  start date and end date are in correct order --->
		StartDate='#FORM.StartDate#',
		EndDate='#FORM.EndDate#',
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		Month='#m#',
	<cfelseif CompareDate eq 0>
		<!--- if  dates are equal --->
		StartDate='#FORM.StartDate#',
		EndDate='#FORM.StartDate#',
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		Month='#m#',	
	<cfelseif CompareDate eq 1>
		<!--- if  dates are in the wrong order --->
		StartDate='#FORM.EndDate#',
		EndDate='#FORM.StartDate#',
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		Month='#m#',
	</cfif>
<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
<!--- if no Start Date and End Date is entered --->
StartDate='#FORM.EndDate#',
EndDate='#FORM.EndDate#',
<cfset m = #DateFormat(Form.EndDate, 'mm')#>
Month='#m#',
</cfif>

Approved='No',
Scope='#FORM.e_Scope#',
AuditType='#FORM.AuditType#',
Auditor='#Form.qRSAuditor#',
OfficeName='#Form.OfficeName#',
Email='#Form.e_Email#'

<cfif CheckYear.recordcount is 0>
WHERE ID=1 AND Year=#form.e_Year#
<cfelse>
WHERE ID=#query.newid# AND Year=#form.e_Year#
</cfif>
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT * FROM AuditSchedule
<cfif CheckYear.recordcount is 0>
WHERE ID=1 AND Year=#form.e_Year#
<cfelse>
WHERE ID=#query.newid# AND Year=#form.e_Year#
</cfif>
</CFQUERY>

<cfoutput query="scheduleedit">
<cflocation url="auditdetails.cfm?id=#ID#&year=#Year#" addtoken="no">
</cfoutput>