<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Edit Audit - #URL.Year#-#URL.ID#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<cfif isDefined("Form.StartDate") AND isDefined("Form.EndDate")>
	<cfset CompareDate = Compare(FORM.StartDate, FORM.EndDate)>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year
FROM AuditSchedule
WHERE ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

<cfset Orig.Lead = "#ScheduleEdit.LeadAuditor#">
<cfset Orig.Auditor = "#ScheduleEdit.Auditor#">
<cfset Orig.InTraining = "#ScheduleEdit.AuditorInTraining#">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET

<cfif URL.AuditedBy is "IQA">
	<cfif len(Form.BusinessUnit)>
	    BusinessUnit='#Form.BusinessUnit#',
	<cfelse>
		BusinessUnit='None Listed',
	</cfif>
</cfif>

<cfif ScheduleEdit.audittype2 is NOT "Field Services">
	<cfif Form.Desk is "Yes">
		Desk='Yes',
	<cfelse>
		Desk='No',
	</cfif>
<cfelse>
	Desk='No',
</cfif>

<!---<cfif scheduleedit.AuditType is NOT "TPTDP">--->
<cflock scope="SESSION" timeout="60">
	<cfif SESSION.Auth.Username eq "Chris"
		OR SESSION.Auth.Username eq "Huang"
		OR SESSION.Auth.Username eq "Echols"
		OR ScheduleEdit.AuditType2 is "Field Services">
	AuditArea='#FORM.AuditArea#',
	</cfif>
</cflock>

Email=<cfif NOT len(Form.Email)>null<cfelseif Form.Email eq " ">null<cfelse>'#Form.Email#'</cfif>,
Email2=<cfif NOT len(Form.Email2)>null<cfelseif Form.Email2 eq " ">null<cfelse>'#Form.Email2#'</cfif>,
<cfif scheduleedit.year gte 2006 AND scheduleedit.audittype is "Quality System">
	<cfif scheduleedit.audittype2 is "NoChanges" or scheduleedit.audittype2 is "Field Services">
	<cfelse>
		AuditType2='#FORM.AuditType2#',
	</cfif>
</cfif>
<!---
</cfif>
--->

<!---
<cfif form.RD NEQ "NoChanges">
	RD='#FORM.RD#',
</cfif>
--->

<cfif link is "http://#CGI.Server_Name##IQAAdminDir#edit_initial.cfm?ID=#URL.ID#&Year=#URL.YEAR#&AuditedBy=#URL.AuditedBy#" or ScheduleEdit.AuditType2 is "Field Services">
	<cfif form.officename NEQ "NoChanges">
		<cfif scheduleedit.audittype2 is "Field Services">
			OfficeName='#Form.OfficeName#',
			Area=null,
		<cfelse>
			OfficeName='#FORM.Officename#',
		</cfif>
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
</cfif>

<cfif ScheduleEdit.AuditedBy eq "IQA" AND ScheduleEdit.Year_ GTE 2015>
	<cfif form.AuditDays NEQ "NoChanges">
		AuditDays = #Form.AuditDays#,
	</cfif>

	<cfif Form.SME EQ "- None -">
		SME = null,
	<cfelse>
		<cfif form.SME NEQ "NoChanges">
			SME = '#FORM.SME#',
		</cfif>
	</cfif>
</cfif>

<cfif URL.Year LTE 2012>
	<cfif form.KP NEQ "NoChanges">
        KP='#FORM.KP#',
    </cfif>
</cfif>

<!---
<cfelse>
</cfif>
--->

<cfif form.LeadAuditor NEQ "NoChanges">
	LeadAuditor='#FORM.LeadAuditor#',
</cfif>

<cfif form.Auditor NEQ "NoChanges">
	Auditor='#FORM.Auditor#',
</cfif>

<cfif form.AuditorInTraining NEQ "NoChanges">
	AuditorInTraining='#FORM.AuditorInTraining#',
</cfif>

