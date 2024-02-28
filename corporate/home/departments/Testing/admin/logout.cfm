<cflock scope="Session" timeout="5">
	<cflog application="no" 
	   file="IQA" 
	   text="Logout - #SESSION.Auth.Username#" 
	   type="Information">
	
	<cfset structClear(Session)>
</cflock>

<cfif isDefined("URL.Type") AND URL.Type eq "TAD">
	<cflocation url="#URL.Page#?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
<cfelse>
	<cflocation url="../" ADDTOKEN="No">
</cfif>