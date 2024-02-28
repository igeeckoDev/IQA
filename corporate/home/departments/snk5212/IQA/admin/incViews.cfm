<cfinclude template="../footer.cfm">
<cfif cgi.remote_addr is NOT "10.40.118.45" AND cgi.remote_addr is NOT "10.40.118.53" AND cgi.remote_addr is NOT "10.40.106.138">
	<cfif cgi.path_info is "#thispath#admin.cfm">
	<cfelseif cgi.path_info is "#thispath#global_login.cfm">
	<cfelseif cgi.path_info is "#thispath#global_login2.cfm">
	<cfelse>
		<cfinclude template="views.cfm">
	</cfif>
</cfif>