<cfcomponent extends="IQA.Application">

<!---
<cffunction name="onApplicationStart" returnType="boolean" output="false">
	<cfreturn true>
</cffunction>

<cffunction name="onApplicationEnd" returnType="void" output="false">
	<cfargument name="applicationScope" required="true">
</cffunction>

<cffunction name="onRequestStart" returnType="boolean" output="false">
	<cfargument name="thePage" type="string" required="true">
	
	<cfset thisPath = ExpandPath("*.*")>
	<cfset path = GetDirectoryFromPath(thisPath)>
	<cfset basedir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
	<cfset myurl = "#cgi.script_name#?#QUERY_STRING#">
	<cfset schedurl = "#basedir#schedule.cfm?#QUERY_STRING#">
	<cfset calurl = "#basedir#calendar.cfm?#QUERY_STRING#">
	<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>	
    
   	<cfset Request.SiteTitle = "UL Audit Database">
	<cfset Request.Menu = "menu.cfm">
	<cfset Request.Header = "http://#CGI.Server_Name#/header/header.js">
	<cfset Request.CSS = "http://#CGI.Server_Name##basedir#css.css">
	<cfset Request.ULNetCSS = "http://#CGI.Server_Name#/header/ulnetheader.css">
    <cfset Request.CSS2 = "http://#CGI.Server_Name##curdir#css2.css">
	
	<cfoutput>
		<cfset CurYear = #Dateformat(now(), 'yyyy')#>
		<cfset NextYear = #CurYear# + 1>
		<cfset LastYear = #CurYear# - 1>
		<cfset CurMonth = #Dateformat(now(), 'mm')#>
		<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
		<cfset CurTime = #Timeformat(now(), 'HH:mm:ss')#>
		<cfset CurTimeDate = '#CurDate# #CurTime#'>
	</cfoutput>

	<cfif IsDefined("Cookie.CFID") AND IsDefined("Cookie.CFTOKEN")>
	    <cfset Variables.cfid_local = Cookie.CFID>
	    <cfset Variables.cftoken_local = Cookie.CFTOKEN>
	    <cfcookie name="CFID" value="#Variables.cfid_local#">
	    <cfcookie name="CFTOKEN" value="#Variables.cftoken_local#">
	</cfif>

<!---
	<cferror type = "Exception"
		template = "error_handler.cfm"
		mailTo = "Christopher.J.Nicastro@ul.com">
   
	<cferror type = "Request"
		template = "error_handler.cfm"
		mailTo = "Christopher.J.Nicastro@ul.com">	
--->
	
	<cfreturn true>
</cffunction>

<cffunction name="onRequest" returnType="void">
	<cfargument name="thePage" type="string" required="true">      
	<cfinclude template="#arguments.thePage#">
</cffunction>

<cffunction name="onRequestEnd" returnType="void" output="true">
	<cfargument name="thePage" type="string" required="true">
</cffunction>

<cffunction name="onSessionStart" returnType="void" output="false">
</cffunction>
   
<cffunction name="onSessionEnd" returnType="void" output="false">
	<cfargument name="sessionScope" type="struct" required="true">
	<cfargument name="appScope" type="struct" required="false">
</cffunction>
--->

</cfcomponent>