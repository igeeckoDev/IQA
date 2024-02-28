<CFAPPLICATION
	NAME="FAQ"
	setclientcookies="Yes"
	SESSIONMANAGEMENT="YES"
	SESSIONTIMEOUT=#CreateTimespan(0,8,0,0)#>

<cfset this.name = "DAP - Data Acceptance Program">

<!---
<cfset OracleDB_Username = "UL06046">
<cfset OracleDB_Password = "UL06046">
--->

<cfoutput>
	<cfset CurYear = #Dateformat(now(), 'yyyy')#>
	<cfset NextYear = #CurYear# + 1>
	<cfset LastYear = #CurYear# - 1>
	<cfset CurMonth = #Dateformat(now(), 'mm')#>
	<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>
	<cfset CurTime = #Timeformat(now(), 'HH:mm:ss')#>
	<cfset CurTimeDate = '#CurDate# #CurTime#'>
</cfoutput>

<cfinclude template="../SiteShared/OracleDBSchemaCredentials.cfm">

<cfset thisPath = ExpandPath("*.*")>
<cfset path = GetDirectoryFromPath(thisPath)>
<cfset basedir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
<cfset fullbasedir = "">

<cfinclude template="../SiteShared/incPaths.cfm">

<cfset Request.SiteTitle = "DAP - Data Acceptance Program is under change and the information on the site has not been updated to
reflect the changes, and is therefore for reference only.">
<cfset Request.Development = "No">

<!--- previous site design stuff --->
<cfset Request.header = "http://#CGI.Server_Name#/header/header.js">
<cfset Request.CSS = "http://#CGI.Server_Name##basedir#css.css">
<cfset Request.ULNetCSS = "http://#CGI.Server_Name#/header/ulnetheader.css">

<cfset space = "&nbsp;&nbsp;&nbsp; ::">