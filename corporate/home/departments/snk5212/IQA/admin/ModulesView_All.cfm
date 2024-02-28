<!--- Start of Page File --->
<cfset subTitle = "Application Modules - View All">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationNames.AppName as AppName, ApplicationModules.ModuleName as ModuleName
FROM ApplicationModules, ApplicationNames
WHERE ApplicationModules.aID = ApplicationNames.aID
ORDER BY ApplicationNames.AppName, ApplicationModules.ModuleName
</CFQUERY>

<cfset AppHolder=""> 

<cfoutput query="ViewModules">
    <cfif AppHolder IS NOT AppName> 
    <cfIf AppHolder is NOT ""><br></cfif>
    <b><u>#AppName#</u></b><br> 
    </cfif>
    
	 :: #ModuleName#<br>

    <!---
    :: #FileName#<br />
    <cfif len(Notes)>#Notes#<cfelse>No Notes<br /><br /></cfif>
    --->
    
    <cfset AppHolder = AppName>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->