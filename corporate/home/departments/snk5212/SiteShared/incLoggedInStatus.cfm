<cfif cgi.SCRIPT_NAME NEQ "#CARDir_Admin#global_login.cfm" AND cgi.SCRIPT_NAME NEQ "#IQADir_Admin#global_login.cfm">
<cflock scope="Session" Timeout="5">
	<h2>Account</h2>
		<cfoutput>
            <cfif IsDefined("SESSION.Auth.IsLoggedIn")>
                <ul class="arrow2">
                    <li class="arrow2"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_tick.png" border="0" alt="Logged In" /> #SESSION.Auth.Name#</li>
                    <li class="arrow2">Access Level: #SESSION.Auth.AccessLevel#</li>
                    <cfif this.Name eq "IQA">
                        <cfif SESSION.Auth.AccessLevel eq "RQM">
                            <li class="arrow2">
                                Region: 
                                <cfif SESSION.Auth.Region eq SESSION.Auth.Subregion>
                                    #SESSION.Auth.Region#
                                <cfelse>
                                    #SESSION.Auth.Region# / #SESSION.Auth.SubRegion#
                                </cfif>
                            </li>
                        </cfif>
                        <cfif Path eq "#AccreditationsPath#" OR Path eq "#IQAPath#">
                        	<cfif SESSION.Auth.AccessLevel NEQ "TAD Temporary">
	                            <li class="arrow2"><a href="#IQADir_Admin#index.cfm">Return to IQA Admin</a></li>
    						</cfif>
                        <cfelseif Path eq "#IQAPath_Admin#">
                            <li class="arrow2"><a href="#IQADir_Admin#index.cfm">View Admin Menu</a></li>
                            <!--- to allow superuser to change access levels for testing purposes --->
							<cfif SESSION.Auth.AccessLevel eq "SU">
                            	<li class="arrow2"><a href="#IQADir_Admin#superuser_AccessLevel_Change.cfm">Change Access Level</a> (for App Testing)</li>
                            <cfelseif SESSION.Auth.IsSuperUser eq "Yes">
                            	<li class="arrow2"><a href="#IQADir_Admin#superuser_AccessLevel_Regain_Action.cfm">Regain Superuser Access Level</a></li>
                            </cfif>
                            <!--- /// --->
                        </cfif>
                        	<cfif SESSION.Auth.AccessLevel EQ "TAD Temporary">
                            	<li class="arrow2"><a href="#IQADir_Admin#logout.cfm?Type=TAD&page=#CGI.Script_Name#&#CGI.QUERY_STRING#">Log Out</a></li>
                            <cfelse>
                                <li class="arrow2"><a href="#IQADir_Admin#logout.cfm">Log Out</a></li>
                            </cfif>
                    <cfelseif this.Name eq "QE">
                        <cfif Path eq "#CARPath#"> 
                            <li class="arrow2"><a href="#CARDir_Admin#index.cfm">Return to CAR Process Admin</a></li>
                        <cfelseif Path eq "#CARPath_Admin#">
                            <li class="arrow2"><a href="#CARDir_Admin#index.cfm">View Admin Menu</a></li>
                        </cfif>
                            <li class="arrow2"><a href="#CARDir_Admin#logout.cfm">Log Out</a></li>
                    </cfif>
                </ul>
            <cfelseif NOT IsDefined("SESSION.Auth.IsLoggedIn")>
            	<!--- To allow users who are not logged in who are viewing webhelp directory to access IQA login page correctly --->
				<cfif this.Name eq "IQA" AND Path eq "#IQAWebHelpPath#">
                	<cfset pathAdjust = "#IQADir#">
                <cfelse>
                	<cfset pathAdjust = "">
                </cfif>
                	<img align="absmiddle" src="#SiteDir#SiteImages/key_start.png" border="0" alt="Login" /> <a href="#pathAdjust#admin/global_login.cfm">Log In</a> to <cfif this.name eq "QE">CAR Process<cfelse>#this.name#</cfif>
            </cfif>
    </cfoutput>
</cflock>
</cfif>