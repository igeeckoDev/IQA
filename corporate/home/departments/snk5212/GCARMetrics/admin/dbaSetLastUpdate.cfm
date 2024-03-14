<cfset PostedDate = DateFormat(DateAdd("d", -1, now()),"mm/dd/yyyy")>

<cfquery datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#" name="maxID">
SELECT MAX(ID)+1 as newID
FROM GCAR_METRICS_LastUpdate
</cfquery>

<cfquery datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#" name="lastUpdate">
INSERT INTO GCAR_METRICS_lastUpdate(ID, PostedDate)
VALUES(#maxID.newID#,  #CreateODBCDate(PostedDate)#)
</cfquery>

<cfmail
	to="Cheryl.Allison@ul.com, Joe.Taylor@ul.com"
    bcc="Christopher.J.Nicastro@ul.com"
    replyto="Christopher.J.Nicastro@ul.com"
    from="Internal.Quality_Audits@ul.com"
    subject="GCAR Metrics Website - Data Refreshed"
    type="html"><cfoutput>
    The GCAR Metrics Website Data has been refreshed through #DateFormat(DateAdd("d", -1, now()),"mm/dd/yyyy")#.<br /><br />

    This is an automated message that sends immediately after the Data Refresh. Please contact Christopher Nicastro with any questions or issues.<br /><br />

    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/GCARMetrics/index.cfm">GCAR Metrics Website</a></cfoutput>
</cfmail>

<cflocation url="AdminMenu_DataUpdate.cfm?complete=12" addtoken="no">