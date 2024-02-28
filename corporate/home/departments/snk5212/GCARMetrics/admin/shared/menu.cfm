<!---
<ul class="arrow2">
  <li class="arrow2"><a href="AdminMenu.cfm" class="arrow">Admin Menu</a></li>
</ul>
--->

<!---
<h2>GCAR Metrics<Br />Site Admin</h2>
<cfoutput>
<cflock scope="Session" timeout="5">
<cfif isDefined("SESSION.Auth.IsLoggedIn")>
	<cfif isDefined("SESSION.Auth.IsLoggedInApp") AND SESSION.Auth.IsLoggedIn eq "Yes">
        <ul class="arrow2">
            <li class="arrow2"><img align="absmiddle" src="#SiteDir#SiteImages/bullet_tick.png" border="0" alt="Logged In" /> #SESSION.Auth.Name#</li>
            <li class="arrow2">Access Level: #SESSION.Auth.AccessLevel#</li>
            <li class="arrow2"><a href="adminMenu.cfm">Admin Menu</a></li>
            <li class="arrow2"><a href="#GCARMetricsDir#">Main (Public) Menu</a></li>
            <li class="arrow2"><a href="logout.cfm">Log Out</a></li>
        </ul>
	</cfif>
<cfelseif NOT isDefined("SESSION.Auth.IsLoggedIn")>
    	<img align="absmiddle" src="#SiteDir#SiteImages/key_start.png" border="0" alt="Login" /> <a href="getEmpNo_Admin.cfm">Log In</a>
</cfif>
</cflock>
</cfoutput>
--->