<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Administration Actions - Update GCAR Metrics Script 7">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

1. Remove History Column - Done<br />
2. Copy Data from NewImport to New table - Done<br />
3. Drop NewImport Table - Done<br />
3a. Remove Duplicate CARs - Done<br />
4. Field Updates - Done<br />
5. More Field Updates - Done<br />
6. Trim Fields - Done<Br>
7a. Drop Old Table, Rename Tables, Copy Structure to New table -

<!--- Drop old table --->
<CFQUERY BLOCKFACTOR="100" NAME="DropTable" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Drop TABLE GCAR_Metrics_Old
</CFQUERY>

<!--- Rename Tables --->
<CFQUERY BLOCKFACTOR="100" NAME="RenameOld" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Alter TABLE GCAR_METRICS RENAME TO GCAR_METRICS_OLD
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="RenameNew" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
Alter TABLE GCAR_METRICS_NEW RENAME TO GCAR_METRICS
</CFQUERY>

<!--- Copy Current structure to --->
<CFQUERY BLOCKFACTOR="100" NAME="CopyTable" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
CREATE TABLE GCAR_METRICS_NEW AS SELECT * FROM GCAR_METRICS_TEMPLATE WHERE 1=2
</CFQUERY>
<!--- /// --->

Done<br>

8. Create GCAR_Metrics_New structure from GCAR_Metrics_Template (structure only, no data) - so data can be directly imported during next refresh session - Done<br />

<cfset PostedDate = DateFormat(DateAdd("d", -1, now()),"mm/dd/yyyy")>

<cfquery datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#" name="maxID">
SELECT MAX(ID)+1 as newID
FROM GCAR_METRICS_LastUpdate
</cfquery>

<cfquery datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#" name="lastUpdate">
INSERT INTO GCAR_METRICS_lastUpdate(ID, PostedDate)
VALUES(#maxID.newID#,  #CreateODBCDate(PostedDate)#)
</cfquery>

9. Last Update Value Set - Done<br />

<cfmail
	to="Cheryl.Allison@ul.com, Laura.Elan@ul.com"
    bcc="Christopher.J.Nicastro@ul.com"
    replyto="Christopher.J.Nicastro@ul.com"
    from="Internal.Quality_Audits@ul.com"
    subject="GCAR Metrics Website - Data Refreshed"
    type="html"><cfoutput>
    The GCAR Metrics Website Data has been refreshed through #DateFormat(DateAdd("d", -1, now()),"mm/dd/yyyy")#.<br /><br />

    This is an automated message that sends immediately after the Data Refresh. Please contact Christopher Nicastro with any questions or issues.<br /><br />

    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/GCARMetrics/index.cfm">GCAR Metrics Website</a></cfoutput>
</cfmail>

10. Email to Cheryl Allison and Laura Elan sent (notifies of Metrics update) - Done<br /><br />

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->