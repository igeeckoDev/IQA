<cfsetting requestTimeOut="300">

<CFQUERY BLOCKFACTOR="100" NAME="CopyData" Datasource="UL06046_IN">
INSERT INTO GCAR_METRICS_NEW
SELECT * FROM GCAR_METRICS_NEWIMPORT
</CFQUERY>

<cflocation url="AdminMenu_DataUpdate.cfm?complete=2" addtoken="no">