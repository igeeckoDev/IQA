<cfif Form.Resched is "Cancel Request">
<cflocation url="auditdetails.cfm?id=#url.id#&year=#url.year#" addtoken="no">
<cfelseif form.resched is "Confirm Request">

<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>

<CFQUERY BLOCKFACTOR="100" name="Orig" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput query="Orig">
<cfset OrigMonth = MonthAsString(Month)>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Reschedule">
UPDATE AuditSchedule
SET

RescheduleStatus='Rescheduled',
RescheduleNextYear=
<cfif Form.RescheduleNextYear is "Yes">
'Yes',
<cfelse>
'No',
</cfif>

<cfif Form.StartDate is "" AND Form.EndDate is "">
StartDate=null,
EndDate=null,
Month='#form.month#',
<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
StartDate='#FORM.StartDate#',
EndDate='#FORM.StartDate#',
<cfset m = #DateFormat(Form.StartDate, 'mm')#>
Month='#m#',
<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
	<cfif CompareDate eq -1>
		StartDate='#FORM.StartDate#',
		EndDate='#FORM.EndDate#',
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		Month='#m#',
	<cfelseif CompareDate eq 0>
		StartDate='#FORM.StartDate#',
		EndDate='#FORM.StartDate#',
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		Month='#m#',
	<cfelseif CompareDate eq 1>
		StartDate='#FORM.EndDate#',
		EndDate='#FORM.StartDate#',
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		Month='#m#',
	</cfif>
<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
StartDate='#FORM.EndDate#',
EndDate='#FORM.EndDate#',
<cfset m = #DateFormat(Form.End, 'mm')#>
Month='#m#',
</cfif>

RescheduleNotes='#FORM.RescheduleNotes#'

WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="Schedule" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfset NextYear = #URL.Year# + 1>

<cfif schedule.audittype is "TPTDP">
<CFQUERY Datasource="Corporate" Name="CheckBillable">
SELECT * FROM ExternalLocation
WHERE ExternalLocation = '#Schedule.ExternalLocation#'
</CFQUERY>
<cfelse>
</cfif>

<cfif Schedule.RescheduleNextYear is "Yes">

<CFQUERY Datasource="Corporate" Name="CheckYear">
SELECT * FROM AuditSchedule
WHERE Year_ = #nextyear#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="addguid">
SELECT MAX(xGUID) + 1 AS xy FROM AuditSchedule
</CFQUERY>

