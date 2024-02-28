<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Administration Actions - Update GCAR Metrics Script 3">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

1. Remove History Column - Done<br />
2. Copy Data from NewImport to New table - Done<br />
3. Drop NewImport Table and Delete Known Duplicate CARs -

<CFQUERY BLOCKFACTOR="100" NAME="DropTable" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Drop TABLE GCAR_Metrics_NewImport
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="KnownDuplicates" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, docID
FROM GCAR_Metrics_Duplicate_CARS
ORDER BY CARNumber
</cfquery>

Known Duplicates Deleted:<br /><br />

<cfoutput query="KnownDuplicates">
CAR Number: #CARNumber# / docID: #docID#<br />
	<CFQUERY BLOCKFACTOR="100" NAME="DeletedDuplicates" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    DELETE FROM GCAR_Metrics_New
    WHERE
	docID = '#docID#'
    AND CARNumber = '#CARNumber#'
    </CFQUERY>
</cfoutput><br />

Done<br />

<cflocation url="3a.cfm" addtoken="no">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->