<CFQUERY BLOCKFACTOR="100" NAME="Find" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSiteAudited 
FROM GCAR_Metrics_New
WHERE CARSiteAudited = 'Ottawa - SDO'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Update" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSiteAudited = 'Ottawa, Canada - SDO'

WHERE 
CARSiteAudited = 'Ottawa - SDO'
</cfquery>

<cfoutput>#Find.recordcount# records updated from CARSiteAudited='Ottawa - SDO' to CARSiteAudited='Ottawa, Canada - SDO'</cfoutput><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="Find2" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CAROwnerReportingLocation
FROM GCAR_Metrics_New
WHERE CAROwnerReportingLocation = 'Ottawa - SDO'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Update2" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CAROwnerReportingLocation = 'Ottawa, Canada - SDO'

WHERE 
CAROwnerReportingLocation = 'Ottawa - SDO'
</cfquery>

<cfoutput>#Find2.recordcount# records updated from CAROwnerReportingLocation='Ottawa - SDO' to CAROwnerReportingLocation='Ottawa, Canada - SDO'</cfoutput><br><br>