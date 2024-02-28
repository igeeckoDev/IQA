<CFAPPLICATION NAME="Login" SESSIONMANAGEMENT="YES" SESSIONTIMEOUT=#CreateTimespan(0,8,0,0)#>

<cfset REQUEST.DSN = "IQA">

<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<cfset thisPath = ExpandPath("*.*")>
<cfset path = GetDirectoryFromPath(thisPath)>
<cfset basedir = replace(path, "scheduler\", "", "All")>
<cfset carbackupdir = replace(path, "IQA\scheduler\", "QE\BackupDB\", "All")>
<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>

<cfset cjn_key = "urlencryptingissilly8281976">

<cfset header = "http://#CGI.Server_Name#/header/header.js">

<cfset CSS = "http://#CGI.Server_Name##curdir#css.css">

<cfif CGI.Server_Name is "usnbkiqas100p">
	<cfset ULNetCSS = "http://#CGI.Server_Name#/header/ulnetheader.css">
<cfelse>
	<cfset ULNetCSS = "http://#CGI.Server_Name#/header/ulnetheader.css">
</cfif>

<cfif IsDefined("Cookie.CFID") AND IsDefined("Cookie.CFTOKEN")>
   <cfset Variables.cfid_local  = Cookie.CFID>
   <cfset Variables.cftoken_local  = Cookie.CFTOKEN>
   <cfcookie name="CFID" value="#Variables.cfid_local#">
   <cfcookie name="CFTOKEN" value="#Variables.cftoken_local#">
</cfif>
