<cfparam name="link" default="">
<cfset link="#form.emaillink#">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT MAX(ID) + 1 AS newid FROM Error_IQA
</CFQUERY>

<CFQUERY Datasource="Corporate" Name="AddID">
INSERT INTO Error_IQA(ID)
VALUES (#Query.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
UPDATE ERROR_IQA
SET
NAME = '#FORM.e_NAME#',
EMAIL = '#FORM.e_EMAIL#',
URL = '#LINK#',
LOGGED = '#curdate# #curtime#',
<cfset N1 = #ReplaceNoCase(FORM.e_INPUT,chr(13),"<br>", "ALL")#>
DETAILS = '#N1#',
Response = 'No'

WHERE ID = #query.newid#
</CFQUERY>

<cfmail from="IQA.Error.Reporting@ul.com" cc="#form.e_Email#" to="Internal.Quality_Audits@ul.com" subject="IQA Error Reporting">
Sent To:
Internal.Quality_Audits@ul.com

Subject:
IQA Error Reporting

Sent By:
#Form.e_Name# (#Form.e_Email#)

Error Reporting Initiated URL:
#link#

Details:
#Form.e_input#
</cfmail>

<CFQUERY BLOCKFACTOR="100" NAME="Output" Datasource="Corporate">
SELECT * FROM Error_IQA
WHERE ID = #query.newid#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Error Reporting">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>Error Report sent.<br><br>
You will receive a receipt of this email shortly. You should receive a response within 24 hours (not including weekends). Your issue has been logged in the Error Reporting system and a corrective and preventive action will be identified. Thanks for your patience.<br><br>

<br><br>
<hr noshade width="75%" align="center">
<br><br>
<CFOUTPUT query="Output">
<p><b>Sent To:</b><br>
Internal.Quality_Audits@ul.com</p>

<p><b>Subject:</b><br>
IQA Error Reporting</p>

<p><b>Sent By:</b><br>
#Name#, #Email#</p>

<p><b>Error Reporting Initiated URL:</b><br>
#URL#</p>

<p><b>Details:</b><br>
<pre>#details#</pre></p>
</CFOUTPUT>
</p>
<br>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->