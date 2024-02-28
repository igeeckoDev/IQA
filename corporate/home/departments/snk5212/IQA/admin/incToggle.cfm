<cfoutput>
	<cfset PublicFile = #Replace(CGI.PATH_INFO, "admin/", "")#>
	<a href="#PublicFile#?#CGI.QUERY_STRING#">Public View</a> of this page<Br>
</cfoutput>