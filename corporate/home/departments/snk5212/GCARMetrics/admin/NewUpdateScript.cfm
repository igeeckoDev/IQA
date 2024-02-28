<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Administration Actions - Update GCAR Metrics Script 1">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

1. Remove History and Response Acceptance Date_delete Columns -
<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN CARHistory
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN ResponseAcceptanceDate_delete
</CFQUERY>

Done<br />

<cflocation url="2.cfm" addtoken="no">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->