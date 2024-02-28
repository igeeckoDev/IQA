<cfparam name="link" default="">
<cfset link="#form.emaillink#">

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Check">
SELECT * FROM CAR_ERROR "ERROR"
</CFQUERY>

<Cfif Check.recordcount eq 0>
	<cfset Query.newid = 1>
<cfelse>
	<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Query">
SELECT MAX(ID) + 1 AS newid FROM CAR_ERROR "ERROR"
</CFQUERY>
</CFIF>

<CFQUERY DataSource="Corporate" Name="AddID">
INSERT INTO CAR_ERROR "ERROR" (ID)
VALUES (#Query.newid#)
</CFQUERY>

<cfset N1 = #ReplaceNoCase(FORM.e_INPUT,chr(13),"<br>", "ALL")#>
<CFQUERY BLOCKFACTOR="100" NAME="Notify" DataSource="Corporate">
UPDATE CAR_ERROR "ERROR" 
SET
NAME = '#FORM.NAME#',
EMAIL = '#FORM.EMAIL#',
URL = '#LINK#',
LOGGED = '#curdate# #curtime#',
DETAILS = <CFQUERYPARAM VALUE='#N1#'>,

Response = 'No'

WHERE ID = #query.newid#
</CFQUERY>

<cfmail from="CAR.Web.Error.Reporting@ul.com" cc="#form.Email#" to="#Request.ErrorMailTo#" subject="CAR Web Site Error Reporting" type="HTML">

Sent To:<br />
Christopher.J.Nicastro@ul.com<Br /><br />

Subject:<br />
CAR WebSite Error Reporting<br /><br />

Sent By: <br />
#Form.Name# (#Form.Email#)<Br /><br />

Error Reporting Initiated URL:<br />
#link#<Br /><br />

Details:<br />

<cfset N1 = #ReplaceNoCase(FORM.e_INPUT,"<p>","", "ALL")#>
<cfset N2 = #ReplaceNoCase(N1,"</p>","<br><br>", "ALL")#>
#N2#

</cfmail>

<CFQUERY BLOCKFACTOR="100" NAME="Output" DataSource="Corporate">
SELECT * FROM CAR_ERROR "ERROR" 
WHERE ID = #query.newid#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Error Reporting">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>Error Report sent.<br><br>
You will receive a receipt of this email shortly. You should receive a response soon. Your issue has been logged in the Error Reporting system and a corrective and preventive action will be identified. Thanks for your patience.<br><br>

<CFOUTPUT query="Output">
<p><b>Sent To:</b><br>
Christopher.J.Nicastro@ul.com</p>

<p><b>Subject:</b><br>
CAR WebSite Error Reporting</p>

<p><b>Sent By:</b><br>
#Name#, #Email#</p>

<p><b>Error Reporting Initiated URL:</b><br>
#URL#</p>

<p><b>Details:</b><br>
<pre>#details#</pre></p>
</CFOUTPUT>
<br>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->