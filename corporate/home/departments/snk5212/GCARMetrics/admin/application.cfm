<CFAPPLICATION
	NAME="GCARMetrics"
	setclientcookies="Yes"
	SESSIONMANAGEMENT="YES"
	SESSIONTIMEOUT=#CreateTimespan(0,8,0,0)#>

<cfset this.name = "GCARMetrics">

<cfset thisPath = ExpandPath("*.*")>
<cfset path = GetDirectoryFromPath(thisPath)>
<cfset basedir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
<cfset curdir = replace(GetDirectoryFromPath(cgi.script_name), "\", "", "All")>
<cfset fullbasedir = "">

<cfinclude template="../../SiteShared/incPaths.cfm">

<cfinclude template="../../SiteShared/OracleDBSchemaCredentials.cfm">

<cfset Request.DSN = "UL06046">

<cfset Request.GreenText = "Acceptable">
<cfset Request.YellowText = "Improvement Recommended">
<cfset Request.RedText = "Improvement Required">

<cfset Request.ResponseEscalationGreen = 0.95>
<cfset Request.ResponseEscalationRed = 0.90>

<cfset Request.ImplementationEscalationGreen = 0.95>
<Cfset Request.ImplementationEscalationRed = 0.90>

<cfset Request.ResponseOverdueGreen = 0.85>
<cfset Request.ResponseOverdueRed = 0.75>

<cfset Request.ImplementationOverdueGreen = 0.85>
<cfset Request.ImplementationOverdueRed = 0.75>

<!--- Set Last Update of Data Refresh --->
<cfquery datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#" name="lastUpdate">
SELECT PostedDate
FROM GCAR_METRICS_LastUpdate
WHERE ID = (SELECT MAX(ID) FROM GCAR_METRICS_LastUpdate)
</cfquery>

<Cfset Request.DataDate = "#dateformat(lastUpdate.PostedDate, 'mm/dd/yyyy')#">
<!--- /// --->

<cfset Request.AdminEmpNo = "06046">

<cfset Request.minYear = "2012">
<cfset Request.maxYear = "2017">
<cfset Request.SiteTitle = "GCAR Metrics #Request.minYear#-#Request.maxYear#">
<cfset Request.Development = "No">

<cfset Request.header = "http://#CGI.Server_Name#/header/header.js">
<cfset Request.CSS = "http://#CGI.Server_Name##basedir#css.css">
<cfset Request.ULNetCSS = "http://#CGI.Server_Name#/header/ulnetheader.css">

<cfset space = "&nbsp;&nbsp;&nbsp; ::">

<cfif NOT isDefined("SESSION.Auth.IsLoggedIn")>
	<cfif curdir EQ GCARMetricsAdminDir>
		<cfif cgi.PATH_INFO NEQ "#GCARMetricsAdminDir#getEmpNo_Admin.cfm">
			<cflocation url="#GCARMetricsDir#index.cfm" ADDTOKEN="No">
		</cfif>
	</cfif>
</cfif>

<cfif IsDefined("Cookie.CFID") AND IsDefined("Cookie.CFTOKEN")>
    <cfset Variables.cfid_local = Cookie.CFID>
    <cfset Variables.cftoken_local = Cookie.CFTOKEN>
    <cfcookie name="CFID" value="#Variables.cfid_local#">
    <cfcookie name="CFTOKEN" value="#Variables.cftoken_local#">
</cfif>