<!--- Start of Page File --->
<cfset subTitle = "CAR Administrator Profiles">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<a href="getCARAdminEmailList.cfm">CAR Admin Email List</a> (For Active and In Training Status)<br><Br>

<cfinclude template="#CARRootDir#qCARAdminList.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->