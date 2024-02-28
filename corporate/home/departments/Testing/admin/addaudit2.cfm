<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add Audit - #Form.AuditedBy# / #form.AuditType2#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<cfif isDefined("Form.StartDate") AND isDefined("Form.EndDate")>
	<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>
</cfif>

<!---
<cfif audittype is "TPTDP">
<CFQUERY Datasource="Corporate" Name="CheckBillable">
SELECT * FROM ExternalLocation
WHERE ExternalLocation = '#FORM.e_ExternalLocation#'
</CFQUERY>
</cfif>
--->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="addguid">
SELECT MAX(xGUID) + 1 AS xy FROM AuditSchedule
</CFQUERY>

<CFQUERY Datasource="Corporate" Name="CheckYear">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year FROM AuditSchedule
WHERE YEAR_ = #FORM.e_Year#
</CFQUERY>

<cfif CheckYear.recordcount is 0>
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
    INSERT INTO AuditSchedule(ID, Year_, AuditedBy, xGUID)
    VALUES (1, #Form.E_Year#, '#Form.AuditedBy#', #addGUID.xy#)
    </CFQUERY>
<cfelse>
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
    SELECT MAX(ID) + 1 AS newid FROM AuditSchedule
    WHERE Year_ = #FORM.E_Year#
    </CFQUERY>

    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
    INSERT INTO AuditSchedule(ID, Year_, AuditedBy, xGUID)
    VALUES (#Query.newid#, #FORM.E_Year#, '#Form.AuditedBy#', #addGUID.xy#)
    </CFQUERY>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET

<cfif form.audittype2 is "Local Function CBTL">
	Area='Processes, Labs, and CBTL',
</cfif>

<cfif form.audittype2 NEQ "Field Services">
	<cfif Form.Desk is "1">
    	Desk='Yes',
    <cfelse>
    	Desk='No',
    </cfif>
<cfelse>
	Desk='No',
</cfif>

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

<cfif Form.AuditedBy eq "IQA">
AuditDays = #Form.e_AuditDays#,

	<cfif Form.SME EQ "- None -">
	SME = null,
	<cfelse>
	SME = '#FORM.SME#',
	</cfif>
</cfif>

<!---
<cfif Form.AuditType is "TPTDP">
ExternalLocation='#FORM.e_ExternalLocation#',
	<cfif CheckBillable.Billable is "1">
	Billable='Yes',
	<cfelse>
	Billable='No',
	</cfif>
<cfelse>
--->
AuditArea='#Form.e_AuditArea#',

<cfif Form.e_AuditArea eq "Certification Body (CB) Audit">
	Area='Processes',
</cfif>

<cfif form.auditedby eq "IQA">
	<cfif form.audittype2 is "Local Function"
			OR form.audittype2 is "Program"
			OR form.audittype2 is "Scheme Documentation Audit"
			OR form.audittype2 is "MMS - Medical Management Systems">
    BusinessUnit='#Form.BusinessUnit#',
    </cfif>
</cfif>

<cfif Form.AuditType2 is "Field Services">
	OfficeName='#FORM.e_FUS#',
	Area=null,
<cfelseif form.audittype2 NEQ "Program" AND form.audittype2 NEQ "Scheme Documentation Audit">
	OfficeName='#FORM.OfficeName#',
</cfif>

Email=<cfif NOT len(Form.e_Email)>null,<cfelse>'#Form.e_Email#',</cfif>
Email2=<cfif NOT len(Form.Email2)>null,<cfelse>'#Form.Email2#',</cfif>

<!--- removed for 2010. no longer used.
<cfif Form.RD NEQ "- None -" AND Form.RD NEQ "">
RD='#FORM.RD#',
</cfif>
--->

<!---
<cfif Form.KP NEQ "- None -" AND Form.KP NEQ "">
KP='#FORM.KP#',
</cfif>
--->

<!---</cfif>--->

<cflock scope="SESSION" timeout="60">
Scheduler='<u>Username:</u> #SESSION.AUTH.USERNAME# (#SESSION.AUTH.NAME#)<br><u>Time:</u> #CurTimeDate#',
LeadAuditor='#FORM.e_LeadAuditor#',
Auditor='#FORM.Auditor#',
AuditorInTraining='#Form.AuditorInTraining#',

Auditor_ChangeLog = 'Added by #SESSION.Auth.Username# on #curdate#<Br />Lead Auditor = #FORM.e_LeadAuditor#<br />Auditor = <cfif len(Form.Auditor)>#FORM.Auditor#<cfelse>None</cfif><br />AuditorInTraining = <cfif len(Form.AuditorInTraining)>#Form.AuditorInTraining#<cfelse>None</cfif><br /><br />',
</cflock>

<!--- scopes are gathered from the REQUEST scope - stored in the application.cfc file --->
<cfif form.e_Year GT 2014>
	<cfset Scope = "#Request.IQAScope2015#">
<cfelse>
	<cfif form.audittype2 is "Field Services">
		<cfset scope = "#Request.IQAFSScope#">
	<cfelseif form.AuditType2 EQ "MMS - Medical Management Systems">
		<cfset Scope = "#Request.MMSScope#">
	<cfelse>
		<cfif form.e_year lte 2012>
		   	<cfset Scope = "#Request.IQAScope#">
		<cfelse>
	    	<cfset Scope = "#Request.IQAScope2013#">
	    </cfif>
	</cfif>
</cfif>

<!--- scope for above cases above --->
Scope = '#Scope#',
Approved='No',
Notes='#form.Notes#',
AuditType='#FORM.AuditType#',
AuditType2='#FORM.AuditType2#'

WHERE
<cfif CheckYear.recordcount is 0>
	ID=1
<cfelse>
	ID=#Query.newid#
</cfif>

AND Year_ = #FORM.E_Year#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year
FROM AuditSchedule
WHERE
<cfif CheckYear.recordcount is 0>
	ID=1
<cfelse>
	ID=#Query.newid#
</cfif>

AND Year_ = #form.E_Year#
</CFQUERY>

<cfif ScheduleEdit.audittype2 is "Technical Assessment"
	or ScheduleEdit.audittype is "TPTDP"
	or ScheduleEdit.audittype2 is "Local Function CBTL"
	or ScheduleEdit.audittype2 is "Field Services"
	or ScheduleEdit.audittype2 is "Lab Scope Review"
	or form.e_AuditArea is "Certification Body (CB) Audit">
	<cflocation url="addaudit_review.cfm?Year=#ScheduleEdit.Year#&ID=#ScheduleEdit.ID#" addtoken="no">
</cfif>

<cfif ScheduleEdit.audittype2 is "MMS - Medical Management Systems">
	<CFQUERY BLOCKFACTOR="100" name="Areas" Datasource="Corporate">
	SELECT DISTINCT Area FROM AuditSchedule
	WHERE AuditType2 = 'MMS - Medical Management Systems'
	AND AuditedBy = 'IQA'
	AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
	Order By Area
	</CFQUERY>
</cfif>

<CFQUERY name="Programs" Datasource="Corporate">
SELECT Type, IQA, Program, ID
FROM ProgDev
WHERE IQA = 1
ORDER BY Type, Program
</CFQUERY>

<!---
<CFQUERY Name="SBU" Datasource="Corporate">
SELECT * From SBU
Order BY SBU
</CFQUERY>
--->

<CFQUERY Name="LocalFunctions" Datasource="Corporate">
SELECT * From LocalFunctions
Order BY Function
</CFQUERY>

<CFQUERY Name="GlobalFunctions" Datasource="Corporate">
SELECT * From GlobalFunctions
WHERE Status IS NULL
Order BY Function
</CFQUERY>

<!---
<CFQUERY Name="CorporateFunctions" Datasource="Corporate">
SELECT * From CorporateFunctions
Order BY Function
</CFQUERY>
--->

<!---
<cfif Form.AuditType2 is "Field Services">
    <CFQUERY Name="FUS" Datasource="Corporate">
    SELECT * FROM FUSLocations, FUSAreas
    WHERE FUSLocations.Location = '#FORM.e_FUS#'
    AND FUSAreas.LocationID = FUSLocations.ID
    </CFQUERY>
</cfif>
--->

<CFQUERY Name="Office" Datasource="Corporate">
SELECT ID, OfficeName From IQAtblOffices
WHERE OfficeName = '#ScheduleEdit.OfficeName#'
</CFQUERY>

<cfquery Datasource="Corporate" name="Labs">
SELECT * from IQAOffices_Areas
WHERE ID = '#Office.ID#'
AND IQA = 1
ORDER BY LAB
</CFQUERY>

<br>
<div align="Left" class="blog-time">
Schedule/Edit an Audit Help - <A HREF="javascript:popUp('#IQARootDir#webhelp/webhelp_scheduleaudit.cfm')">[?]</A>
</div><br>

<cfoutput query="ScheduleEdit">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="addaudit_review.cfm?Year=#ScheduleEdit.Year#&ID=#ScheduleEdit.ID#">
#AuditType2#<br>
</cfoutput>

<cfif ScheduleEdit.audittype2 is "Program" OR form.audittype2 is "Scheme Documentation Audit">
	<SELECT NAME="e_Area" displayname="Program">
		<OPTION VALUE="">Select Program Below
		<OPTION Value="">---
		<CFOUTPUT QUERY="Programs">
			<OPTION VALUE="#ID#"> - (#type#) #Program#
		</cfoutput>
	</SELECT>

<cfelseif ScheduleEdit.audittype2 is "MMS - Medical Management Systems">
	<SELECT NAME="e_Area" displayname="MMS Audit Area">
		<OPTION VALUE="">Select Audit Area Below
		<OPTION Value="">---
		<CFOUTPUT QUERY="Areas">
			<OPTION VALUE="#Area#"> - #Area#
		</cfoutput>
	</SELECT>

<cfelseif ScheduleEdit.audittype2 is "Global Function/Process">
	<SELECT NAME="e_Area" displayname="Global Function/Process">
		<OPTION VALUE="">Global Function/Processs - Choose Below
		<OPTION VALUE="">---
		<CFOUTPUT QUERY="GlobalFunctions">
			<OPTION VALUE="#Function#"> - #Function#
		</CFOUTPUT>
	</SELECT>

<cfelseif ScheduleEdit.audittype2 is "Corporate">
	<SELECT NAME="e_Area" displayname="Corporate Functions">
		<OPTION VALUE="">Corporate Functions - Choose Below
		<OPTION VALUE="">---
		<CFOUTPUT QUERY="CorporateFunctions">
			<OPTION VALUE="#Function#"> - #Function#
		</CFOUTPUT>
	</SELECT>

<cfelseif ScheduleEdit.auditType2 is "Local Function FS">
	<SELECT NAME="e_Area" displayname="Program">
		<OPTION VALUE="">Local Function FS - Choose below
		<OPTION VALUE="">---
		<OPTION VALUE="Processes including Field Services">Processes including Field Services
		<OPTION VALUE="Processes and Labs including Field Services">Processes and Labs including Field Services
	</SELECT>

<cfelseif ScheduleEdit.audittype2 is "Local Function">
	<SELECT NAME="e_Area" displayname="Program">
		<OPTION VALUE="">Local Functions - Choose Below
		<OPTION VALUE="">---
		<CFOUTPUT QUERY="LocalFunctions">
			<OPTION VALUE="#Function#"> - #Function#
		</CFOUTPUT>

	<!---
		<OPTION VALUE="">
		<OPTION Value="">Strategic Business Units - Choose Below
		<OPTION VALUE="">---
		<CFOUTPUT QUERY="SBU">
			<OPTION VALUE="#SBU#"> - #SBU#
		</CFOUTPUT>
	--->

		<OPTION VALUE="">
		<OPTION VALUE="">Laboratories - Choose Below
		<OPTION VALUE="">---
		<CFOUTPUT QUERY="Labs">
			<OPTION VALUE="#Lab#"> - #Lab#
		</CFOUTPUT>
	</SELECT><br /><br />

<!---
<Cfif ScheduleEdit.Year_ GTE 2012>
	<cfif ScheduleEdit.AuditType2 is "Local Function">
		<b>Initial Audit of the Site?</b><br />
		Yes <input type="Radio" Name="InitialSiteAudit" Value="1"> No <INPUT TYPE="Radio" NAME="InitialSiteAudit" value="0" checked>
		<br /><Br />
	</cfif>
</cfif>
--->
<cfelseif ScheduleEdit.audittype2 is "Field Services">
	<SELECT NAME="e_Area" displayname="Program">
		<OPTION VALUE="">Field Services Areas/Locations - Choose Below
		<OPTION VALUE="">---
		<CFOUTPUT QUERY="Fus">
			<OPTION VALUE="#Area#"> - #Area#
		</CFOUTPUT>
	</SELECT>
</cfif>
<br /><br />

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->