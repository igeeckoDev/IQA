<cflock scope="Session" timeout="5">
	<cfif cgi.remote_addr is "10.40.118.45" OR cgi.remote_addr is "10.40.118.53" OR cgi.remote_addr is "10.40.106.138" OR cgi.remote_addr is "10.40.118.42">
		<!--- The IPs listed above have been web crawlers and automated search engines - do not report errors from their activity --->
	<cfelse>
		<cfinclude template="#IQADir#error_handler_details.cfm">
	</cfif>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->