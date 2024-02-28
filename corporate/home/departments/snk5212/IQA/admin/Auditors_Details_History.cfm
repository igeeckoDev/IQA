<cfif url.Type eq "TechnicalAudit">
	<cfset AuditorType = "Technical Audit">
<cfelse>
	<cfset AuditorType = url.Type>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#AuditorType# - <a href=Auditors.cfm?Type=#URL.Type#>Auditor List</a> - Auditor Profile Change History">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Auditors" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Auditor, History
From Auditors
WHERE ID = #URL.ID#
</CFQUERY>

<CFOUTPUT query="Auditors">
<b>Auditor Profile Change History</b>
<br><br>

<u>Auditor Name</u>:<br>
#Auditor# <a href="Auditors_Details.cfm?#CGI.Query_String#">[View Profile]</a>
<br><br>

<u>History</u> (Oldest to Newest)<br>
<cfif len(History)>
	#History#
<cfelse>
	No History
</cfif>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->