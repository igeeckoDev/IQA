<cfcomponent>
<cfscript>
	this.name="Andon";
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

    <cfset Request.ErrorMailTo = "Christopher.J.Nicastro@ul.com">
    <cfset Request.AlertEmail = "global.internalquality@ul.com">
    
<cfset OracleDB_Username = "UL06046">
<cfset OracleDB_Password = "UL06046">
   
	<cfset thisPath = ExpandPath("*.*")>
	<cfset path = GetDirectoryFromPath(thisPath)>
	<cfset baseDir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
	<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
    
	<cfset CARRootPath = "d:\webserver\corporate\home\depts\snk5212\QE\">
	<cfset CARRootDir = "/departments/snk5212/QE/">	
    <cfset CARAdminDir = "#CARrootDir#admin/">
	
    <cfset IQARootPath = "d:\webserver\corporate\home\depts\snk5212\IQA\">    
    <cfset IQArootDir = "/departments/snk5212/IQA/">
    <cfset IQAAdminDir = "#IQArootDir#admin/">
    
    <cfset AndonRootPath = "d:\webserver\corporate\home\depts\snk5212\Andon\">    
    <cfset AndonrootDir = "/departments/snk5212/Andon/">
    <cfset AndonAdminDir = "#AndonrootDir#admin/">

	<cfset fullbasedir = "">
	<cfset fullBaseIQADir = "../IQA/">
	<cfset fullBaseCARDir = "../QE/">
        
	<cfset Request.SiteTitle = "Andon Checklist">

	<cfset Request.Menu = "menu.cfm">
	<cfset Request.Header = "http://#CGI.Server_Name#/header/header.js">
	<cfset Request.CSS = "http://#CGI.Server_Name##AndonRootDir#css.css">
    <cfset Request.CSS2 = "http://#CGI.Server_Name##curdir#css2.css">
	<cfset Request.ULNetCSS = "http://#CGI.Server_Name#/header/ulnetheader.css">

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
    
	<!---
	<cfinclude template="error_handler_details.cfm">
    <cfinclude template="EOP.cfm">
	---->
</cffunction>

<cffunction name="onSessionStart" returnType="void" output="false">

</cffunction>
   
<cffunction name="onSessionEnd" returnType="void" output="false">
	<cfargument name="sessionScope" type="struct" required="true">
	<cfargument name="applicationScope" type="struct" required="false">
</cffunction>

</cfcomponent>