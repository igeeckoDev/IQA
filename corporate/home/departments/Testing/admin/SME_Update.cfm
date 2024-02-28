<CFQUERY Name="SME" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
From SME
WHERE SME = '#Form.SME#'
</CFQUERY>

<cfif SME.recordCount EQ 0>
	<CFQUERY Name="ID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(ID) + 1 AS newid FROM SME
    </CFQUERY>

    <CFQUERY Name="AddID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO SME(ID)
    VALUES(#ID.newid#)
    </CFQUERY>

    <CFQUERY Name="Add" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE SME
    SET
    SME = '#Form.SME#'
    WHERE ID = #ID.newID#
    </CFQUERY>

    <cflocation url="SME.cfm?var=Add&value=#FORM.SME#" addtoken="no">
<cfelse>
	<cflocation url="SME.cfm?var=Duplicate&value=#FORM.SME#" ADDTOKEN="No">
</cfif>