<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "2016 DAP Audit Planning - Questions">
<cfinclude template="shared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046">
SELECT
	ID, Question
FROM
	DAPAuditPlanning2016_Questions
ORDER BY
	ID
</CFQUERY>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfset i = 1>
<cfoutput query="Questions">

<b>#i#</b> : #Question#<br /><Br />

<hr>

<br>

<cfset i = i+1>
</cfoutput>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- / --->