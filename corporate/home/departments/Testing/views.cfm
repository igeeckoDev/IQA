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

<cfif len(cgi.QUERY_STRING) gte 255>
	<cfset qs = #Left(cgi.QUERY_STRING, 255)#>
<cfelse>
	<cfset qs = #cgi.QUERY_STRING#>
</cfif>

<cfquery BLOCKFACTOR="100" Datasource="Corporate" name="Log">
UPDATE IQAPageViews SET Server='#cgi.server_software# (#cgi.server_name# port #cgi.server_port#)', Protocol='#cgi.server_protocol#', Request='#cgi.request_method#', IP='#cgi.remote_addr#', Path='#cgi.path_info#', QueryString='#qs#', Browser='#cgi.http_user_agent#', USER_='#cgi.remote_addr#', LogDate='#curdate#', LogTime='#curtime#'
<cfif query.recordcount gt 0>
 WHERE ID = #Query1.newid#
<cfelse>
WHERE ID = 1
</cfif>
</cfquery>