<cfif structKeyExists(form,'submit') >
	<cfdump var="#Form#"><br><br>

<Cfoutput>
	<a href="AuditPlanning.cfm?#CGI.Query_String#">Go</a>
</cfoutput>
</cfif>