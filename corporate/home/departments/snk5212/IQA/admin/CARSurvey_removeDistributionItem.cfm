<CFQUERY Name="Update" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE
    CARSurvey_distributionDetails
SET
    status = 'removed'
WHERE
    ID = #URL.ID#
</CFQUERY>

<cflocation url="CARSurvey_manageDistribution.cfm?ID=#URL.dID#" addtoken="no">