<cfif CheckYear.recordcount is 0>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
	INSERT INTO AuditSchedule(ID, Year, AuditedBy, xGUID)
	VALUES (1, #nextyear#, '#Schedule.AuditedBy#', #addGUID.xy#)
	</cfquery>
<cfelse>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
	SELECT MAX(ID) + 1 AS newid FROM AuditSchedule
	WHERE Year_ = #nextyear#
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
	INSERT INTO AuditSchedule(ID, Year, AuditedBy, xGUID)
	VALUES (#Query.newid#, #nextyear#, '#Schedule.AuditedBy#', #addGUID.xy#)
	</CFQUERY>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET

<cfif schedule.audittype is "Finance">
officename='#schedule.officename#',
ascontact='#schedule.ascontact#',
scope='#schedule.scope#',
area=null,
externallocation=null,
auditarea=null,
status=null,
leadauditor=null,
auditor=null,
reschedulestatus=null,
reschedulenotes=null,
reschedulenextyear=null,
report=null,
report2=null,
plan=null,
scopeletter=null,
scopeletterdate=null,
followup=null,
notes=null,
kp=null,
rd=null,
email=null,
agenda=null,
sitecontact=null,
desk=null,
<cfelse>

<cfif schedule.AuditType is "TPTDP">
ExternalLocation='#schedule.ExternalLocation#',
	<cfif CheckBillable.Billable is "1">
	Billable='Yes',
	<cfelse>
	Billable='No',
	</cfif>
<cfelse>
AuditArea='#schedule.AuditArea#',
Area='#schedule.Area#',
OfficeName='#schedule.OfficeName#',
Email=<cfif schedule.Email is "">null,<cfelse>'#schedule.Email#',</cfif>
<cfif schedule.RD is "- None -" or schedule.RD is "">
<cfelse>
RD='#schedule.RD#',
</cfif>

<cfif schedule.KP is "- None -" or schedule.KP is "">
<cfelse>
KP='#schedule.KP#',
</cfif>
</cfif>

Notes='This audit has been rescheduled in place of audit #URL.Year#-#URL.ID#',
LeadAuditor='#schedule.LeadAuditor#',
Auditor='#schedule.Auditor#',
Scope='#schedule.Scope#',
</cfif>

Approved='Yes',
<cfif Form.StartDate is "" AND Form.EndDate is "">
StarteDate=null,
EndDate=null,
month=#form.month#,
<cfelseif Form.StartDate is NOT "" AND Form.EndDate is "">
StartDate='#FORM.StartDate#',
EndDate='#FORM.StartDate#',
<cfset m = #DateFormat(Form.StartDate, 'mm')#>
Month='#m#',
<cfelseif Form.Startdate is NOT "" AND Form.EndDate is NOT "">
	<cfif CompareDate eq -1>
		StartDate='#FORM.StartDate#',
		EndDate='#FORM.EndDate#',
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		Month='#m#',
	<cfelseif CompareDate eq 0>
		StartDate='#FORM.StartDate#',
		EndDate='#FORM.StartDate#',
		<cfset m = #DateFormat(Form.StartDate, 'mm')#>
		Month='#m#',
	<cfelseif CompareDate eq 1>
		StartDate='#FORM.EndDate#',
		EndDate='#FORM.StartDate#',
		<cfset m = #DateFormat(Form.EndDate, 'mm')#>
		Month='#m#',
	</cfif>
<cfelseif Form.Startdate is "" AND Form.EndDate is NOT "">
StartDate='#FORM.EndDate#',
EndDate='#FORM.EndDate#',
<cfset m = #DateFormat(Form.End, 'mm')#>
Month='#m#',
</cfif>

AuditType='#schedule.AuditType#',
AuditType2=<cfif schedule.audittype2 is "">null<cfelse>'#schedule.AuditType2#'</cfif>

WHERE
<cfif CheckYear.recordcount is 0>
ID=1
<cfelse>
ID=#Query.newid#
</cfif>
AND Year=#nextyear#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="NextYr" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE
<cfif CheckYear.recordcount is 0>
ID=1
<cfelse>
ID=#Query.newid#
</cfif>
and Year=#nextyear#
</CFQUERY>

<cfoutput query="NextYr">
<cfset NewMonth = MonthAsString(Month)>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="Schedule" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput query="Schedule">
<cfset OrigMonth = MonthAsString(Month)>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Note">
UPDATE AuditSchedule
SET

RescheduleNotes='#Schedule.RescheduleNotes#<br><br>This audit has been rescheduled as #NextYear#-#NextYr.ID#'

WHERE ID = #URL.ID# AND YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>
</cfif>

<cfif schedule.auditedby is "IQA">
<cfif curdir is "/departments/snk5212/iqadev/admin/">

<cfif Schedule.audittype is "TPTDP">
<cfif RescheduleNextYear is "Yes">
<cfmail to="Christopher.J.Nicastro@ul.com, Kai.Huang@ul.com" from="Internal.Quality_Audits@ul.com" subject="DEV TESTING - Audit Reschedule - #Schedule.ExternalLocation#" bcc="Internal.Quality_Audits@ul.com">
DEVELOPMENT SERVER TESTING - PLEASE DISREGARD

The Audit of #Schedule.ExternalLocation# (#URL.Year#-#URL.ID#) scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #NewMonth#, #NextYear# (#NextYear#-#NextYr.ID#).

Comments: #Form.RescheduleNotes#
</cfmail>
<cfelse>
<cfmail to="Christopher.J.Nicastro@ul.com, Kai.Huang@ul.com" from="Internal.Quality_Audits@ul.com" subject="DEV TESTING - Audit Reschedule - #Schedule.ExternalLocation#" bcc="Internal.Quality_Audits@ul.com">
DEVELOPMENT SERVER TESTING - PLEASE DISREGARD

The Audit of #Schedule.ExternalLocation# (#URL.Year#-#URL.ID#) scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #MonthasString(Schedule.Month)#, #URL.Year#.

Comments: #Form.RescheduleNotes#
</cfmail>
</cfif>

<cfelse>

<cfif RescheduleNextYear is "Yes">
<cfmail to="Christopher.J.Nicastro@ul.com, Kai.Huang@ul.com" from="Internal.Quality_Audits@ul.com" subject="DEV TESTING - Audit Reschedule - #Schedule.OfficeName#, #Schedule.AuditArea#">
DEVELOPMENT SERVER TESTING - PLEASE DISREGARD

The Audit of #Schedule.Officename# (#Trim(Schedule.AuditArea)#, #URL.Year#-#URL.ID#) scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #NewMonth#, #NextYear# (#NextYear#-#NextYr.ID#).

Comments: #Form.RescheduleNotes#
</cfmail>
<cfelse>
<cfmail to="Christopher.J.Nicastro@ul.com, Kai.Huang@ul.com" from="Internal.Quality_Audits@ul.com" subject="DEV TESTING - Audit Reschedule - #Schedule.OfficeName#, #Schedule.AuditArea#">
DEVELOPMENT SERVER TESTING - PLEASE DISREGARD

The Audit of #Schedule.Officename# (#Trim(Schedule.AuditArea)#, #URL.Year#-#URL.ID#) scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #MonthAsString(Schedule.Month)#, #URL.Year#.

Comments: #Form.RescheduleNotes#
</cfmail>
</cfif>
</cfif>

<cfelse>

<cfif Schedule.audittype is "TPTDP">
<cfif RescheduleNextYear is "Yes">
<cfmail to="Bruce.A.Mahrenholz@ul.com, James.E.Feth@ul.com" from="Internal.Quality_Audits@ul.com" subject="Audit Reschedule - #Schedule.ExternalLocation#" bcc="Internal.Quality_Audits@ul.com">
The Audit of #Schedule.ExternalLocation# (#URL.Year#-#URL.ID#) scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #NewMonth#, #NextYear# (#NextYear#-#NextYr.ID#).

Comments: #Form.RescheduleNotes#
</cfmail>
<cfelse>
<cfmail to="Bruce.A.Mahrenholz@ul.com, James.E.Feth@ul.com" from="Internal.Quality_Audits@ul.com" subject="Audit Reschedule - #Schedule.ExternalLocation#" bcc="Internal.Quality_Audits@ul.com">
The Audit of #Schedule.ExternalLocation# (#URL.Year#-#URL.ID#) scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #MonthasString(Schedule.Month)#, #URL.Year#.

Comments: #Form.RescheduleNotes#
</cfmail>
</cfif>

<cfelse>
<cfif RescheduleNextYear is "Yes">
<cfmail to="Kai.Huang@ul.com, Internal.Quality_Audits@ul.com" from="Internal.Quality_Audits@ul.com" subject="Audit Reschedule - #Schedule.OfficeName#, #Schedule.AuditArea#">
The Audit of #Schedule.Officename# (#Trim(Schedule.AuditArea)#, #URL.Year#-#URL.ID#) scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #NewMonth#, #NextYear# (#NextYear#-#NextYr.ID#).

Comments: #Form.RescheduleNotes#
</cfmail>
<cfelse>
<cfmail to="Kai.huang@ul.com, Internal.Quality_Audits@ul.com" from="Internal.Quality_Audits@ul.com" subject="Audit Reschedule - #Schedule.OfficeName#, #Schedule.AuditArea#">
The Audit of #Schedule.Officename# (#Trim(Schedule.AuditArea)#, #URL.Year#-#URL.ID#) scheduled for #OrigMonth#, #Schedule.Year# has been rescheduled to #MonthAsString(Schedule.Month)#, #URL.Year#.

Comments: #Form.RescheduleNotes#
</cfmail>
</cfif>
</cfif>
</cfif>
</cfif>

<cflocation url="auditdetails.cfm?Year=#url.Year#&ID=#url.id#" addtoken="no">
</cfif>
