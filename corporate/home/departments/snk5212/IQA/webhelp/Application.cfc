<cfcomponent output="false" extends="IQA.Application">
<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false">
	<cfargument name="Page" type="string" required="true">

	<cfif SUPER.OnRequestStart( ARGUMENTS.Page )>
    <!--- Store the sub root directory folder. --->
        <cfset REQUEST.SubDirectory = GetDirectoryFromPath(GetCurrentTemplatePath()) />
    <!--- Return out. --->
        <cfreturn true />
    <cfelse>
    <!--- The root application returned false for this page request. 
	Therefore, we want to return false to honor that logic. --->
        <cfreturn false />
    </cfif>

</cffunction>
</cfcomponent>