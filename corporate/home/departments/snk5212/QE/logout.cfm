<cflock scope="Session" timeout="60">
	<cfset structClear(Session)>
</cflock>

<cflocation url="index.cfm" addtoken="No">