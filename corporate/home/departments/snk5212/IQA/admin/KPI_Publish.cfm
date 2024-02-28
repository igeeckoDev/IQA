<CFQUERY BLOCKFACTOR="100" NAME="maxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewMaxID
FROM KPI
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="UpdateRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE UL06046.KPI
SET 
DatePosted = #CreateODBCDate(curdate)#, 
ID = #maxID.NewMaxID#

WHERE ID = 0
</cfquery>

<cflocation url="KPI_View.cfm?ID=#maxID.NewMaxID#" addtoken="no">