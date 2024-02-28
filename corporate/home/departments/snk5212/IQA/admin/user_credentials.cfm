:: <a href="logout.cfm">Log Out</a> - 

<cfoutput>
<cflock scope="SESSION" timeout="60">
	#SESSION.AUTH.Name# - #SESSION.Auth.accesslevel# <cfif SESSION.Auth.AccessLevel is "RQM">(#SESSION.Auth.SubRegion#)</cfif><br><br>
	<cfif SESSION.Auth.AccessLevel NEQ "Auditor" OR SESSION.Auth.AccessLevel NEQ "CPO">
        	<cfinclude template="approval.cfm"><br><br>
	</cfif>
</cflock>
</cfoutput>