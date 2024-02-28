<cfoutput query="Audit">
<b>Audit Number</b><br />
<a href="#IQADir#TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#">#URL.Year#-#URl.ID#-Technical Audit</a><br /><br />

<b>Technical Audit Identifier</b><br />
	<cfif AuditType2 eq "Full">
        <cfset AuditTypeID = "F">
    <cfelse>
        <cfset AuditTypeID = "P">
    </cfif>
    
    <cfif RequestType eq "Test">
    	<cfset RequestTypeID = "T">
    <cfelse>
    	<cfset RequestTypeID = "N">
    </cfif>

	<cfset AuditorLoc = #right(AuditorDept, 3)#>
    
    <cfset ReviewLoc = #right(ProjectHandlerDept, 3)#>

    #ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#
    <cfset varAuditIdentifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#">
</cfoutput>
<br><Br>