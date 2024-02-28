<cfcomponent output="false" extends="IQA.Application">
<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false">
	<cfargument name="Page" type="string" required="true" >

	<cfif SUPER.OnRequestStart( ARGUMENTS.Page )>
    <!--- Store the sub root directory folder. --->
        <cfset REQUEST.SubDirectory = GetDirectoryFromPath(GetCurrentTemplatePath()) />
        
		<cfset space = "&nbsp;&nbsp;&nbsp; ::">
        <cfset Request.GCARLink = "notes:///86256F150051C1B0/3774B2FEF3E17F3086256F8C005C3F45/">
		<cfset Request.MetaKeywords = "Quality, IQA, Accreditations, UL Sites, Laboratories, Certification, Inspection, Audits, Internal Quality Audits, Corporate Quality">
		<cfset Request.MetaDescription = "description">
        <cfset Request.SiteTitle = "IQA - Audit Planning">
		<cfset Request.Development = "No">
    <!--- Return out. --->
        <cfreturn true />
    <cfelse>
    <!--- The root application returned false for this page request. 
	Therefore, we want to return false to honor that logic. --->
        <cfreturn false />
    </cfif>

</cffunction>
</cfcomponent>