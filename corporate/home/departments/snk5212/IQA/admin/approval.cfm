<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
<CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE Approved <> 'Yes'
	AND status IS NULL
	ORDER By AuditedBy, ID
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "RQM" OR SESSION.Auth.AccessLevel is "OQM" or SESSION.Auth.AccessLevel is "Field Services">
<CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE AuditedBy = '#SESSION.AUTH.SubRegion#'
	AND Approved <> 'Yes'
	AND status IS NULL
	ORDER By AuditedBy, ID
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "AS">
<CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE AuditedBy = 'AS'
	AND Approved <> 'Yes'
	AND status IS NULL
	ORDER By AuditedBy, ID
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "Finance">
<CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE AuditedBy = 'Finance'
	AND Approved <> 'Yes'
	AND status IS NULL
	ORDER By AuditedBy, ID
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "QRS">
<CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE AuditedBy = 'QRS'
	AND Approved <> 'Yes'
	AND status IS NULL
	ORDER By AuditedBy, ID
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "Laboratory Technical Audit">
<CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE AuditedBy = 'LAB'
	AND Approved <> 'Yes'
	AND status IS NULL
	ORDER By AuditedBy, ID
</cfquery>
<cfelseif SESSION.Auth.AccessLevel is "IQAAuditor">
<CFQUERY BLOCKFACTOR="100" NAME="NotApproved" Datasource="Corporate">
	SELECT * FROM AuditSchedule
	WHERE LeadAuditor = '#SESSION.Auth.Name#'
	AND Approved <> 'Yes'
	AND status IS NULL
	ORDER By AuditedBy, ID
</cfquery>
<cfelse>
	<cfset NotApproved.recordcount = 0>
</cfif>

<cfif SESSION.Auth.AccessLevel NEQ "CPO">
	<cfif NotApproved.recordcount gt 0>
		<cfoutput>
			<font color="red">
            	<b>#notapproved.recordcount# audits are awaiting approval</b>
            </font> :: <a href="NotApproved.cfm">view</a><br>
		</cfoutput>
	</cfif>
</cfif>
</cflock>