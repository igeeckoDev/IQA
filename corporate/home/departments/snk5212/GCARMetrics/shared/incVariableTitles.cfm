<cfoutput>
<cfif isDefined("URL.var")>
	<cfif url.var eq "CARAuditedRegion">
        <cfset Search = "CAR Audited Region">
    <cfelseif url.var eq "CAROwner">
        <cfset Search = "CAR Owner">
    <cfelseif url.var eq "CARSource">
        <cfset Search = "CAR Source">
    <cfelseif url.var eq "CARState">
        <cfset Search = "CAR State">
    <cfelseif url.var eq "CARSubType">
        <cfset Search = "Organization / Function">
    <cfelseif url.var eq "CARTypeNew">
        <cfset Search = "Process Impacted">
    <cfelseif url.var eq "CARSiteAudited">
        <cfset Search = "CAR Site Audited">
    <cfelseif url.var eq "CARRootCauseCategory">
        <cfset Search = "Root Cause Category">
    <cfelseif url.var eq "CARType">
        <cfset Search = "Standard Category">
    <cfelse>
    	<cfif cgi.SCRIPT_NAME eq "/departments/snk5212/GCARMetrics/qProgram_Grouping.cfm" 
			AND isDefined("URL.Group") AND url.Group eq "Yes">
        	<cfset Search = "Program Affected">
        <cfelse>
	        <cfset Search = "Full Table">
    	</cfif>
	</cfif>
</cfif>

<cfif isDefined("URL.var1")>
	<cfif url.var1 eq "CARAuditedRegion">
		<cfset Search1 = "CAR Audited Region">
	<cfelseif url.var1 eq "CAROwner">
		<cfset Search1 = "CAR Owner">
	<cfelseif url.var1 eq "CARSource">
		<cfset Search1 = "CAR Source">
	<cfelseif url.var1 eq "CARState">
		<cfset Search1 = "CAR State">
	<cfelseif url.var1 eq "CARSubType">
		<cfset Search1 = "Organization / Function">
	<cfelseif url.var1 eq "CARTypeNew">
		<cfset Search1 = "Process Impacted">
	<cfelseif url.var1 eq "CARSiteAudited">
		<cfset Search1 = "CAR Site Audited">
	<cfelseif url.var1 eq "CARRootCauseCategory">
		<cfset Search1 = "Root Cause Category">
	<cfelseif url.var1 eq "CARType">
		<cfset Search1 = "Standard Category">
    <cfelse>
		<cfset Search1 = "Full Table">
	</cfif>
</cfif>

<cfif isDefined("URL.var2")>
	<cfif url.var2 eq "CARAuditedRegion">
		<cfset Search2 = "CAR Audited Region">
	<cfelseif url.var2 eq "CAROwner">
		<cfset Search2 = "CAR Owner">
	<cfelseif url.var2 eq "CARSource">
		<cfset Search2 = "CAR Source">
	<cfelseif url.var2 eq "CARState">
		<cfset Search2 = "CAR State">
	<cfelseif url.var2 eq "CARSubType">
		<cfset Search2 = "Organization / Function">
	<cfelseif url.var2 eq "CARTypeNew">
		<cfset Search2 = "Process Impacted">
	<cfelseif url.var2 eq "CARSiteAudited">
		<cfset Search2 = "CAR Site Audited">
	<cfelseif url.var2 eq "CARRootCauseCategory">
		<cfset Search2 = "Root Cause Category">
	<cfelseif url.var2 eq "CARType">
		<cfset Search2 = "Standard Category">
    <cfelse>
		<cfset Search2 = "Full Table">
	</cfif>
</cfif>

<cfif isDefined("URL.var3")>
	<cfif url.var3 eq "CARAuditedRegion">
		<cfset Search3 = "CAR Audited Region">
	<cfelseif url.var3 eq "CAROwner">
		<cfset Search3 = "CAR Owner">
	<cfelseif url.var3 eq "CARSource">
		<cfset Search3 = "CAR Source">
	<cfelseif url.var3 eq "CARState">
		<cfset Search3 = "CAR State">
	<cfelseif url.var3 eq "CARSubType">
		<cfset Search3 = "Organization / Function">
	<cfelseif url.var3 eq "CARTypeNew">
		<cfset Search3 = "Process Impacted">
	<cfelseif url.var3 eq "CARSiteAudited">
		<cfset Search3 = "CAR Site Audited">
	<cfelseif url.var3 eq "CARRootCauseCategory">
		<cfset Search3 = "Root Cause Category">
	<cfelseif url.var3 eq "CARType">
		<cfset Search3 = "Standard Category">
    <cfelse>
		<cfset Search3 = "Full Table">
	</cfif>
