<cfoutput>
<cfsavecontent variable="errorText">
<table border="1" class="blog-content">
<tr>
	<td>Error Event</td>
	<td>#Arguments.EventName#</td>
</tr>
<tr>
	<td>Type of error</td>
    <td>#arguments.exception.RootCause.Type#</td>
</tr>
<tr>
	<td>Page</td>
	<td>http://#cgi.server_name##cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#</td>
</tr>
<tr>
	<td>Time/Date</td>
    <td>#dateformat(now(), "short")# #timeformat(now(), "short")#</td>
</tr>
<tr>
	<td>Detail</td>
	<td>#arguments.exception.RootCause.Detail#</td>
</tr>
<tr>
	<td>Message</td>
	<td>#arguments.exception.RootCause.Message#</td>
</tr>
<tr>
	<td>SQL</td>
	<td><cfif isDefined("arguments.exception.RootCause.SQL")>#arguments.exception.RootCause.SQL#<cfelse>None</cfif></td>
</tr>
<tr>
	<td>Trace</td>
	<td>
    <table class="blog-content">
        <cfloop index="i" from="1" to="#arraylen(arguments.exception.Cause.TagContext)#">
        <tr>
        <td>
        #i#: #arguments.exception.RootCause.TagContext[i].Template# (Line #arguments.exception.RootCause.TagContext[i].Line#)
        </td>
        </tr>
        </cfloop>
	</table>
    </td>
</tr>
<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
<tr>
	<td>User:</td>
	<td>
    	<cflock scope="Session" timeout="5">
		#SESSION.Auth.UserName#, #SESSION.Auth.Email#
		</cflock>
	</td>
</tr>
</cfif>
<tr>
	<td>DB</td>
	<td>Corporate</td>
</tr>
<tr>
	<td>Protocol</td>
    <td>#cgi.server_protocol#</td>
</tr>
<tr>
	<td>Browser</td>
    <td>#cgi.http_user_agent#</td>
</tr>
<tr>
	<td>IP</td>
	<td>#cgi.remote_addr#</td>
</tr>
<tr>
	<td>Referring Page</td>
	<td>#cgi.http_referer#</td>
</tr>
</table>
</cfsavecontent>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Query">
SELECT MAX(ID) + 1 AS newid FROM Error_IQA
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="AddID">
INSERT INTO Error_IQA(ID)
VALUES (#Query.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Notify" DataSource="Corporate">
UPDATE Error_IQA
SET

<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
	<cflock scope="Session" timeout="5">
NAME =  '#SESSION.Auth.UserName#',
EMAIL = '#SESSION.Auth.Email#',
	</cflock>
<cfelse>
Name = '#cgi.REMOTE_ADDR#',
</cfif>

URL = 'http://#cgi.SERVER_NAME##cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#',
LOGGED = '#CurTimeDate#',
DB = 'Corporate',
Response = 'No',
DETAILS = '#errorText#'

WHERE ID = #query.newid#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="newError">
SELECT * FROM Error_IQA
WHERE ID = #query.newid#
</CFQUERY>

<cfmail to="#Request.ErrorMailTo#" from="IQA.Web.Error.Reporting@ul.com" subject="#Request.SiteTitle# Error Reporting" type="HTML" query="newError">

User: #Name#<cfif len(Email)>, #Email#</cfif><br />
Date/Time: #Logged#<br />
DB: #DB#<br />
Page: #URL#<br /><br />

Details:<br />
#Details#<br /><br />

An Error Report has been logged in the IQA Database.
</cfmail>

<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
	<cflock scope="Session" timeout="5">
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Check">
SELECT * FROM Error_IQA
WHERE ID = #query.newid#
</CFQUERY>

<cfmail from="IQA.Web.Error.Reporting@ul.com" to="#Email#" cc="#Request.ErrorMailTo#" subject="#Request.SiteTitle# Error Reporting" query="newError" type="HTML">
The error and contact info has been logged in the #Request.SiteTitle# Error Reporting system and a corrective and preventive action will be identified. Thanks for your patience. You will receive a response from IQA soon.<br><br>

Sent To:<br>
#Request.ErrorMailTo#<br><br>

Subject:<br>
IQA Web Site Error Reporting<br><br>

Sent By: <br>
#Name# (#Email#)<br><br>

Error Reporting Initiated URL:<br>
#URL#<br><br>

Date/Time:<br>
#Logged#<br><br>

Details:<br>
#Details#<br><Br>
</cfmail>
	</cflock>
</cfif>

<cfoutput>
<div align="left" class="blog-content">
<br />
The application has encountered an error.<Br>
The error report has been sent to <a href = "mailto:#Request.ErrorMailTo#">#Request.ErrorMailTo#</A>.<br /><br />

<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
	<cflock scope="Session" timeout="5">
(You are logged in as #Session.Auth.UserName#) You will be contacted soon about the resolution of this error. If you wish to <b>add notes</b> about this error, you can do so <a href="#IQARootDIr#getEmpNo.cfm?page=email2&id=#query.newid#"><b>here</b></a>.
	</cflock>
<cfelse>
<b>To be contacted about this error</b><br />
Please confirm your Name and Email Address <a href="#IQARootDir#getEmpNo.cfm?page=email2&id=#query.newid#"><b>here</b></a>.
</cfif><br><Br>
</div>

<div align="left" class="blog-small">
<b>Details</b><br>
    #errorText#

	<cfdump var="#arguments.exception#">
</div>
</cfoutput>