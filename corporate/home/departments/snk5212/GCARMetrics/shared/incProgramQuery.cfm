<cfoutput>
<cfif isDefined("URL.Program") AND URL.Program NEQ "null">
	<cfif url.Program eq "UL Mark">
	<!--- all iterations of UL Mark and ULI Mark in a string --->
    	<!--- OLD 
		(CARProgramAffected LIKE '%UL Mark%' 
		OR CARProgramAffected LIKE '%ULI Mark%')
		--->
		<!--- New --->
	    CARProgramAffected NOT LIKE '%c-UL Mark%' 
		AND CARProgramAffected NOT LIKE '%UL Mark for%' 
		AND (CARProgramAffected LIKE '%ULI Mark%' OR CARProgramAffected LIKE '%UL Mark%')
		<!--- /// --->
	<!--- /// --->
	AND
	<cfelse>
	CARProgramAffected LIKE '%#url.Program#%' AND
	</cfif>
</cfif>
</cfoutput>