<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cflock scope="SESSION" timeout="60">
<cfif IsDefined("SESSION.Auth.IsLoggedIn")>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Query">
SELECT ID FROM IQAPageViews
</cfquery>

<cfif query.recordcount gt 0>
	<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Query1">
	SELECT MAX(ID) + 1 AS newid FROM IQAPageViews
	</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Query2">
	INSERT INTO IQAPageViews(ID)
	VALUES (#Query1.newid#)
	</CFQUERY>
<cfelse>
	<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Query2">
	INSERT INTO IQAPageViews(ID)
	VALUES (1)
	</CFQUERY>
</cfif>


<cfquery BLOCKFACTOR="100" Datasource="Corporate" name="Log">
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
UPDATE IQAPageViews SET Server='#cgi.server_software# (#cgi.server_name# port #cgi.server_port#)', Protocol='#cgi.server_protocol#', Request='#cgi.request_method#', IP='#cgi.remote_addr#', Path='#cgi.path_info#', QueryString='#cgi.query_string#', Browser='#cgi.http_user_agent#', USER_='#SESSION.Auth.UserName#', LogDate='#curdate#', LogTime='#curtime#'
<cfif query.recordcount gt 0>
 WHERE ID = #Query1.newid#
<cfelse>
WHERE ID = 1
</cfif>
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>
</cfif>
</cflock>