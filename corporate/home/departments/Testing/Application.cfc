<cfcomponent>
<cfscript>
	this.name="IQA";
	this.scriptprotect="All";
	this.clientmanagement="Yes";
	this.loginstorage="Session";
	this.setDomainCookies="True";
	this.setClientCookies="True";
	this.sessionmanagement = "True";
	this.sessiontimeout = CreateTimespan(0,8,0,0);
	this.applicationtimeout = CreateTimespan(0,12,0,0);
</cfscript>

<cffunction name="onApplicationStart" returnType="boolean" output="false">
	<cfreturn true>
</cffunction>

<cffunction name="onApplicationEnd" returnType="void" output="false">
	<cfargument name="applicationScope" required="true">
</cffunction>

<cffunction name="onRequestStart" returnType="boolean" output="false">
	<cfargument name="thePage" type="string" required="true">
	<cfinclude template="../../environment.cfm">
	<cfset Request.DSN = "IQA">
	<cfset Request.CAR = "CAR">
	<cfset Request.GCAR = "QE">
	<cfset Request.Logs = "IQA_Log">
	<cfset DB.Name = "IQA">

    <cfset Request.RQMEULA = "Horst.Thelen@ul.com">
    <cfset Request.RQMNA = "James.R.Oates@ul.com">
    <cfset Request.RQMAP = "Thomas.Kestner@ul.com">
    <cfset Request.RQMCorporate = "Cheyl.adams@ul.com">

	<!---
    <cfset OracleDB_Username = "UL06046">
    <cfset OracleDB_Password = "UL06046">
    --->

    <cfinclude template="../SiteShared/OracleDBSchemaCredentials.cfm">

    <cfquery Datasource="Corporate" name="TAM">
    SELECT Email, Name
    FROM IQADB_Login
    WHERE AccessLevel = 'Technical Audit'
    AND Status IS NULL
    </cfquery>

    <Cfset Request.TechnicalAuditManager = #ValueList(TAM.Email, ",")#>
	<cfset Request.TechnicalAuditManagerNames = #ValueList(TAM.Name, ",")#>

	<cfset Request.TechnicalAuditManager_Formatted = #replace(Request.TechnicalAuditManager, ",", ", ", "All")#>
	<cfset Request.TechnicalAuditManagerNames_Formatted = #replace(Request.TechnicalAuditManagerNames, ",", ", ", "All")#>

    <cfset Request.TechnicalAuditMailbox = "InternalTechnicalAudits@ul.com">

	<cfset Request.ErrorMailTo = "Christopher.J.Nicastro@ul.com, Kai.Huang@ul.com">

    <!--- Yes, this is intentionally a text field --->
    <cfset Request.contacts_CancelRescheduleAudits = "Kai Huang">

	<cfset thisPath = ExpandPath("*.*")>
	<cfset path = GetDirectoryFromPath(thisPath)>
	<cfset baseDir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
	<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>

    <!--- need to be removed --->
	<cfset IQARootPath = "#request.applicationFolder#\corporate\home\departments\snk5212\IQA\">
	<cfset IQArootDir = "/departments/snk5212/IQA/">
	<cfset IQAAdminDir = "#IQArootDir#admin/">
    <cfset IQAAccredLocationsDir = "#IQAAdminDir#AccredLocations/">
   	<cfset CARRootPath = "#request.applicationFolder#\corporate\home\departments\snk5212\QE\">
	<cfset CARRootDir = "/departments/snk5212/QE/">
	<cfset CARAdminDir = "#CARrootDir#admin/">
    <!--- /// --->

	<cfinclude template="../SiteShared/incPaths.cfm">

    <cfset Request.Development = "No">

    <!--- need to be removed --->
	<cfset myurl = "#cgi.script_name#?#QUERY_STRING#">
	<cfset schedurl = "#basedir#schedule.cfm?#QUERY_STRING#">
	<cfset calurl = "#basedir#calendar.cfm?#QUERY_STRING#">
	<cfset Request.Menu = "menu.cfm">
	<cfset Request.Header = "http://#CGI.Server_Name#/header/header.js">
	<cfset Request.CSS = "http://#CGI.Server_Name##basedir#css.css">
	<cfset Request.CSS2 = "http://#CGI.Server_Name##curdir#css2.css">
	<cfset Request.ULNetCSS = "http://#CGI.Server_Name#/header/ulnetheader.css">
	<!--- /// --->

	<cfset Request.SiteTitle = "IQA">

	<cfoutput>
		<cfset CurYear = #Dateformat(now(), 'yyyy')#>
		<cfset NextYear = #CurYear# + 1>
		<cfset LastYear = #CurYear# - 1>
		<cfset CurMonth = #Dateformat(now(), 'mm')#>
		<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
		<cfset CurTime = #Timeformat(now(), 'HH:mm:ss')#>
		<cfset CurTimeDate = '#CurDate# #CurTime#'>
	</cfoutput>

	<cfset Request.IQAScope = "1. The scope of the assessment includes verifying implementation of UL Quality Management System (QMS) as described in the
	Global Quality Manual, 00-QA-P0001, if applicable, or local Quality Management System Manual. Additional functional, local, program or process
	policies/procedures will also be utilized as required. Assessment to standard requirements (Guide 65, ISO 17025, ISO 17020, ISO 17021, CAN-P-1500)
	will be utilized as applicable. Specifics on the scope of this assessment are described in Attachment A. Note: Additional logistics may be addressed
	during pre-audit communications and/or during the Opening Sessions at each location.<br>
	2. Verify the effective implementation of previously closed CARs (internal and accreditor) as well as progress on open CARs where applicable.<br>
	3. Ensure documentation and records meet applicable policies.<br>
	4. Verify that documentation released/updated since the last audit was conducted, meets applicable UL QMS requirements and the applicable revisions of
	ISO 17025, ISO 17020, Guide 65, ISO 17021 and/or CAN-P-1500 requirements.">

    <cfset Request.IQAScope2013 = "1. The scope of the assessment includes verifying implementation of UL Quality Management System (QMS) as described in the
	Global Quality Manual, 00-QA-P0001, if applicable, or local Quality Management System Manual. Additional functional, local, program or process
	policies/procedures will also be utilized as required. Assessment to standard requirements (Guide 65/ISO 17065, ISO 17025, ISO 17020, ISO 17021,
	CAN-P-1500, or equivalent standard) will be utilized as applicable. Specifics on the scope of this assessment are described in Attachment A. Note:
	Additional logistics may be addressed during pre-audit communications and/or during the Opening Sessions at each location.<Br><br>

	2. Verify the effective implementation of previously closed CARs (internal and accreditor) as well as progress on open CARs where applicable.<br><br>

	3. Verify that documentation released/updated since the last audit was conducted, meets applicable Quality Management System requirements and the
	applicable revisions of ISO 17025, 	ISO 17020, Guide 65/ISO 17065, ISO 17021, CAN-P-1500 requirements or equivalent standard.<br><br>

	4. Ensure documentation and records meet Quality Management System requirements.<br><br>

	5. The facility's Environmental Health and Safety will be reviewed according to 00-SF-P0031 per approved audit plan, if applicable.">

    <cfset Request.IQAScope2015 = "1. The scope of the assessment includes verifying implementation of UL Quality Management System (QMS) as described in the
	Global Quality Manual, 00-QA-P0001, if applicable, or local Quality Management System Manual. Additional functional, local, scheme/program or process
	policies/procedures will also be utilized as required. Assessment to standard requirements (Guide 65, ISO 17065, ISO 17025, ISO 17020, ISO 17021, ISO 9001,
	CAN-P-1500, CAN-P-1608 or equivalent standard) will be utilized as applicable. Specifics on the scope of this assessment are described in Attachment A.<br><br>

	Note: Additional logistics may be addressed during pre-audit communications and/or during the Opening Sessions at each location.<Br><br>

	2. Verify the effective implementation of previously closed CARs (internal and accreditor) as well as progress on open CARs where applicable.<br><br>

	3. Verify that documentation released/updated since the last audit was conducted, meets applicable Quality Management System/Scheme requirements and the
	applicable revisions of Guide 65, ISO 17065, ISO 17025, ISO 17020, ISO 17021, ISO 9001, CAN-P-1500, CAN-P-1608 or equivalent standard.<br><br>

	4. Ensure documentation and records meet Quality Management System/Scheme requirements.<br><br>

	5. The facility's Environmental Health and Safety will be reviewed according to 00-SF-P0031 per approved audit plan, if applicable.">

    <cfset Request.IQAScope2016 = "1. The scope of the assessment includes verifying implementation of UL Quality Management System (QMS) as described in the Global Quality Manual, 00-QA-P0001, if applicable, or local Quality Management System Manual. Additional functional, local, scheme/program or process policies/procedures will also be utilized as required. Assessment to standard requirements (ISO/IEC 17065, ISO/IEC 17025, ISO/IEC 17020, ISO/IEC 17021, ISO 9001, SCC Requirements and Guidance � Product, Process, and Service Certification Body Accreditation Program, SCC Requirements and Guidance - Inspection Body and Accreditation Program, or equivalent standard) will be utilized as applicable. Specifics on the scope of this assessment are described in Attachment A.<Br><br>

	Note: Additional logistics may be addressed during pre-audit communications and/or during the Opening Sessions at each location.<Br><br>

	2. Verify the effective implementation of previously closed CARs (internal and accreditor) as well as progress on open CARs where applicable.<Br><br>

	3. Verify that documentation released/updated since the last audit was conducted, meets applicable Quality Management System/Scheme requirements and the applicable revisions of ISO/IEC 17065, ISO/IEC 17025, ISO/IEC17020, ISO/IEC 17021, ISO 9001, SCC Requirements and Guidance � Product, Process, and Service Certification Body Accreditation program, SCC Requirements and Guidance - Inspection Body and Accreditation Program, or equivalent standard.<Br><br>

	4. Ensure documentation and records meet Quality Management System/Scheme requirements.<Br><br>

	5. The facility's Environmental Health and Safety will be reviewed according to 00-SF-P0031 per approved audit plan, if applicable.">

	<cfset Request.IQAScope_LocalOrLab = "1. The scope of the assessment includes verifying implementation of  UL's Quality Management System as described in the
	Global Quality Manaual, 00-QA-P0001.  Additional functional, local and or program policies/procedures will also be utilized.  Specifics on the scope
	of this assessment are described in Attachment A. These logistics will be addressed during pre-audit communications and/or during the Opening Sessions
	at each location.<br>
	2. Verify the effective implementation of previously closed CARs (internal and accreditor).<br>
	3. Review any progress on open CARs.<br>
	4. Ensure that documents used are under the document control system.<br>
	5. Verify that documentation released since the last audit was
	conducted, meets the applicable UL and ISO 17025 requirements.<br>
	6. See specific scope letter for additional details.">

	<cfset Request.MMSScope = "1. The scope of the assessment includes verifying implementation of UL's Quality Management System as described in the Global Quality Manual, 00-QA-P0001. Additional functional, local and or MMS program policies/procedures will also be utilized. Specifics on the scope of this assessment are described in Attachment A. These logistics will be addressed during pre-audit communications and/or during the Opening Session.<br>
	2. Verify the effective implementation of previously closed CARs (internal and accreditor).<br>
	3. Review progress on open CARs.<br>
	4. Verify that documentation released since the last audit was conducted, meets the applicable UL and ISO 17021 requirements and the applicable requirements in the accreditation documents.<br>
	5. Review the policy/program manual against the applicable standard requirements for compliance to ISO 17021 and the applicable accreditation documents.<br>
	6. Review the policy/program manual against the UL Global Quality Manual requirements.<br>
	7. Review the SOP(s) against the UL policy/Global Quality Manual for compliance:<br>
	&nbsp; &nbsp; a. Review any local docs to see if there are conflicts,<br>
	&nbsp; &nbsp; b. Ensure record retention, location, etc is defined in all SOP's.<br>
	8. Ensure necessary stakeholders have approved the document.<br>
	9. Ensure the document meets the two year review &amp; other document control procedure requirements.<br>
	10. See specific scope letter for additional details.">

	<cfset Request.IQAFSScope = "1. Review the policy/program manual against the applicable standard requirements for compliance (ISO 17025, Guide 65, etc)<Br>
	2. Review the policy/program manual against the Global Quality Manual requirements.<Br>
	3. Review the SOP(s) against the UL policy/Global Quality Manual for compliance<br>
	&nbsp;&nbsp; 3a.Review any local docs to see if there are conflicts<br>
	&nbsp;&nbsp; 3b Ensure record retention, location, etc is defined in all SOP's<br>
	4. Ensure necessary stakeholders have approved the document<br>
	5. Ensure the document meets the 2 year review & other document control policy/procedure requirements">

