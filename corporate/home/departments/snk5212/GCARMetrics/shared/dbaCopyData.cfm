<cfsetting requestTimeOut="300">

<CFQUERY BLOCKFACTOR="100" NAME="CopyData" Datasource="UL06046_IN">
INSERT INTO GCAR_METRICS_NEW
SELECT * FROM GCAR_METRICS_NEWIMPORT
</CFQUERY>

Copy GCAR_Metrics_NewImport to GCAR_Metrics_New:<br />

<CFQUERY BLOCKFACTOR="100" NAME="CountNewImport" Datasource="UL06046">
	SELECT Count(*) as Count FROM GCAR_METRICS_NEWImport
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="CountNew" Datasource="UL06046">
SELECT Count(*) as Count FROM GCAR_METRICS_NEW
</CFQUERY>

<cfoutput>GCAR_Metrics_NewImport: #CountNewImport.Count# records</cfoutput>

<cfoutput>GCAR_Metrics_New: #CountNew.Count# records</cfoutput><br />