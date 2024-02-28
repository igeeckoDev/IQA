<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Administration Actions - Table Maintenance">
<cfset subTItle2 = "Drop Indexes, Rename Tables, Add Indexes">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!---
<!--- Drop Constraint / Primary Key --->
<CFQUERY BLOCKFACTOR="100" NAME="DropConstraint" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_METRICS
DROP CONSTRAINT PK_GCAR_METRICS
</CFQUERY>

Index and Constraint removed from GCAR_Metrics table.<br /><br />
--->

<!--- Rename Tables --->
<CFQUERY BLOCKFACTOR="100" NAME="RenameOld" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Alter TABLE GCAR_METRICS RENAME TO GCAR_METRICS_OLD
</CFQUERY>

GCAR_Metrics Renamed to GCAR_Metrics_Old<br><br>

<CFQUERY BLOCKFACTOR="100" NAME="RenameNew" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Alter TABLE GCAR_METRICS_NEW RENAME TO GCAR_METRICS
</CFQUERY>

GCAR_Metrics_New Renamed to GCAR_Metrics<br><br>

<!---
<!--- Drop Index --->
<CFQUERY BLOCKFACTOR="100" NAME="DropIndex" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
DROP Index PK_GCAR_Metrics
</CFQUERY>

<!--- Create Unique Index --->
<CFQUERY BLOCKFACTOR="100" NAME="CreateIndex" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
CREATE UNIQUE INDEX UL06046.PK_GCAR_METRICS ON UL06046.GCAR_METRICS (docID, CARNumber)
</CFQUERY>

<!--- Add Constraint / Primary Key --->
<CFQUERY BLOCKFACTOR="100" NAME="AddConstraint" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE UL06046.GCAR_METRICS ADD CONSTRAINT PK_GCAR_METRICS PRIMARY KEY (docID, CARNumber)
</CFQUERY>
--->

<!--- Copy Current structure to --->
<CFQUERY BLOCKFACTOR="100" NAME="CopyTable" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
CREATE TABLE GCAR_METRICS_NEW AS SELECT * FROM GCAR_METRICS_TEMPLATE WHERE 1=2
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="CopyTable" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
CREATE TABLE GCAR_METRICS_NEWIMPORT AS SELECT * FROM GCAR_METRICS_TEMPLATE WHERE 1=2
</CFQUERY>

<!---
<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN ResponseAcceptanceDate
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_New
DROP COLUMN ResponseAcceptanceDate
</CFQUERY>
--->

<!---
<CFQUERY BLOCKFACTOR="100" NAME="RemoveColumn" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
ALTER TABLE GCAR_Metrics_NewImport
DROP COLUMN CARCHKREPEAT
</CFQUERY>
--->

<!--- /// --->

Create GCAR_Metrics_New structure from GCAR_Metrics_Template (structure only, no data) - so data can be directly imported during next refresh session.<br /><br />

<a href="AdminMenu_DataUpdate.cfm?complete=11">Return to Weekly Data Refresh Instructions</a>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->