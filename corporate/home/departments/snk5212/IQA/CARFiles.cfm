<cfif isDefined("URL.Category")>
	<cfif URL.Category eq "Plans">
		<cfset CatID = 3>
		<cfset PageTitle = "Audit Plans">
	<cfelseif URL.Category eq "Metrics">
		<cfset CatID = 4>
		<cfset PageTitle = "IQA Related Metrics">
	<cfelseif URL.Category NEQ "Plans" AND URL.Category NEQ "Metrics">
		<cflocation url="_noPage.cfm?file=#CGI.Script_Name#&var=#CGI.Query_String#" addtoken="no">
	<cfelseif NOT len(URL.Category)>
		<cflocation url="_noPage.cfm?file=#CGI.Script_Name#&var=#CGI.Query_String#" addtoken="no">
	</cfif>
<cfelse>
	<cflocation url="_noPage.cfm?file=#CGI.Script_Name#&var=None" addtoken="no">
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#PageTitle#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<cflock scope="Session" timeout="5">
		<cfif isDefined("Session.Auth.IsLoggedIn")>
			<cfif SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.AccessLevel eq "Admin">
				<a href="admin/CARFilesNewFile.cfm?CategoryID=#CatID#"><b>Add</b></a> a new File<br><br>
			</cfif>
		</cfif>
	</cflock>
</cfoutput>
	
<Cfinclude template="qCARFiles.cfm">

<!---
<b>ISO 17065 Training</b> (right click on link -> Save Target As...)<br />
<a href="17065Training/ISO17065TrainingWithKeithMowryJan92013.wmv">ISO 17065 Training</a><Br /><br />
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->