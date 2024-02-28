<!--- Start of Page File --->
<cfset subTitle = "Global Login - #Request.SiteTitle#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- Check if login form is filled out, by testing if variable form.username is defined.
If yes find the user and log in, if not display the login form. --->
<cfif IsDefined("Form.username")>
   <!--- Open the database and find the entered username and password. --->
   <CFQUERY BLOCKFACTOR="100" name="finduser" DataSource="Corporate">
    SELECT * FROM IQADB_LOGIN "LOGIN"
    WHERE username = '#Form.username#'
    AND password = '#Form.password#'
    </cfquery>
   <!--- If RecordCount is 0, no user is found, give an error message and open the login form.
   Else if user is found, login the user. --->
<CFIF finduser.RecordCount IS 0>
      <cflocation url="global_login.cfm?msg=Invalid Username or Password." ADDTOKEN="No">
<cfelseif finduser.status eq "removed">
	<cflocation url="global_login.cfm?msg=Account Deactivated. Please contact Global Internal Quality for more information." AddToken="No">
<cfelseif finduser.status eq "test">
	<cflocation url="global_login.cfm?msg=Test Accounts have been deactivated. Please contact Global Internal Quality if you have recieved this message in error." addtoken="No">
<cfelse>
  <!--- Get user info, first name, last name and access level. --->
  <cflock scope="SESSION" timeout="60">
      <cfset SESSION.Auth = StructNew()>
      <cfset SESSION.Auth.IsLoggedIn = "Yes">
      <cfset SESSION.Auth.IsLoggedInApp = #this.Name#>
      <cfset SESSION.Auth.Password = finduser.password>
      <cfset SESSION.Auth.Name = finduser.Name>
      <cfset SESSION.Auth.username = finduser.username>
      <cfset SESSION.Auth.accesslevel = finduser.accesslevel>
        <cfif SESSION.Auth.AccessLevel eq "SU">
            <cfset SESSION.Auth.IsSuperUser = "Yes">
        <cfelse>
            <cfset SESSION.Auth.IsSuperUser = "No">
        </cfif>
      <cfset SESSION.Auth.Region = finduser.Region>
      <cfset SESSION.Auth.SubRegion = finduser.SubRegion>
      <cfset SESSION.Auth.Office = finduser.Office>
      <cfset SESSION.Auth.Email = finduser.Email>
      <cfset SESSION.Auth.ID = finduser.ID>
      <cfset SESSION.Auth.Andon = finduser.Andon>
      <cfset SESSION.Auth.IQA = finduser.IQA>
      <cfset newIP = CGI.REMOTE_ADDR>
      <cfset newBrowser = CGI.HTTP_USER_AGENT>
  </cflock>

<!--- login total updates --->
<cfif cgi.server_name is "usnbkiqas100p" AND curdir is "/departments/snk5212/IQA/admin/">
	<cfset TotLogins = #finduser.TotalLogins# + 1>

    <cfquery Datasource="Corporate" name="UpdateUser">
    UPDATE IQADB_LOGIN  "LOGIN"
    SET TotalLogins = #TotLogins#,
    LastIP = '#newIP#',
    LastBrowser = '#newBrowser#',
    LastLogin = '#curdate# #curtime#',
    IPLog = '#newIP#',
    LoginLog = '#curdate# #curtime# (#newIP#)'
    WHERE username = '#finduser.username#'
    </cfquery>

    <cflock scope="SESSION" timeout="60">
    <cflog application="no"
           file="IQA"
           text="Login - #SESSION.Auth.Username#"
           type="Information">
    </cflock>
</cfif>
<!--- end login total updates --->

