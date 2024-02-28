<cfoutput>
    <cfif isDefined("URL.FunctionField")>
        <cfif url.FunctionField eq "CARAuditedRegion">
            <cfset FunctionFieldName = "CAR Audited Region">
        <cfelseif url.FunctionField eq "CARType">
            <cfset FunctionFieldName = "Standard Category">
        <cfelseif url.FunctionField eq "CARProgramAffected">
            <cfset FunctionFieldName = "Program Affected">
        <cfelseif url.FunctionField eq "CAROwner">
            <cfset FunctionFieldName = "CAR Owner">
        <cfelseif url.FunctionField eq "CARSource">
            <cfset FunctionFieldName = "CAR Source">
        <cfelseif url.FunctionField eq "CARState">
            <cfset FunctionFieldName = "CAR State">
        <cfelseif url.FunctionField eq "CARSubType">
            <cfset FunctionFieldName = "Organization / Function">
        <cfelseif url.FunctionField eq "CARTypeNew">
            <cfset FunctionFieldName = "Process Impacted">
        <cfelseif url.FunctionField eq "CARSiteAudited">
            <cfset FunctionFieldName = "CAR Site Audited">
        <cfelseif url.FunctionField eq "CARRootCauseCategory">
            <cfset FunctionFieldName = "Root Cause Category">
        </cfif>
    </cfif>
  
    <cfif isDefined("FunctionField")>
        <cfif FunctionField eq "CARAuditedRegion">
            <cfset FunctionFieldName = "CAR Audited Region">
        <cfelseif FunctionField eq "CARType">
            <cfset FunctionFieldName = "Standard Category">
        <cfelseif FunctionField eq "CARProgramAffected">
            <cfset FunctionFieldName = "Program Affected">
        <cfelseif FunctionField eq "CAROwner">
            <cfset FunctionFieldName = "CAR Owner">
        <cfelseif FunctionField eq "CARSource">
            <cfset FunctionFieldName = "CAR Source">
        <cfelseif FunctionField eq "CARState">
            <cfset FunctionFieldName = "CAR State">
        <cfelseif FunctionField eq "CARSubType">
            <cfset FunctionFieldName = "Organization / Function">
        <cfelseif FunctionField eq "CARTypeNew">
            <cfset FunctionFieldName = "Process Impacted">
        <cfelseif FunctionField eq "CARSiteAudited">
            <cfset FunctionFieldName = "CAR Site Audited">
        <cfelseif FunctionField eq "CARRootCauseCategory">
            <cfset FunctionFieldName = "Root Cause Category">
        </cfif>
    </cfif>

	<cfif isDefined("URL.SortField")>
        <cfif url.SortField eq "CARAuditedRegion">
            <cfset SortFieldName = "CAR Audited Region">
        <cfelseif url.SortField eq "CARType">
            <cfset SortFieldName = "Standard Category">
		<cfelseif url.SortField eq "CARProgramAffected">
            <cfset SortFieldName = "Program Affected">
        <cfelseif url.SortField eq "CAROwner">
            <cfset SortFieldName = "CAR Owner">
        <cfelseif url.SortField eq "CARSource">
            <cfset SortFieldName = "CAR Source">
        <cfelseif url.SortField eq "CARState">
            <cfset SortFieldName = "CAR State">
        <cfelseif url.SortField eq "CARSubType">
            <cfset SortFieldName = "Organization / Function">
        <cfelseif url.SortField eq "CARTypeNew">
            <cfset SortFieldName = "Process Impacted">
        <cfelseif url.SortField eq "CARSiteAudited">
            <cfset SortFieldName = "CAR Site Audited">
        <cfelseif url.SortField eq "CARRootCauseCategory">
            <cfset SortFieldName = "Root Cause Category">
        </cfif>
    </cfif>
    
	<cfif isDefined("SortField")>
        <cfif SortField eq "CARAuditedRegion">
            <cfset SortFieldName = "CAR Audited Region">
        <cfelseif SortField eq "CARType">
            <cfset SortFieldName = "Standard Category">
		<cfelseif SortField eq "CARProgramAffected">
            <cfset SortFieldName = "Program Affected">
        <cfelseif SortField eq "CAROwner">
            <cfset SortFieldName = "CAR Owner">
        <cfelseif SortField eq "CARSource">
            <cfset SortFieldName = "CAR Source">
        <cfelseif SortField eq "CARState">
            <cfset SortFieldName = "CAR State">
        <cfelseif SortField eq "CARSubType">
            <cfset SortFieldName = "Organization / Function">
        <cfelseif SortField eq "CARTypeNew">
            <cfset SortFieldName = "Process Impacted">
        <cfelseif SortField eq "CARSiteAudited">
            <cfset SortFieldName = "CAR Site Audited">
        <cfelseif SortField eq "CARRootCauseCategory">
            <cfset SortFieldName = "Root Cause Category">
        </cfif>
    </cfif>
    
	<cfif isDefined("Reports.SortField")>
        <cfif Reports.SortField eq "CARAuditedRegion">
            <cfset SortFieldName = "CAR Audited Region">
        <cfelseif Reports.SortField eq "CARType">
            <cfset SortFieldName = "Standard Category">
		<cfelseif Reports.SortField eq "CARProgramAffected">
            <cfset SortFieldName = "Program Affected">
        <cfelseif Reports.SortField eq "CAROwner">
            <cfset SortFieldName = "CAR Owner">
        <cfelseif Reports.SortField eq "CARSource">
            <cfset SortFieldName = "CAR Source">
        <cfelseif Reports.SortField eq "CARState">
            <cfset SortFieldName = "CAR State">
        <cfelseif Reports.SortField eq "CARSubType">
            <cfset SortFieldName = "Organization / Function">
        <cfelseif Reports.SortField eq "CARTypeNew">
            <cfset SortFieldName = "Process Impacted">
        <cfelseif Reports.SortField eq "CARSiteAudited">
            <cfset SortFieldName = "CAR Site Audited">
        <cfelseif Reports.SortField eq "CARRootCauseCategory">
            <cfset SortFieldName = "Root Cause Category">
        </cfif>
    </cfif>
</cfoutput>