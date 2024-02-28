<CFQUERY BLOCKFACTOR="100" NAME="DeleteRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
DELETE FROM GCAR_Metrics_New
WHERE
docID = '#URL.docID#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="addrow" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as newID FROM GCAR_Metrics_Duplicate_CARS
</cfquery>

<!--- add to the duplicates table --->
<CFQUERY BLOCKFACTOR="100" NAME="addDuplicates" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO GCAR_Metrics_Duplicate_CARS(ID, CARNumber, docID)
VALUES(#addrow.newID#, '#URL.CARNumber#', '#URL.docID#')
</cfquery>

<cflocation url="dbaDuplicateCARs.cfm?docID=#url.docID#&CARNumber=#URl.CARNumbeR#" addtoken="no">