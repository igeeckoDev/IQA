<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Request.SiteTitle# - Quality Engineering Related Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("URL.Category")>
	<cfif URL.Category eq "Auditor In Training Record">
		<cfset CatID = 14>
		<cfset PageTitle = "Auditor In Training Record">
	</cfif>
</cfif>

<br>
<cfif isDefined("url.uploaded") AND isDefined("url.Rev") AND isDefined("url.DocName")>
	<cfoutput>
    <font color="red"><b>#URL.DocName# [RevNo #URL.Rev#] has been uploaded</b></font>
    </cfoutput><br /><br />
</cfif>

<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
		<cfif SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.AccessLevel eq "Admin">
			<a href="CARFilesNewFile.cfm"><b>Add</b></a> a new File<br><br>
		</cfif>
	</cfif>
</cflock>

<Cfinclude template="qCARFiles.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->