<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
		<cfoutput>
			<cfset AdminFile = #Replace(CGI.PATH_INFO, "#IQARootDir#", "")#>
            You are currently logged in as: <b>#SESSION.Auth.Username#</b><br>
			Return to <a href="admin/#AdminFile#?#CGI.QUERY_STRING#">Admin Section</a><Br>
		</cfoutput>
	</cfif>
</cflock>