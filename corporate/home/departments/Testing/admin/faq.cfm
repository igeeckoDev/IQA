<!--- Start of Page File --->
<cfset subTitle = "Frequently Asked Questions">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="FAQ" Datasource="Corporate"> 
SELECT * FROM IQADB_FAQ "FAQ" 
WHERE Status = 'Active'
ORDER BY alphaID
</CFQUERY>

<cfinclude template="#IQARootDir#qFAQ.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->