<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="mID">
SELECT MAX(ID) +1 AS NewID FROM IndexMission
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="mQuery"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
INSERT INTO IQADB_INDEX Mission (ID)
VALUES (#mID.NewID#)
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="updateMission" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
UPDATE IQADB_INDEX Mission SET 
RevDate='#FORM.RevDate#',
Mission='#FORM.Mission#'
WHERE ID=#mID.newid#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cflocation url="admin.cfm" addtoken="no">