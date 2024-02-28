<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA DB - Login Email List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
			
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBEmailList"> 
SELECT Name, Email, Status FROM  IQADB_LOGIN  "LOGIN" WHERE status IS NULL
AND (AccessLevel = 'IQAAuditor' OR AccessLevel = 'Auditor' OR AccessLevel = 'RQM' OR AccessLevel = 'SU' OR AccessLevel = 'Admin')
AND (EMAIL <> '' 
AND EMAIL <> 'Internal.Quality_Audits@ul.com')
ORDER BY Email
</CFQUERY>

<cfset EmailList = #valueList(KBEmailList.Email, ', ')#>
<cfoutput>
#EmailList#
</cfoutput><br><br>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->