</cfif>

<cfif isDefined("url.var4")>
	<cfif url.var4 eq "CARAuditedRegion">
		<cfset Search4 = "CAR Audited Region">
	<cfelseif url.var4 eq "CAROwner">
		<cfset Search4 = "CAR Owner">
	<cfelseif url.var4 eq "CARSource">
		<cfset Search4 = "CAR Source">
	<cfelseif url.var4 eq "CARState">
		<cfset Search4 = "CAR State">
	<cfelseif url.var4 eq "CARSubType">
		<cfset Search4 = "Organization / Function">
	<cfelseif url.var4 eq "CARTypeNew">
		<cfset Search4 = "Process Impacted">
	<cfelseif url.var4 eq "CARSiteAudited">
		<cfset Search4 = "CAR Site Audited">
	<cfelseif url.var4 eq "CARRootCauseCategory">
		<cfset Search4 = "Root Cause Category">
	<cfelseif url.var4 eq "CARType">
		<cfset Search4 = "Standard Category">
    <cfelse>
		<cfset Search4 = "Full Table">
	</cfif>
</cfif>

<cfif isDefined("url.var5")>
	<cfif url.var5 eq "CARAuditedRegion">
		<cfset Search5 = "CAR Audited Region">
	<cfelseif url.var5 eq "CAROwner">
		<cfset Search5 = "CAR Owner">
	<cfelseif url.var5 eq "CARSource">
		<cfset Search5 = "CAR Source">
	<cfelseif url.var5 eq "CARState">
		<cfset Search5 = "CAR State">
	<cfelseif url.var5 eq "CARSubType">
		<cfset Search5 = "Organization / Function">
	<cfelseif url.var5 eq "CARTypeNew">
		<cfset Search5 = "Process Impacted">
	<cfelseif url.var5 eq "CARSiteAudited">
		<cfset Search5 = "CAR Site Audited">
	<cfelseif url.var5 eq "CARRootCauseCategory">
		<cfset Search5 = "Root Cause Category">
	<cfelseif url.var5 eq "CARType">
		<cfset Search5 = "Standard Category">
    <cfelse>
		<cfset Search5 = "Full Table">
	</cfif>
</cfif>

<cfif isDefined("url.var6")>
	<cfif url.var6 eq "CARAuditedRegion">
		<cfset Search6 = "CAR Audited Region">
	<cfelseif url.var6 eq "CAROwner">
		<cfset Search6 = "CAR Owner">
	<cfelseif url.var6 eq "CARSource">
		<cfset Search6 = "CAR Source">
	<cfelseif url.var6 eq "CARState">
		<cfset Search6 = "CAR State">
	<cfelseif url.var6 eq "CARSubType">
		<cfset Search6 = "Organization / Function">
	<cfelseif url.var6 eq "CARTypeNew">
		<cfset Search6 = "Process Impacted">
	<cfelseif url.var6 eq "CARSiteAudited">
		<cfset Search6 = "CAR Site Audited">
	<cfelseif url.var6 eq "CARRootCauseCategory">
		<cfset Search6 = "Root Cause Category">
	<cfelseif url.var6 eq "CARType">
		<cfset Search6 = "Standard Category">
    <cfelse>
		<cfset Search6 = "Full Table">
	</cfif>
</cfif>

<cfif isDefined("url.var7")>
	<cfif url.var7 eq "CARAuditedRegion">
		<cfset Search7 = "CAR Audited Region">
	<cfelseif url.var7 eq "CAROwner">
		<cfset Search7 = "CAR Owner">
	<cfelseif url.var7 eq "CARSource">
		<cfset Search7 = "CAR Source">
	<cfelseif url.var7 eq "CARState">
		<cfset Search7 = "CAR State">
	<cfelseif url.var7 eq "CARSubType">
		<cfset Search7 = "Organization / Function">
	<cfelseif url.var7 eq "CARTypeNew">
		<cfset Search7 = "Process Impacted">
	<cfelseif url.var7 eq "CARSiteAudited">
		<cfset Search7 = "CAR Site Audited">
	<cfelseif url.var7 eq "CARRootCauseCategory">
		<cfset Search7 = "Root Cause Category">
	<cfelseif url.var7 eq "CARType">
		<cfset Search7 = "Standard Category">
    <cfelse>
		<cfset Search7 = "Full Table">
	</cfif>
</cfif>
</cfoutput>