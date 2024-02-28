<CFAPPLICATION NAME="Login" SESSIONMANAGEMENT="YES" SESSIONTIMEOUT=#CreateTimespan(0,0,60,0)#>

<cfif NOT IsDefined("SESSION.Auth.IsLoggedIn")>

   <cfinclude template="login.cfm">
   <cfabort>
</cfif>

<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
<cfset CSS = "http://#CGI.Server_Name##curdir#css.css">

<cfif IsDefined("Cookie.CFID") AND IsDefined("Cookie.CFTOKEN")>
   <cfset Variables.cfid_local  = Cookie.CFID>
   <cfset Variables.cftoken_local  = Cookie.CFTOKEN>
   <cfcookie name="CFID" value="#Variables.cfid_local#">
   <cfcookie name="CFTOKEN" value="#Variables.cftoken_local#">
</cfif>

