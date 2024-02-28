<CFQUERY BLOCKFACTOR="100" name="menu" DataSource="Corporate">
SELECT * FROM CAR_menu_root
WHERE Status IS NULL
ORDER BY alphaID
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="kbmenu" DataSource="Corporate">
SELECT * FROM KBMenu
ORDER BY alphaID
</cfquery>

<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput query="menu">
	<cflock scope="Session" timeout="5">
<!--- If logged in and SU access level, the MENU.CFM from the admin directory is used!!! This is defined in the application.cfm file --->
		<!---
		<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
			<!--- if logged in show all but 'login' item --->
			<cfif text neq "Login">
				<cfif text neq "Request to be CAR Administrator" 
					AND text NEQ "CAR Administrator Responsibility Matrix" 
					AND text NEQ "CAR Training Documents" 
					AND text NEQ "Calibration Meetings"
					AND text NEQ "Frequently Asked Questions (FAQ)">
					<cfif text neq "Archive">
					 :: <a href="#link#">#text# <cfif text eq "CAR Administrator Related">Pages</cfif></a>
					<cfelse>
					 :: <a href="#CARAdminDir#archive/directory_listing.cfm">#text#</a>
					</cfif>
				<cfelseif text eq "Request to be CAR Administrator">
				:: #text# - [<a href="#CARRootDir#getEmpNo.cfm?page=request">Request Form</a>] [<a href="#CARAdminDir#Request.cfm">View Requests</a>]
				<cfelseif text eq "CAR Administrator Responsibility Matrix">
				:: #text# - <a href="#link#">view</a> (xls)
				<cfelseif text eq "CAR Training Documents">
				:: #text# - <a href="CARTrainingFiles.cfm">view files</a><br>
				:: <a href="admin/CARSource_Add.cfm">CAR Source List Configuration</a>
                <cfelseif text eq "Frequently Asked Questions (FAQ)">
					<cfif cgi.PATH_TRANSLATED is "#path#FAQ.cfm" 
                    OR cgi.PATH_TRANSLATED is "#path#carOwners.cfm"
                    OR cgi.PATH_TRANSLATED is "#path#carAdmins.cfm">
                        :: <b>#text#</b><br />
                    <cfelse>
                        :: #text#<br />
                    </cfif>
                    &nbsp;&nbsp; 
                    :: <cfif cgi.PATH_TRANSLATED is "#path#FAQ.cfm">
                           <u>All</u>
                        <cfelse>
                            <a href="FAQ.cfm">All</a>
                        </cfif>
                     :: <cfif cgi.PATH_TRANSLATED is "#path#carAdmins.cfm">
                           <u>CAR Admin Related</u>
                        <cfelse>
                            <a href="carAdmins.cfm">CAR Admin Related</a>
                        </cfif>                 
                     :: <cfif cgi.PATH_TRANSLATED is "#path#carOwners.cfm">
                           <u>CAR Owner Related</u>
                        <cfelse>
                            <a href="carOwners.cfm">CAR Owner Related</a>
                        </cfif>		
                    </cfif><br />
			</cfif>
			--->
	<!--- commented out logged in as SU, if you uncomment, please change cfif on the next line to cfelseif --->
    <!--- if logged in as 'CAR' access level - this is for CAR Trainers, use the menu below --->
	<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "CAR">
			<cfif text neq "Login" 
			and text neq "Archive" 
			and text neq "CAR Training Documents">
				:: <a href="#link#">#text#</a><br>
			<cfelseif text eq "CAR Training Documents">
				:: #text# - <a href="CARTrainingFiles.cfm">view files</a><br>
			</cfif>
	<!--- not logged in, show all but logout and archive --->
    <!--- public menu --->
	<cfelseif NOT IsDefined("SESSION.Auth.IsLoggedIn")>
			<cfif text neq "Logout" 
			and text neq "Archive" 
			AND text NEQ "Frequently Asked Questions (FAQ)"
			AND text NEQ "CAR Administrator Related"
			AND text NEQ "Calibration Meetings">
				:: <a href="#link#">#text#</a><br>
            <cfelseif text eq "Frequently Asked Questions (FAQ)">
            	<cfif cgi.PATH_TRANSLATED is "#path#FAQ.cfm" 
				OR cgi.PATH_TRANSLATED is "#path#carOwners.cfm"
				OR cgi.PATH_TRANSLATED is "#path#carAdmins.cfm">
            		:: <b>#text#</b><br />
                <cfelse>
                	:: #text#<br />
                </cfif>
                &nbsp;&nbsp; 
                :: <cfif cgi.PATH_TRANSLATED is "#path#FAQ.cfm">
                       <u>All</u>
                    <cfelse>
                    	<a href="FAQ.cfm">All</a>
                    </cfif>
                 :: <cfif cgi.PATH_TRANSLATED is "#path#carAdmins.cfm">
                       <u>CAR Admin Related</u>
                    <cfelse>
                    	<a href="carAdmins.cfm">CAR Admin Related</a>
                    </cfif>                 
                 :: <cfif cgi.PATH_TRANSLATED is "#path#carOwners.cfm">
                       <u>CAR Owner Related</u>
                    <cfelse>
                    	<a href="carOwners.cfm">CAR Owner Related</a>
                    </cfif><br />
			<cfelseif text eq "CAR Administrator Related">
                <cfif cgi.PATH_TRANSLATED is "#path#CARAdmin_Menu.cfm">
                	:: <b>#text# Pages</b> (See Menu Below)<br />
                <cfelse>
                	:: <a href="#link#">#text# Pages</a><br />
                </cfif>
			</cfif>
		</cfif>
	</cflock>
</cfoutput>

<!---
<cflock scope="Session" timeout="5">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
			<CFIF SESSION.Auth.UserName is "Konigsfeld" OR SESSION.AUTH.UserName is "Silva" OR SESSION.Auth.AccessLevel is "SU" OR SESSION.Auth.Username is "Carlisle">
				<cfoutput>
					<br> :: <a href="ASReports.cfm?Year=#curyear#">AS Reports (ANSI / OSHA / SCC)</a><br>
				</cfoutput>
			</CFIF>
	</cfif>
</cflock>
--->
		
<cfif cgi.path_translated eq "#path#Metrics.cfm">
<br>View Quality Alerts by:<br>
 - <a href="Metrics.cfm?Type=SC">Standard Categories</a><br>
 - <a href="Metrics.cfm?Type=KP">Key Processes</a><br>
 - <a href="Metrics.cfm?Type=Office">Offices</a><br>
 - <a href="Metrics.cfm?Type=Sector">Sectors</a><br>
</cfif>

<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
		<cfif session.auth.accesslevel eq "AS">
			:: <a href="admin/logout.cfm">Logout</a><br>
		</cfif>
		<br>
		<cfoutput>Logged in as: #SESSION.Auth.Username#</cfoutput><br>
			<cfif SESSION.Auth.AccessLevel eq "SU">
				Return to <a href="admin/">Admin Section</a><Br>
			</cfif>
	</cfif>
</cflock>

<cflock scope="Session" timeout="5">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn")>
		<cfif cgi.path_translated eq "#path#KBIndex.cfm" or cgi.path_translated eq "#path#KB.cfm" or cgi.path_translated eq "#path#KB_AddCategory.cfm" or cgi.path_translated eq "#path#KB_AddItem.cfm">
			<br>
			<cfoutput query="kbmenu">
				<cfif text is "Add new Knowledge Base Category" or text is "Add new Knowledge Base Article">
				:: <a href="#CARAdminDir##link#">#text#</a><br>
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
SELECT * FROM menu_root
ORDER BY alphaID
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