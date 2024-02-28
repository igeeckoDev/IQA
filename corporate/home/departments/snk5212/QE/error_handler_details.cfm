<cfoutput>
<div class="blog-content">
An Error has Occurred: http://#cgi.server_name##cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#<br />
Time: #dateformat(now(), "short")# #timeformat(now(), "short")#<br /><br />

An error report has been sent to <a href = "mailto:#Request.ErrorMailTo#">#Request.ErrorMailTo#</A><br><Br>

<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
	<cflock scope="Session" timeout="5">
(You are logged in as #Session.Auth.UserName#) You will be contacted soon about the resolution of this error. If you wish to <b>add notes</b> about this error, you can do so <a href="#CARRootDir#getEmpNo.cfm?page=email2"><b>here</b></a>.
	</cflock>
<cfelse>
<b>To be contacted about this error</b><br />
Please confirm your Name and Email Address <a href="#CARRootDir#getEmpNo.cfm?page=email2"><b>here</b></a>.
</cfif>
</div><br /><br />

<cfsavecontent variable="errorText">
<table border="1">
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
	<table>
        <cfloop index="i" from="1" to="#arraylen(arguments.exception.Cause.TagContext)#">
        <tr>
        <td>
        #i#: #arguments.exception.RootCause.TagContext[i].Template# (Line #arguments.exception.RootCause.TagContext[i].Line#)
        </td>
        </tr>
        </cfloop>
	</table>
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

<cfmail to="#Request.ErrorMailTo#" from="#Request.ErrorMailTo#" Subject="#Request.SiteTitle# Error" type="HTML">
#errorText#
</cfmail>