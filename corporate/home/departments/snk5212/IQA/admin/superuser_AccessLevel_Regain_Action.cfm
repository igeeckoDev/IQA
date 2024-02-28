<cflock scope="session" timeout="5">
	<cfset SESSION.Auth.AccessLevel = "SU">
   	<cfset SESSION.Auth.Region = "None">
    <cfset SESSION.Auth.SubRegion = "None">
</cflock>

<cflocation url="superuser_AccessLevel_Regain.cfm" addtoken="no">