<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Certification Bodies">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- CB Audits - list programs --->
<CFQUERY BLOCKFACTOR="100" NAME="CBs" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Name, ID
FROM CBAudits
ORDER BY NAME
</cfquery>

<cfoutput query="CBs">
:: #Name# (#ID#)<Br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->