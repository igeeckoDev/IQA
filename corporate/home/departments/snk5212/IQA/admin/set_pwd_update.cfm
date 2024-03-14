<cfinclude template="_cryptoTest.cfm">

<cflock scope="SESSION" timeout="6">
	<CFQUERY BLOCKFACTOR="100" NAME="change_pwd" Datasource="Corporate"> 
	UPDATE IQADB_LOGIN "LOGIN" 
	SET 
	password = '#FORM.ConfirmP1#'
	WHERE ID = #URL.ID#
	</CFQUERY>
</CFLOCK>

<CFQUERY BLOCKFACTOR="100" NAME="finduser" DataSource="Corporate">
SELECT * FROM IQADB_Login
WHERE ID = #URL.ID#
</cfquery>

<cfmail 
from="Internal.Quality_Audits@ul.com" 
to="#Email#"
subject="UL Audit Database - Password Update"
query="finduser"
type="html">
UL Audit Database login information:<br />
username - #form.username#<br />
password - #password#<br /><br />

Please save this email for future reference.<br /><br />

You can view the UL Audit Database here:<br />
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/">#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/</a>
</cfmail>

<cflock scope="SESSION" timeout="60">
	  <cfset SESSION.Auth = StructNew()>
      <cfset SESSION.Auth.IsLoggedIn = "Yes">
	  <cfset SESSION.Auth.IsLoggedInApp = #this.Name#>
	  <cfset SESSION.Auth.Password = finduser.password>
      <cfset SESSION.Auth.Name = finduser.Name>
      <cfset SESSION.Auth.username = finduser.username>
      <cfset SESSION.Auth.accesslevel = finduser.accesslevel>
      	<cfif SESSION.Auth.AccessLevel eq "SU">
        	<cfset SESSION.Auth.IsSuperUser = "Yes">
        <cfelse>
        	<cfset SESSION.Auth.IsSuperUser = "No">
        </cfif>
	  <cfset SESSION.Auth.Region = finduser.Region>
  	  <cfset SESSION.Auth.SubRegion = finduser.SubRegion>
  	  <cfset SESSION.Auth.Office = finduser.Office>
  	  <cfset SESSION.Auth.Email = finduser.Email>
  	  <cfset SESSION.Auth.ID = finduser.ID>
      <cfset SESSION.Auth.Andon = finduser.Andon>
      <cfset SESSION.Auth.IQA = finduser.IQA>
	  <cfset newIP = CGI.REMOTE_ADDR>
	  <cfset newBrowser = CGI.HTTP_USER_AGENT>
      
<cfif cgi.server_name is "usnbkiqas100p" AND curdir is "/departments/snk5212/iqa/admin/">
<cfset TotLogins = #finduser.TotalLogins# + 1>

<cfquery Datasource="Corporate" name="UpdateUser"> 
UPDATE IQADB_LOGIN  "LOGIN" SET TotalLogins = #TotLogins#,
LastIP = '#newIP#',
LastBrowser = '#newBrowser#',
LastLogin = '#curdate# #curtime#',
IPLog = <CFQUERYPARAM VALUE="#newIP#<br>#finduser.IPLog#" CFSQLTYPE="CF_SQL_CLOB">,
LoginLog = <CFQUERYPARAM VALUE="#curdate# #curtime# (#newIP#)<br>#finduser.LoginLog#" CFSQLTYPE="CF_SQL_CLOB">

WHERE username = '#finduser.username#'
</cfquery>	
</cfif>
	  <!--- Everything is ok. Send the user to menu template. --->
<!--- Place the cursor in the 'User Name' field when the page loads and start the login form. --->		  
	<CFIF SESSION.Auth.accesslevel is "IQAAuditor">
        <cflocation url="index.cfm" addtoken="no">
    <cfelseif SESSION.Auth.AccessLevel is "RQM">
        <cflocation url="schedule.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.SubRegion#&Auditor=All" ADDTOKEN="No">
    <cfelseif SESSION.Auth.AccessLevel is "Field Services">
        <cflocation url="index.cfm" addtoken="no">
    <cfelseif SESSION.Auth.AccessLevel is "Finance">
        <cflocation url="index.cfm" addtoken="no">
    <cfelseif SESSION.Auth.AccessLevel is "AS">
        <cflocation url="index.cfm" addtoken="no">
    <cfelseif SESSION.Auth.AccessLevel is "Laboratory Technical Audit">
        <cflocation url="index.cfm" addtoken="no">
    <cfelseif SESSION.Auth.AccessLevel is "Verification Services">
        <cflocation url="index.cfm" addtoken="no">
    <cfelseif SESSION.Auth.AccessLevel is "WiSE">
        <cflocation url="index.cfm" addtoken="no">
    <cfelseif SESSION.Auth.AccessLevel is "CPO">
        <cflocation url="_prog.cfm?list=CPO" ADDTOKEN="No">
    <cfelseif SESSION.Auth.AccessLevel is "Technical Audit">
        <cflocation url="TechnicalAudits_Test.cfm" addtoken="no">
    <CFELSE>
        <cflocation url="index.cfm" ADDTOKEN="No">
    </CFIF>
</cflock>