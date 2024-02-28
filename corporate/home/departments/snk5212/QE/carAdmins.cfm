<!--- Start of Page File --->
<cfset subTitle = "FAQ - CAR Administrator Related Items">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<div class="blog-content">
    Currently Viewing CAR Process FAQ: 
    <cfif CGI.SCRIPT_Name is "/departments/snk5212/qe/carOwners.cfm" 
        or CGI.SCRIPT_Name is "/departments/snk5212/qe/admin/carOwners.cfm">
        
        [<a href="FAQ.cfm">All</a>] [<a href="carAdmins.cfm">CAR Admin Related</a>] [<b>CAR Owner Related</b>]<br />
    
    <cfelseif CGI.SCRIPT_Name is "/departments/snk5212/qe/carAdmins.cfm" 
        or CGI.SCRIPT_Name is "/departments/snk5212/qe/admin/carAdmins.cfm">
    
        [<a href="FAQ.cfm">All</a>] [<b>CAR Admin Related</b>] [<a href="carOwners.cfm">CAR Owner Related</a>]<br />
    
    <cfelse>
        [<b>All</b>] [<a href="carAdmins.cfm">CAR Admin Related</a>] [<a href="carOwners.cfm">CAR Owner Related</a>]<br />        
    </cfif>
</div><Br />

<cfinclude template="inc_TOP.cfm">
			
<cfinclude template="#CARRootDir#qCarOwners.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->