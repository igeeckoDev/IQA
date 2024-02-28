<!--- CAROwnerReportingLocation --->
<CFQUERY BLOCKFACTOR="100" NAME="qData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count FROM GCAR_Metrics_New
WHERE CAROwnerReportingLocation IS NULL
</cfquery>

CAROwnerReportingLocation Null<br>
<cfoutput>#qData.Count#</cfoutput><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE GCAR_Metrics_New
SET
CAROwnerReportingLocation = 'None Listed'
WHERE CAROwnerReportingLocation IS NULL
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="qData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count FROM GCAR_Metrics_New
WHERE CAROwnerReportingLocation = 'None Listed'
</cfquery>

CAROwnerReportingLocation None Listed<br>
<cfoutput>#qData.Count#</cfoutput><br><br>
<!--- /// --->

<!--- CARTypeNew --->
<CFQUERY BLOCKFACTOR="100" NAME="qData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count FROM GCAR_Metrics_New
WHERE CARTypeNew IS NULL
</cfquery>

CARTypeNew Null<br>
<cfoutput>#qData.Count#</cfoutput><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE GCAR_Metrics_New
SET
CARTypeNew = 'None Listed'
WHERE CARTypeNew IS NULL
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="qData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count FROM GCAR_Metrics_New
WHERE CARTypeNew = 'None Listed'
</cfquery>

CARTypeNew None Listed<br>
<cfoutput>#qData.Count#</cfoutput><br><br>

<!--- CAR Root Cause Category --->
<CFQUERY BLOCKFACTOR="100" NAME="qData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count FROM GCAR_Metrics_New
WHERE CARRootCauseCategory IS NULL
</cfquery>

CARRootCauseCategory Null<br>
<cfoutput>#qData.Count#</cfoutput><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE GCAR_Metrics_New
SET
CARRootCauseCategory = 'None Listed'
WHERE CARRootCauseCategory IS NULL
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="qData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count FROM GCAR_Metrics_New
WHERE CARRootCauseCategory = 'None Listed'
</cfquery>

CARRootCauseCategory None Listed<br>
<cfoutput>#qData.Count#</cfoutput>

<!--- Geography --->
<CFQUERY BLOCKFACTOR="100" NAME="qData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count FROM GCAR_Metrics_New
WHERE CARGeography IS NULL
</cfquery>

CARGeography Null<br>
<cfoutput>#qData.Count#</cfoutput><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE GCAR_Metrics_New
SET
CARGeography = 'None Listed'
WHERE CARGeography IS NULL
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="qData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count FROM GCAR_Metrics_New
WHERE CARGeography = 'None Listed'
</cfquery>

CARGeography None Listed<br>
<cfoutput>#qData.Count#</cfoutput><br><br>
<!--- /// --->

<cflocation url="AdminMenu_DataUpdate.cfm?complete=6" addtoken="no">