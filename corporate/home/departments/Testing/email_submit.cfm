<cfparam name="link" default="">
<cfset link="#form.emaillink#">

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Check">
SELECT * FROM Error_IQA
</CFQUERY>

<Cfif Check.recordcount eq 0>
	<cfset Query.newid = 1>
<cfelse>
	<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Query">
	SELECT MAX(ID) + 1 AS newid FROM Error_IQA
	</CFQUERY>
</CFIF>

<CFQUERY DataSource="Corporate" Name="AddID">
INSERT INTO Error_IQA(ID)
VALUES (#Query.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Notify" DataSource="Corporate">
UPDATE ERROR_IQA
SET
NAME = '#FORM.NAME#',
EMAIL = '#FORM.EMAIL#',
URL = '#urlDecode(LINK)#',
LOGGED = '#curdate# #curtime#',
DETAILS = '#FORM.e_input#',
Response = 'No'

WHERE ID = #query.newid#
</CFQUERY>

<cfmail from="IQA.Web.Error.Reporting@ul.com" to="#form.Email#" cc="#REQUEST.ErrorMailTo#" subject="IQA Web Site Error Reporting" type="HTML">
Your issue has been logged in the IQA Error Reporting system and a corrective and preventive action will be identified. Thanks for your patience. You will receive a response soon.<br /><br />

Sent To:<br />
#REQUEST.ErrorMailTo#<Br /><br />

Subject:<br />
IQA Web Site Error Reporting<br /><br />

Sent By: <br />
#Form.Name# (#Form.Email#)<Br /><br />

Error Reporting Initiated URL:<br />
#urlDecode(link)#<Br /><br />

Details:<br />
<cfset N1 = #ReplaceNoCase(FORM.e_INPUT,"<p>","", "ALL")#>
<cfset N2 = #ReplaceNoCase(N1,"</p>","<br><br>", "ALL")#>
#N2#
</cfmail>

<CFQUERY BLOCKFACTOR="100" NAME="Output" DataSource="Corporate">
SELECT * FROM Error_IQA
WHERE ID = #query.newid#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Quality Engineering Web Site - Error Reporting">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>Error Report sent.<br><br>
You will receive a email receipt of this report momentarily.  Your issue has been logged in the Error Reporting system and a corrective and preventive action will be identified. Thanks for your patience. You will receive a response soon.<br><br>

<CFOUTPUT query="Output">
<p><b>Sent To:</b><br>
#REQUEST.ErrorMailTo#</p>

<p><b>Subject:</b><br>
IQA Web Site Error Reporting</p>

<p><b>Sent By:</b><br>
#Name#, #Email#</p>

<p><b>Error Reporting Initiated URL:</b><br>
#URL#</p>

<b>Details:</b><br>
<cfset N1 = #ReplaceNoCase(Details,"<p>","", "ALL")#>
<cfset N2 = #ReplaceNoCase(N1,"</p>","<br><br>", "ALL")#>
#N2#
</CFOUTPUT>
</p>
<br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->