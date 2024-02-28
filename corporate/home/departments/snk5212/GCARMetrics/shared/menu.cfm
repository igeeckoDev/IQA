<ul class="arrow2">
  <li class="arrow2"><a href="index.cfm" class="arrow">Start New Search</a></li>
  <li class="arrow2"><a href="getEmpNo.cfm?page=ViewQueries" class="arrow">View Your Saved Reports</a></li>
  <li class="arrow2"><a href="ViewQueries.cfm?EmpNo=All" class="arrow">View All Saved Reports</a></li>
  <li class="arrow2"><a href="Report.cfm" class="arrow">View CAR Trend Reports</a></li>
  <li class="arrow2"><a href="Glossary.cfm?ID=All" class="arrow">Glossary of Terms</a></li>
  <li class="arrow2"><a href="Overview.cfm" class="arrow">Application Overview</a></li>
</ul>

<h2>Site Status</h2>
<cfoutput>
    <cfif Request.Development eq "Yes">
        <p class="warning">
            <img align="absmiddle" src="#SiteDir#SiteImages/database_stop.png" border="0" alt="In Development" /> Application In Development - This is TEST DATA and is NOT ACCURATE
        </p>
    <cfelse>
		<img align="absmiddle" src="#SiteDir#SiteImages/database_wrench.png" border="0" alt="Data Refresh Date" /> <!--- GCAR Metrics Data valid through <span class="dataDate">#dateformat(Request.DataDate, "mm/dd/yyyy")# ---> Not Active </span>
    </cfif>
</cfoutput>

<!---
<h2>GCAR Metrics<Br />Site Admin</h2>
<cfoutput>
<cflock scope="Session" timeout="5">
<cfif isDefined("SESSION.Auth.IsLoggedIn") AND isDefined("SESSION.Auth.IsLoggedInApp") AND SESSION.Auth.IsLoggedIn eq "Yes">
    <ul class="arrow2">
        <li class="arrow2"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_tick.png" border="0" alt="Logged In" /> #SESSION.Auth.Name#</li>
        <li class="arrow2">Access Level: #SESSION.Auth.AccessLevel#</li>
        <li class="arrow2"><a href="#GCARMetricsAdminDir#adminMenu.cfm">Admin Menu</a></li>
        <li class="arrow2"><a href="#GCARMetricsAdminDir#logout.cfm">Log Out</a></li>
    </ul>
<cfelseif isDefined("SESSION.Auth.IsLoggedIn") AND isDefined("SESSION.Auth.IsLoggedInApp") AND SESSION.Auth.IsLoggedIn eq "No" 
		OR NOT isDefined("SESSION.Auth.IsLoggedIn")>
	<img align="absmiddle" src="#SiteDir#SiteImages/key_start.png" border="0" alt="Login" /> <a href="admin/getEmpNo_Admin.cfm">Log In</a>
</cfif>
</cflock>
</cfoutput>
--->

<!---
<cfif cgi.PATH_TRANSLATED NEQ "#path#Admin.cfm">
	<ul class="arrow2">
    	<li class="arrow2"><a href="getEmpNo_Admin.cfm">Login</a></li>
    </ul>
<cfelse>
	<cfif cgi.PATH_TRANSLATED EQ "#path#Admin.cfm">
    	<cfif isDefined("Form.EmpNo") AND Len(Form.EmpNo)>
			<cfif Form.EmpNo eq #Request.AdminEmpNo#>
                <ul class="arrow2">
                    <li class="arrow2">Admin Access Granted.</li>
                    <li class="arrow2">Return to <a href="index.cfm">GCAR Metrics Home</a></li>
                </ul>
            <cfelseif Form.EmpNo NEQ #Request.AdminEmpNo#>
                <ul class="arrow2">
                    <li class="arrow2">Admin Access Denied.</li>
                    <li class="arrow2">Return to <a href="index.cfm">GCAR Metrics Home</a></li>
                </ul>
            </cfif>
		<cfelse>
            <ul class="arrow2">
                <li class="arrow2">Admin Access Denied.</li>
                <li class="arrow2">Return to <a href="index.cfm">GCAR Metrics Home</a></li>
            </ul>
        </cfif>
	</cfif>
</cfif>
--->