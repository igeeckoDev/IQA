<CFQUERY BLOCKFACTOR="100" NAME="checkNewTable" Datasource="UL06046_IN">
SELECT * FROM GCAR_METRICS_NEW
</CFQUERY>

<cfdump var="#checkNewTable#">

<cfoutput>#checkNewTable.recordcount#</cfoutput>