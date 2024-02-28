<CFQUERY BLOCKFACTOR="100" NAME="Agrate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSiteAudited
FROM GCAR_Metrics_New
WHERE CARSiteAudited = 'ABM - Agrate Brianza, Milan, Italy'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="AgrateUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSiteAudited = 'MIL - Milan, Italy'

WHERE 
CARSiteAudited = 'ABM - Agrate Brianza, Milan, Italy'
</cfquery>

<cfoutput>#Agrate.recordcount# records updated from CARSiteAudited = 'ABM - Agrate Brianza, Milan, Italy' to CARSiteAudited = 'MIL - Milan, Italy'</cfoutput><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="Carugate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARSiteAudited
FROM GCAR_Metrics_New
WHERE CARSiteAudited = 'CRM - Carugate, Milan, Italy (Sicur Control)'
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CarugateUpdate" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Update GCAR_Metrics_New
SET
CARSiteAudited = 'MIL - Milan, Italy'

WHERE 
CARSiteAudited = 'CRM - Carugate, Milan, Italy (Sicur Control)'
</cfquery>

<cfoutput>#Carugate.recordcount# records updated from CARSiteAudited = 'CRM - Carugate, Milan, Italy (Sicur Control)' to CARSiteAudited = 'MIL - Milan, Italy'</cfoutput><br><br>