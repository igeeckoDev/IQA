<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" name="menu" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 464b63d2-787f-429e-b488-178237c62753 Variable Datasource name --->
SELECT * FROM menu_root
ORDER BY alphaID
<!---TODO_DV_CORP_002_End: 464b63d2-787f-429e-b488-178237c62753 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="kbmenu" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 0a5be58c-7692-4af3-946c-763ad78fe0b7 Variable Datasource name --->
SELECT * FROM KBMenu
ORDER BY alphaID
<!---TODO_DV_CORP_002_End: 0a5be58c-7692-4af3-946c-763ad78fe0b7 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput query="menu">
	<cflock scope="Session" timeout="5">
		<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
			<!--- if logged in show all but 'login' item --->
			<cfif text neq "Login">
				<cfif text neq "Request to be CAR Administrator">				
					<cfif text neq "Archive">
					 :: <a href="#link#">#text#</a>
					<cfelse>
					 :: <a href="#fullbasedir#admin/archive/directory_listing.cfm">#text#</a>
					</cfif>
				<cfelse>
				:: #text# - [<a href="#fullbasedir#getEmpNo.cfm?page=request">Request Form</a>] [<a href="#fullbasedir#admin/Request.cfm">View Requests</a>]
				</cfif><br>
			</cfif>
		<cfelse>
			<!--- not logged in, show all but logout and archive --->
			<cfif text neq "Logout" and text neq "Archive">
				:: <a href="#link#">#text#</a><br>
			</cfif>
		</cfif>
	</cflock>
</cfoutput>

<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
		<br><cfoutput>Logged in as: #SESSION.Auth.Username#</cfoutput><br>
		Return to <a href="admin/">Admin Section</a><Br>
	</cfif>
</cflock>

<cflock scope="Session" timeout="5">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
		<cfif cgi.path_translated eq "#path#KBIndex.cfm" or cgi.path_translated eq "#path#KB.cfm" or cgi.path_translated eq "#path#KB_AddCategory.cfm" or cgi.path_translated eq "#path#KB_AddItem.cfm">
			<br>
			<cfoutput query="kbmenu">
				<cfif text is "Add new Knowledge Base Category" or text is "Add new Knowledge Base Article">
				:: <a href="#fullbasedir#admin/#link#">#text#</a><br>
			<cfelse>
				:: <a href="#link#">#text#</a><br>			
			</cfif>
			</cfoutput>
		</cfif>
	</cfif>
</cflock>
</td>
</tr>
</table>

<!--- OLD MENU
<CFQUERY BLOCKFACTOR="100" name="menu" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: cf968e14-bfc3-46a8-a9bf-9dd590de91fb Variable Datasource name --->
SELECT * FROM menu_root
ORDER BY alphaID
<!---TODO_DV_CORP_002_End: cf968e14-bfc3-46a8-a9bf-9dd590de91fb Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput query="menu">
	<cfif text neq "Logout" and text neq "Archive">
		:: <a href="#link#">#text#</a><br>
	</cfif>
</cfoutput>
</td>
</tr>
</table>
--->