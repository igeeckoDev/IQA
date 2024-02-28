<cflock scope="Session" timeout="5">
	<cfif SESSION.Auth.Andon NEQ "Yes">
		<cflocation url="authorization.cfm?page=Andon" addtoken="no">
	</cfif>
</cflock>