<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset subTitle = "Quality Engineering Related Files">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- / --->

<cfif isDefined("url.uploaded") AND isDefined("url.Rev") AND isDefined("url.DocName")>
	<cfoutput>
    <font color="red"><b>#URL.DocName# [RevNo #URL.Rev#] has been uploaded</b></font>
    </cfoutput><br /><br />
</cfif>

<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
		<a href="CARFilesNewFile.cfm"><b>Add</b></a> a new File<br><br>
	</cfif>
</cflock>

<Cfinclude template="qCARFiles.cfm">

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->