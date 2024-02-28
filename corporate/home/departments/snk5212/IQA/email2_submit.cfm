<cfparam name="link" default="">
<cfset link="#form.emaillink#">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" DataSource="Corporate">
UPDATE ERROR_IQA
SET
NAME = '#FORM.NAME#',
EMAIL = '#FORM.EMAIL#',
<cfset N1 = #ReplaceNoCase(FORM.e_INPUT,"<p>","", "ALL")#>
<cfset N2 = #ReplaceNoCase(N1,"</p>","", "ALL")#>
Notes = '#N2#'

WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Check">
SELECT * FROM Error_IQA
WHERE ID = #URL.ID#
</CFQUERY>

<cfmail from="IQA.Web.Error.Reporting@ul.com" to="#form.Email#" cc="Christopher.J.Nicastro@ul.com" subject="IQA Web Site Error Reporting" query="Check" type="HTML">
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

Notes:<br>
#Notes#<br><br>

Details:<br>
#Details#<br><Br>
</cfmail>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Quality Engineering Web Site - Error Reporting">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
You will receive a email receipt of this report momentarily.  Your issue and contact info has been logged in the Error Reporting system and a corrective and preventive action will be identified. Thanks for your patience. You will receive a response from IQA soon. <br><br>

<CFOUTPUT query="Check">
<p><b>Sent To:</b><br>
Christopher.J.Nicastro@ul.com</p>

<p><b>Subject:</b><br>
IQA Web Site Error Reporting</p>

<p><b>Sent By:</b><br>
#Name#, #Email#</p>

<p><b>Error Reporting Initiated URL:</b><br>
#URL#</p>

<p><b>Date and Time of Error:</b><br />
#Logged#</p>

<p><b>Notes</b><br>
#Notes#</p>

<p><b>Details:</b><br>
#Details#</p>
</CFOUTPUT>
</p>
<br>						  					  
						  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->