<cflock scope="SESSION" timeout="60">
	<cfif len(ScheduleEdit.Auditor_ChangeLog)>
    	<!---#ScheduleEdit.Auditor_ChangeLog#--->
		<cfset existingText = "#ScheduleEdit.Auditor_ChangeLog#<br><br>">
	<Cfelse>
		<cfset existingText = "">
	</cfif>

	<cfif form.LeadAuditor NEQ "#Orig.Lead#" AND form.LeadAuditor NEQ "NoChanges">
    	<!---Lead Auditor = #FORM.LeadAuditor#<br />--->
        <cfset leadmsg = "Lead Auditor = #FORM.LeadAuditor#<br />">
		<cfset LeadChange = "Yes">
    <cfelse>
    	<!---Lead Auditor = Not Changed (#Orig.Lead#)<br />--->
		<cfset leadmsg = "Not Changed (#Orig.Lead#)<br />">
        <cfset LeadChange = "No">
    </cfif>

	<cfif form.Auditor NEQ "#Orig.Auditor#" AND Form.Auditor NEQ "NoChanges">
    	<!---Auditor = #FORM.Auditor#<br />--->
        <cfset auditorMsg = "Auditor = #FORM.Auditor#<br />">
		<cfset AuditorChange = "Yes">
    <cfelse>
    	<!---Auditor = Not Changed (#Orig.Auditor#)<br />--->
        <Cfset auditorMsg = "Auditor = Not Changed (#Orig.Auditor#)<br />">
		<cfset AuditorChange = "No">
	</cfif>

	<cfif form.AuditorInTraining NEQ "#Orig.InTraining#" AND Form.AuditorInTraining NEQ "NoChanges">
    	<!---Auditor In Training = #Orig.InTraining#<br />--->
		<cfset trainingMsg = "Auditor In Training = #Orig.InTraining#<br />">
        <cfset InTrainingChange = "Yes">
    <cfelse>
    	<!---Auditor In Training = Not Changed (#Orig.InTraining#)<br />--->
        <cfset trainingMsg = "Auditor In Training = Not Changed (#Orig.InTraining#)<br />">
		<cfset InTrainingChange = "No">
	</cfif>

Auditor_ChangeLog =
<cfqueryparam value="#existingText#Edits made on #curdate# #curtime# by #SESSION.Auth.UserName#<br />#leadMsg##auditorMsg##trainingMsg#"
	CFSQLTYPE="cf_sql_clob">,
</cflock>

<!---Scope='#form.scope#',--->
Notes=<cfqueryparam value="#form.notes#" CFSQLTYPE="cf_sql_clob">

WHERE ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

<!--- emails if audit team has changed --->
<cfif LeadChange eq "Yes" OR AuditorChange eq "Yes" OR InTrainingChange eq "Yes">
    <cfif ScheduleEdit.Approved eq "Yes" AND ScheduleEdit.AuditedBy eq "IQA">

	<Cfset AuditorBeforeEmails = "">

	<!--- add lead auditor field email --->
    <cfif len(ScheduleEdit.LeadAuditor)>
        <cfloop index = "ListElement" list = "#ScheduleEdit.LeadAuditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorBeforeEmails = listAppend(AuditorBeforeEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor field emails --->
    <cfif len(ScheduleEdit.Auditor)>
        <cfloop index = "ListElement" list = "#ScheduleEdit.Auditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorBeforeEmails = listAppend(AuditorBeforeEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor in training field emails --->
    <cfif len(ScheduleEdit.AuditorInTraining)>
        <cfloop index = "ListElement" list = "#ScheduleEdit.AuditorInTraining#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorBeforeEmails = listAppend(AuditorBeforeEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    <!--- /// --->

    <CFQUERY BLOCKFACTOR="100" name="ScheduleEdit" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year, AuditType2, OfficeName, Area, AuditArea
    FROM AuditSchedule
    WHERE ID = <cfqueryparam value="#url.ID#" CFSQLTYPE="CF_SQL_INTEGER">
    AND Year_ = <cfqueryparam value="#url.Year#" CFSQLTYPE="CF_SQL_INTEGER">
    </CFQUERY>

	<Cfset AuditorAfterEmails = "">

	<!--- add lead auditor field email --->
    <cfif len(ScheduleEdit.LeadAuditor)>
        <cfloop index = "ListElement" list = "#ScheduleEdit.LeadAuditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorAfterEmails = listAppend(AuditorAfterEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor field emails --->
    <cfif len(ScheduleEdit.Auditor)>
        <cfloop index = "ListElement" list = "#ScheduleEdit.Auditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorAfterEmails = listAppend(AuditorAfterEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor in training field emails --->
    <cfif len(ScheduleEdit.AuditorInTraining)>
        <cfloop index = "ListElement" list = "#ScheduleEdit.AuditorInTraining#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset AuditorAfterEmails = listAppend(AuditorAfterEmails, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    <!--- /// --->

        <cfmail
            to="#AuditorBeforeEmails#, #AuditorAfterEmails#"
            from="Internal.Quality_Audits@ul.com"
            subject="#URL.Year#-#URL.ID#-IQA - Audit Team Changes"
            query="ScheduleEdit"
            type="html">
        The audit team has changed for this audit. You are being sent this notification because you are part of the audit team.<br /><br />

		Audit Details:<br>
		Audit Type:
		<cfif auditArea IS "Certification Body (CB) Audit">
			Certification Body (CB) Audit
		<cfelseif AuditArea eq "Scheme Documentation Audit">
			Scheme Documentation Audit
		<cfelseif AuditArea eq "Certification Body Operations">
			Certification Body (CB) Audit
		<cfelse>
			#AuditType2#
		</cfif><br>
		Area: #Area#<Br>
		OfficeName: #OfficeName#<br><br>

        Changes:<Br /><br>
        <cfif LeadChange eq "Yes">
        Lead Auditor<br>
		Changed From: <cfif len(Orig.Lead)>#Orig.Lead#<cfelse>No Lead Auditor Listed</cfif><br>
		To: #LeadAuditor#<br /><Br>
        </cfif>

        <cfif AuditorChange eq "yes">
        Auditor(s)<br>
		Changed From: <cfif len(Orig.Auditor)>#Orig.Auditor#<cfelse>No Auditor(s) Listed</cfif><br>
		To: #replace(Auditor,",", "<br>", "All")#<br /><br>
        </cfif>

        <cfif InTrainingChange eq "yes">
        Auditor(s) In Training<br>
		Changed From: <cfif len(#Orig.InTraining#)>#Orig.InTraining#<cfelse>No Auditor(s) In Training Listed</cfif><Br>
		To: #replace(AuditorInTraining,",", "<br>", "All")#<br /><Br>
        </cfif>

        If you believe there is an error in the changes, please contact #LeadAuditor# (Lead Auditor) or Global Internal Quality.<Br /><br />

        <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/AuditDetails.cfm?ID=#ID#&Year=#Year_#">Audit Details</a>
        </cfmail>
    </cfif>
</cfif>
<!--- /// --->

<CFQUERY name="Programs" Datasource="Corporate">
SELECT Type, IQA, Program
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

<CFQUERY Name="CorporateFunctions" Datasource="Corporate">
SELECT * From CorporateFunctions
Order BY Function
</CFQUERY>

<!---
<cfif scheduleedit.AuditType2 is "Field Services">
    <CFQUERY Name="FUS" Datasource="Corporate">
    SELECT * FROM FUSAreas
    WHERE FUSLocations.Location = '#scheduleedit.OfficeName#'
    AND FUSAreas.LocationID = FUSLocations.ID
    </CFQUERY>
</cfif>
--->

<CFQUERY Name="Office" Datasource="Corporate">
SELECT ID, OfficeName
FROM IQAtblOffices
WHERE OfficeName = '#ScheduleEdit.OfficeName#'
</CFQUERY>

<cfquery Datasource="Corporate" name="Labs">
SELECT * from IQAOffices_Areas
WHERE ID = '#Office.ID#'
AND IQA = 1
ORDER BY LAB
</CFQUERY>

<cfoutput query="ScheduleEdit">
<cfif scheduleedit.audittype2 is "Technical Assessment"
	or scheduleedit.audittype is "TPTDP"
	or scheduleedit.year lte 2005
	or scheduleedit.audittype2 is "Local Function CBTL"
	or scheduleedit.audittype2 is "Program"
	or scheduleedit.audittype2 is "Scheme Documentation Audit"
	or scheduleedit.audittype2 is "Field Services"
	or scheduleedit.audittype2 is "MMS - Medical Management Systems"
	or scheduleedit.audittype2 is "Global Function/Process"
	or scheduleedit.audittype2 is "Corporate">
	<cflocation url="update.cfm?Year=#URL.YEAR#&ID=#URL.ID#" ADDTOKEN="No">
</cfif>
</cfoutput>

<div class="blog-time">
Schedule/Edit an Audit Help - <A HREF="javascript:popUp('#IQARootDir#webhelp/webhelp_scheduleaudit.cfm')">[?]</A></div><br />

<cfoutput query="ScheduleEdit">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="update.cfm?Year=#URL.Year#&ID=#URL.ID#">
<b>Location</b>: #officename#<br />
<b>Audit Type</b>: #audittype2#<br />
<b>Audit Area</b>: #area#<br><br />
</cfoutput>

<!---
<cfif scheduleedit.audittype2 is "Program" OR scheduleedit.audittype2 is "Scheme Documentation Audit">

Select Program Name:<br />
<SELECT NAME="e_Area" displayname="Program Name">
		<OPTION VALUE="">Programs - Choose Below
		<OPTION Value="">---
<cfoutput query="ScheduleEdit">
		<Option Value="NoChanges" selected>#Area#
</cfoutput>
		<OPTION Value="">---
<CFOUTPUT QUERY="Programs">
		<OPTION VALUE="#Program#"> -(#type#)  #Program#
</CFOUTPUT>
</SELECT>

<cfelseif scheduleedit.audittype2 is "Global Function/Process">

Select Global Function/Process:<br />
<SELECT NAME="e_Area" displayname="Global Function/Process">
		<OPTION VALUE="">Global Function/Processs - Choose Below
		<OPTION VALUE="">---
<cfoutput query="ScheduleEdit">
		<Option Value="NoChanges" selected>#Area#
</cfoutput>
		<OPTION Value="">---
<CFOUTPUT QUERY="GlobalFunctions">
		<OPTION VALUE="#Function#"> - #Function#
</CFOUTPUT>
</SELECT>

<cfelseif scheduleedit.audittype2 is "Corporate">

Select Corporate Function/Process:<br />
<SELECT NAME="e_Area" displayname="Program Name">
		<OPTION Value="">Corporate Functions - Choose Below
		<OPTION Value="">---
<cfoutput query="ScheduleEdit">
		<Option Value="NoChanges" selected>#Area#
</cfoutput>
		<OPTION Value="">---
<CFOUTPUT QUERY="CorporateFunctions">
		<OPTION VALUE="#Function#"> - #Function#
</CFOUTPUT>
</SELECT>
--->

<cfif scheduleedit.audittype2 is "Local Function FS">

Select Audit Area:<br />
<SELECT NAME="e_Area" displayname="Program Name">
		<OPTION VALUE="">Local Function FS - Choose below
		<OPTION Value="">---
<cfoutput query="ScheduleEdit">
		<Option Value="NoChanges" selected>#Area#
</cfoutput>
		<OPTION Value="">---
		<OPTION VALUE="Processes including Field Services">Processes including Field Services
		<OPTION VALUE="Processes and Labs including Field Services">Processes and Labs including Field Services
</SELECT>

<cfelseif scheduleedit.audittype2 is "Local Function">

Select Audit Area:<br />
<SELECT NAME="e_Area" displayname="Program Name" multiple="multiple" size="10">
		<OPTION VALUE="">Local Functions - Choose Below
		<OPTION Value="">---
<cfoutput query="ScheduleEdit">
		<Option Value="NoChanges" selected>#Area#
</cfoutput>
		<OPTION Value="">---
<CFOUTPUT QUERY="LocalFunctions">
		<OPTION VALUE="#Function#"> - #Function#
</CFOUTPUT>
<!---
		<OPTION VALUE="">
		<OPTION Value="">Strategic Business Units - Bhoose Below
		<OPTION Value="">---
<CFOUTPUT QUERY="SBU">
		<OPTION VALUE="#SBU#"> - #SBU#
</CFOUTPUT>
--->
		<OPTION VALUE="">
		<OPTION VALUE="">Laboratories/Areas - Choose Below
		<OPTION Value="">---
<CFOUTPUT QUERY="Labs">
		<OPTION VALUE="#Lab#"> - #Lab#
</CFOUTPUT>
</SELECT>

<cfelseif scheduleedit.audittype2 is "Field Services">

Select Field Service Area/Location:<br />
<SELECT NAME="e_Area" displayname="Program Name">
		<OPTION VALUE="">Field Services Areas/Locations - Choose Below
		<OPTION Value="">---
<cfoutput query="ScheduleEdit">
		<Option Value="NoChanges" selected>#Area#
</cfoutput>
		<OPTION Value="">---
<CFOUTPUT QUERY="FUS">
		<OPTION VALUE="#Area#"> - #Area#
</CFOUTPUT>
</SELECT>

</cfif>

<br /><br />
<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->