<cflock scope="session" timeout="5">
	<cfset SESSION.Auth.AccessLevel = "#URL.AccessLevel#">
    <cfif URL.AccessLevel eq "RQM">
    	<cfset SESSION.Auth.Region = "#URL.Region#">
	<cfif isDefined("URL.SubRegion")>
	        <cfset SESSION.Auth.SubRegion = "#URL.SubRegion#">
	<cfelse>
		<cfset SESSION.Auth.SubRegion = "">
	</cfif>    
</cfif> 
</cflock>

<cflocation url="superuser_AccessLevel_Change_Process.cfm" addtoken="no">
