<cfif Form.Resched is "Cancel Request">
	<cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">
<cfelseif form.resched is "Confirm Request">

    <CFQUERY BLOCKFACTOR="100" NAME="Notes" Datasource="Corporate"> 
    SELECT *
    FROM TechnicalAudits_AuditSchedule
    WHERE ID = #URL.ID#
    AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </cfquery>

    <CFQUERY BLOCKFACTOR="100" NAME="delete" Datasource="Corporate">
    UPDATE TechnicalAudits_AuditSchedule
    SET 
    Status='removed',
    <cfset N = #ReplaceNoCase(Form.Notes,chr(13),"<br>", "ALL")#>
    Notes='#Notes.Notes#<br><br>#N#'	
    WHERE ID = #URL.ID#
    and Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </cfquery>
    
    <CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="Corporate">
    SELECT *
    FROM TechnicalAudits_AuditSchedule
    WHERE ID = #URL.ID#
    AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
    </cfquery>
    
	<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

	<!--- tam, rom, sqm, who else? --->
    <cfmail 
        to="any@emailtest1.com" 
        cc="#Request.TechnicalAuditMailbox#" 
        from="#Request.TechnicalAuditMailbox#" 
        replyto="#replyTo#"
        subject="Audit Cancelled - #varAuditIdentifier#"
        query="Audit" 
        type="HTML">
        The following audit has been cancelled:<br><br>

        <u>Audit</u>: #url.year#-#url.id# / #varAuditIdentifier#<br>
        <u>Audit Details</u>: #request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_AuditDetails.cfm?ID=#ID#&Year=#Year#<br><br>

        <u>Cancellation Comments</u>: #N#<br /><br />

        Please contact TAM's with any questions or issues.
    </cfmail>
    
	<cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">
</cfif>