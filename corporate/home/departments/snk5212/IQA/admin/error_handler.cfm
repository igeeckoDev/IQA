<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#SiteTitle# - Error Handling">
<cfinclude template="SOP.cfm">

<!--- / --->

<cflock scope="Session" timeout="5">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.UserName eq "Chris">
		<cfinclude template="../error_handler_details_cjn.cfm">
	<cfelseif cgi.remote_addr is "10.40.118.45" OR cgi.remote_addr is "10.40.118.53" OR cgi.remote_addr is "10.40.106.138">
		<cfinclude template="../error_handler_details_robots.cfm">
	<cfelse>
		<cfinclude template="../error_handler_details.cfm">
	</cfif>
</cflock>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->