<!--- Start of Page File --->
<cfset subTitle = "Application Modules - View All Applications, Modules, and Pages">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ViewModules" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ApplicationNames.AppName as AppName, ApplicationModules.ModuleName as ModuleName, ApplicationPages.FileName as FileName, ApplicationPages.Notes as Notes, ApplicationNames.aID as aID, ApplicationModules.mID as mID, ApplicationPages.pID as pID
FROM ApplicationModules, ApplicationNames, ApplicationPages
WHERE ApplicationModules.aID = ApplicationNames.aID
AND ApplicationPages.mID = ApplicationModules.mID

ORDER BY ApplicationNames.AppName, ApplicationModules.ModuleName, UPPER(ApplicationPages.FileName)
</CFQUERY>

<cfset AppHolder=""> 
<cfset ModHolder=""> 

<cfoutput query="ViewModules">
    <cfif AppHolder IS NOT AppName>
    	<cfif len(AppHolder)><br /></cfif>
        <b><u>#AppName#</u></b> - <a href="modulesView.cfm?aID=#aID#"><img src="#SiteDir#SiteImages/ico_article.gif" border="0" /></a>
    </cfif>
    
    <cfif ModHolder IS NOT ModuleName> 
    	<br />
        <u>#ModuleName#</u> - <a href="modulesView_Details.cfm?mID=#mID#"><img src="#SiteDir#SiteImages/ico_article.gif" border="0" /></a><br> 
    </cfif>
    
    :: #FileName# - <a href="modulesView_FileView.cfm?pID=#pID#&mID=#mID#"><img src="#SiteDir#SiteImages/ico_article.gif" border="0" /></a>
	<cfif NOT len(Notes)><b>N</b></cfif><br />
    <!---
		<cfif len(Notes)>#Notes#<cfelse>No Notes<br /><br /></cfif>
    --->
	
    <cfset AppHolder = AppName>
	<cfset ModHolder = ModuleName>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->