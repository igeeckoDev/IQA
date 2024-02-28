<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Query">
SELECT MAX(ID) + 1 AS newid FROM Error_Robots
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="AddID">
INSERT INTO Error(ID)
VALUES (#Query.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Notify" DataSource="Corporate">
UPDATE ERROR_Robots
SET
<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
	<cflock scope="Session" timeout="5">
NAME =  '#SESSION.Auth.UserName#',
EMAIL = '#SESSION.Auth.Email#',
	</cflock>
</cfif>
URL = '#error.template#',
LOGGED = '#error.datetime#',
DETAILS = 'Location: #error.remoteAddress#<br>
Browser: #error.browser#<br>
Date/Time: #error.dateTime#<br>
Referring Page: <cfif error.httpreferer is "">None Listed<cfelse>#error.HTTPReferer#</cfif><br>
Current Page: #error.template#<br>
Query String: #error.QueryString#<br><br>
Message Content:<br>
#error.diagnostics#<br>',
Response = 'No'

WHERE ID = #query.newid#
</CFQUERY>

<cfmail to="#error.mailto#" from="IQA.Web.Error.Reporting@ul.com" subject="IQA Web Site Error Reporting" type="HTML">
<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
	<cflock scope="Session" timeout="5">
		User: #SESSION.Auth.UserName#, #SESSION.Auth.Email#<br>
	</cflock>
</cfif>
Location: #error.remoteAddress#<br>
Browser: #error.browser#<br>
Date/Time: #error.dateTime#<br>
Referring Page: <cfif error.httpreferer is "">None Listed<cfelse>#error.HTTPReferer#</cfif><br>
Current Page: #error.template#<br>
Query String: #error.QueryString#<br><br>
Message Content:<br>
#error.diagnostics#<br><br />

An Error Report has been logged in the IQA Database.
</cfmail>

<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
	<cflock scope="Session" timeout="5">
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Check">
SELECT * FROM Error_Robots
WHERE ID = #query.newid#
</CFQUERY>

<cfmail from="IQA.Web.Error.Reporting@ul.com" to="#Email#" cc="Christopher.J.Nicastro@ul.com" subject="IQA Web Site Error Reporting - Robot Error" query="Check" type="HTML">
The error and contact info has been logged in the IQA Error Reporting system and a corrective and preventive action will be identified. Thanks for your patience. You will receive a response from IQA soon.<br><br>

Sent To:<br>
Christopher.J.Nicastro@ul.com<br><br>

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
<br />
The application has encountered an error.<Br>
The error report has been sent to <a href = "mailto:#error.mailTo#">#error.mailTo#</A>.<br /><br />

<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
	<cflock scope="Session" timeout="5">
(You are logged in as #Session.Auth.UserName#) You will be contacted soon about the resolution of this error. If you wish to <b>add notes</b> about this error, you can do so <a href="getEmpNo.cfm?page=email2&id=#query.newid#"><b>here</b></a>.
	</cflock>
<cfelse>
<b>To be contacted about this error</b><br />
Please confirm your Name and Email Address <a href="getEmpNo.cfm?page=email2&id=#query.newid#"><b>here</b></a>.
</cfif><br><Br>

<div class="blog-small">
<b>Details</b><br>
    #error.diagnostics#
</div>
</cfoutput>