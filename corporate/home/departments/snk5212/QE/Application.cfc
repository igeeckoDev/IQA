<cfcomponent>
<cfscript>
	this.name="QE";
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
	<cfset Request.DSN = "CAR">
	<cfset Request.IQA = "IQA">
	<cfset Request.GCAR = "QE">
	<cfset Request.Logs = "IQA_Log">
	<cfset DB.Name = "IQA">

	<!---
    <cfset OracleDB_Username = "UL06046">
    <cfset OracleDB_Password = "UL06046">
    --->

    <cfinclude template="../SiteShared/OracleDBSchemaCredentials.cfm">

    <cfset Request.ErrorMailTo = "Christopher.J.Nicastro@ul.com, Kai.Huang@ul.com">
    <cfset Request.AlertEmail = "global.internalquality@ul.com">

	<cfset thisPath = ExpandPath("*.*")>
	<cfset path = GetDirectoryFromPath(thisPath)>
	<cfset baseDir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
	<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>

	<cfset CARRootPath = "#request.applicationFolder#\corporate\home\departments\snk5212\QE\">
	<cfset CARRootDir = "/departments/snk5212/QE/">
	<cfset CARAdminDir = "#CARrootDir#admin/">

	<cfset IQARootPath = "#request.applicationFolder#\corporate\home\departments\snk5212\IQA\">
	<cfset IQArootDir = "/departments/snk5212/IQA/">
	<cfset IQAAdminDir = "#IQArootDir#admin/">

	<cfset fullbasedir = "">
	<cfset fullBaseIQADir = "../IQA/">

	<cfinclude template="../SiteShared/incPaths.cfm">

	<cfset Request.SiteTitle = "Corrective Action Request (CAR) Process">
	<cfset REQUEST.KBSiteTitle = "IQA / CAR Process Website Knowledge Base">
    <cfset Request.Development = "No">

	<cfset myurl = "#cgi.script_name#?#QUERY_STRING#">

    <!--- not used anymore --->
	<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
    	<cfset Request.Menu = "#CARRootDir#admin/menu.cfm">
    <cfelse>
    	<cfset Request.Menu = "menu.cfm">
    </cfif>
    <!--- /// --->

	<cfset Request.Header = "http://#CGI.Server_Name#/header/header.js">
	<cfset Request.CSS = "http://#CGI.Server_Name##CARRootDir#css.css">
    <cfset Request.CSS2 = "http://#CGI.Server_Name##curdir#css2.css">
	<cfset Request.ULNetCSS = "http://#CGI.Server_Name#/header/ulnetheader.css">

	<cfoutput>
		<cfset CurYear = #Dateformat(now(), 'yyyy')#>
		<cfset NextYear = #CurYear# + 1>
		<cfset LastYear = #CurYear# - 1>
		<cfset CurMonth = #Dateformat(now(), 'mm')#>
		<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
		<cfset CurTime = #Timeformat(now(), 'HH:mm:ss')#>
		<cfset CurTimeDate = '#CurDate# #CurTime#'>
	</cfoutput>

<cfif NOT isDefined("SESSION.Auth.IsLoggedIn")>
	<cfif curdir EQ CARAdminDir>
		<cfif cgi.PATH_INFO NEQ "#CARAdminDir#global_login.cfm">
			<cfinclude template ="#CARAdminDir#global_login.cfm">
			<cfabort>
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
	<!---<cfinclude template="incViews.cfm">--->
</cffunction>

<cffunction name="onError" returntype="void" ouput="true">
	<cfargument name="exception" required="yes">
    <cfargument name="eventName" type="string" required="yes">

    <cfinclude template="#IQADir#error_handler.cfm">
</cffunction>

<cffunction name="onSessionStart" returnType="void" output="false">

</cffunction>

<cffunction name="onSessionEnd" returnType="void" output="false">
	<cfargument name="sessionScope" type="struct" required="true">
	<cfargument name="applicationScope" type="struct" required="false">
</cffunction>

</cfcomponent>