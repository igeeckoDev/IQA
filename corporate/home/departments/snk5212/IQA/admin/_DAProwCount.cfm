<CFQUERY BLOCKFACTOR="100" name="All" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as rowCountAll, MAX(ID) as maxID
FROM xSNAPData
</cfquery>

<cfoutput>
Total Rows: #All.rowCountAll#<br>
Max ID: #All.maxID#<br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="Count" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as rowCount, AuditID, AuditOfficeNameID, AuditMonth
FROM xSNAPDATA
GROUP BY AuditID, AuditOfficeNameID, AuditMonth
ORDER BY AuditMonth, AuditID
</cfquery>

<cfoutput query="Count">
2010-#AuditID#-#AuditOfficeNameID# - #rowCount# (#MonthAsString(AuditMonth)#)<br>
</cfoutput>