<!--- Everything is ok. Send the user to menu template. --->
<!--- Place the cursor in the 'User Name' field when the page loads and start the login form. --->
    <cflock scope="SESSION" timeout="60">
		<CFIF SESSION.Auth.password is "temppwd">
            <cfoutput query="finduser">
                <cflocation url="set_pwd.cfm?ID=#ID#" ADDTOKEN="No">
            </cfoutput>
        <CFELSEIF SESSION.Auth.accesslevel is "IQAAuditor">
            <cflocation url="index.cfm" addtoken="no">
		<CFELSEIF SESSION.Auth.accesslevel is "RQM" AND SESSION.Auth.Region is "Medical"
			OR SESSION.Auth.accesslevel is "RQM" AND SESSION.Auth.Region is "UL Environment">
				<cflocation url="index.cfm" addtoken="no">
		<cfelseif SESSION.Auth.AccessLevel is "RQM">
            <cflocation url="schedule.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.SubRegion#&Auditor=All" ADDTOKEN="No">
        <cfelseif SESSION.Auth.AccessLevel is "Field Services">
            <cflocation url="index.cfm" addtoken="no">
        <cfelseif SESSION.Auth.AccessLevel is "Finance">
            <cflocation url="index.cfm" addtoken="no">
		<cfelseif SESSION.Auth.AccessLevel is "AS">
            <cflocation url="index.cfm" addtoken="no">
        <cfelseif SESSION.Auth.AccessLevel is "Laboratory Technical Audit">
            <cflocation url="index.cfm" addtoken="no">
        <cfelseif SESSION.Auth.AccessLevel is "Verification Services">
            <cflocation url="index.cfm" addtoken="no">
        <cfelseif SESSION.Auth.AccessLevel is "WiSE">
            <cflocation url="index.cfm" addtoken="no">
        <cfelseif SESSION.Auth.AccessLevel is "CPO">
            <cflocation url="_prog.cfm?list=CPO" ADDTOKEN="No">
        <cfelseif SESSION.Auth.AccessLevel is "Technical Audit">
        	<cflocation url="TechnicalAudits_Test.cfm" addtoken="no">
        <cfelseif SESSION.Auth.AccessLevel is "DAP Qualifier">
			<cflocation url="DAPLeadAuditorOversightRecords.cfm" addtoken="no">
		<CFELSE>
            <cflocation url="index.cfm" ADDTOKEN="No">
        </CFIF>
    </cflock>
</cfif>
<!--- this is end if for the else case of recordcount eq 0 --->
<cfelse>

<!--- --->
<CFQUERY BLOCKFACTOR="100" name="MaxID" DataSource="Corporate">
SELECT MAX(ID) as maxID FROM LoginLock
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Lock" DataSource="Corporate">
SELECT * FROM LoginLock
WHERE ID = #MaxID.maxID#
</cfquery>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfif Lock.LoginLock eq 0>
<cfform action = "#CGI.SCRIPT_NAME#" method = "post" id="myform" name="myform">
<!--- The action attribute CGI.SCRIPT_NAME always holds the relative URL to the currently executing template.
So when the user click on 'Login' the same template reloads. --->
<!--- Field for "User Name". --->
<!--- The attribute required is set to yes. So if the field is empty,
the text in the massage attribute will be displayed. --->

<cfif isDefined("URL.msg")>
<cfoutput><font color="red">#url.msg#</font><br><Br></cfoutput>
</cfif>

<b>User Name</b><br>
<cfinput name="username" type="text" size="25" data-bvalidator="required" data-bvalidator-msg="Username is Required"><br>

<b>Password</b><br>
<cfinput name="password" type="password" size="25" data-bvalidator="required" data-bvalidator-msg="Password is Required"><br><br />

<input type="submit" value="Login">
<input type="reset" value="Reset Form"><br /><br />
</cfform>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<cfoutput>
<u>Login Problems?</u><br>
Login Help - <a href="#IQADir#webhelp/webhelp_login.cfm">Webhelp - Login</a><br>
Send password - <a href="#IQADir#send_password.cfm">click here</a><br>
Send username - <a href="#IQADir#send_username.cfm">click here</a><br><br>
</cfoutput>

<cfelse>
<!--- if logins are disabled --->
<cfoutput query="Lock">
Logins are disabled.<br>

From 05/22/2009 7:00PM until 05/24/2009 7:00PM (Times listed in CST)<br><br>

Reason:<br>
#Message#<br><br>
</cfoutput>

Contact <a href="mailto:Global.InternalQuality@ul.com">Global Internal Quality</a> for further information.<br><br>
</cfif>

<cfoutput>
<!--- shown whether or not logins are allowed --->
Return to <a href="#IQADir#">IQA Main Page</a><br><br>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->