<cfif NOT isDefined("SESSION.Auth.IsLoggedIn")>
	<cfif curdir EQ IQAAdminDir OR curdir EQ IQAAccredLocationsDir>
		<cfif cgi.PATH_INFO NEQ "#IQAAdminDir#global_login.cfm"
			AND cgi.PATH_INFO NEQ "#IQAAdminDir#global_login_new.cfm"
			AND cgi.Path_INFO NEQ "#IQAAdminDir#global_login_test.cfm">
				<cflocation url="#IQAAdminDir#global_login.cfm" ADDTOKEN="No">
		</cfif>
	</cfif>
</cfif>

	<cfif IsDefined("Cookie.CFID") AND IsDefined("Cookie.CFTOKEN")>
	    <cfset Variables.cfid_local = Cookie.CFID>
	    <cfset Variables.cftoken_local = Cookie.CFTOKEN>
	    <cfcookie name="CFID" value="#Variables.cfid_local#">
	    <cfcookie name="CFTOKEN" value="#Variables.cftoken_local#">
	</cfif>

	<cfreturn true>
</cffunction>

<cffunction name="onRequest" returnType="void">
	<cfargument name="thePage" type="string" required="true">
	<cfinclude template="#arguments.thePage#">
</cffunction>

<cffunction name="onRequestEnd" returnType="void" output="true">
	<cfargument name="thePage" type="string" required="true">
	<cfinclude template="incViews.cfm">
</cffunction>

<cffunction name="onError" returntype="void" ouput="true">
	<cfargument name="exception" required="yes">
    <cfargument name="eventName" type="string" required="yes">

    <cfinclude template="error_handler.cfm">
    <!---<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">--->
</cffunction>

<cffunction name="onSessionStart" returnType="void" output="false">

</cffunction>

<cffunction name="onSessionEnd" returnType="void" output="false">
	<cfargument name="sessionScope" type="struct" required="true">
	<cfargument name="applicationScope" type="struct" required="false">
</cffunction>

</cfcomponent>