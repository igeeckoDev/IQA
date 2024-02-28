<CFAPPLICATION 
	NAME="FAQ" 
	setclientcookies="Yes"
	SESSIONMANAGEMENT="YES" 
	SESSIONTIMEOUT=#CreateTimespan(0,8,0,0)#>
   
<cfset this.name = "FAQ">

<!---
<cfset OracleDB_Username = "UL06046">
<cfset OracleDB_Password = "UL06046">
--->

<cfinclude template="../SiteShared/OracleDBSchemaCredentials.cfm">
   
<cfset thisPath = ExpandPath("*.*")>
<cfset path = GetDirectoryFromPath(thisPath)>
<cfset basedir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
<cfset fullbasedir = "">

<cfinclude template="../SiteShared/incPaths.cfm">

<cfset Request.SiteTitle = "Quality Engineering - FAQ Index">
<cfset Request.Development = "No">

<!--- previous site design stuff --->
<cfset Request.header = "http://#CGI.Server_Name#/header/header.js">
<cfset Request.CSS = "http://#CGI.Server_Name##basedir#css.css">
<cfset Request.ULNetCSS = "http://#CGI.Server_Name#/header/ulnetheader.css">

<cfset space = "&nbsp;&nbsp;&nbsp; ::">