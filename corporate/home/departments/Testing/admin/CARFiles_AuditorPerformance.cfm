<cfset CatID = 7>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="#Request.SiteTitle# - Internal Auditor Performance Monitoring">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
		<cfif SESSION.Auth.AccessLevel eq "SU" >
		<br>
		<a href="CARFilesNewFile.cfm"><b>Add</b></a> a new File<br><br>

			<Cfinclude template="qCARFiles_AuditorPerformance.cfm">
		<cfelse>
			Page Restricted.
		</cfif>
	</cfif>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->