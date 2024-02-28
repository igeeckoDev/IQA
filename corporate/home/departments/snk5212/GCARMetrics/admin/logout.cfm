<cflock scope="Session" timeout="5">
	<cfset structClear(Session)>
</cflock>

<cflocation url="#GCARMetricsDir#index.cfm" ADDTOKEN="No">