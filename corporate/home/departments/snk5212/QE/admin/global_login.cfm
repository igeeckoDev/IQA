<!--- Start of Page File --->
<cfset subTitle = "Global Login - #Request.SiteTitle#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- Check if login form is filled out, by testing if variable form.username is defined.
If yes find the user and log in, if not display the login form. --->
<cfif IsDefined("Form.username")>
   <!--- Open the database and find the entered username and password. --->
<CFQUERY BLOCKFACTOR="100" name="finduser" DataSource="Corporate">
SELECT * FROM 
CAR_LOGIN "LOGIN" 
WHERE username = '#Form.username#' AND password = '#Form.password#'
</cfquery>

   <!--- If RecordCount is 0, no user is found, give an error message and open the login form.
   Else if user is found, login the user. --->
<CFIF #finduser.RecordCount# IS 0>
      Invalid Username or Password.
   <cfelse>
      <!--- Get user info, first name, last name and access level. --->
	  <cflock scope="SESSION" type="EXCLUSIVE" timeout="5">
		  <cfset SESSION.Auth = StructNew()>
	      <cfset SESSION.Auth.IsLoggedIn = "Yes">
		  <cfset SESSION.Auth.IsLoggedInApp = #this.Name#>
		  <cfset SESSION.Auth.Password = finduser.password>
	      <cfset SESSION.Auth.Name = finduser.Name>
	      <cfset SESSION.Auth.username = finduser.username>
	      <cfset SESSION.Auth.accesslevel = finduser.accesslevel>
	  	  <cfset SESSION.Auth.Email = finduser.Email>
	  	  <cfset SESSION.Auth.ID = finduser.ID>
		  <cfset newIP = CGI.REMOTE_ADDR>
		  <cfset newBrowser = CGI.HTTP_USER_AGENT>

	  <CFQUERY BLOCKFACTOR="100" name="finduserlogs" DataSource="Corporate">
	   SELECT * FROM logs_login
	   WHERE loginID = #SESSION.Auth.ID#
	  </cfquery>

	<cfif finduserlogs.recordcount eq 0>
		<cfset TotalLogins = 1>

		<cfquery Datasource="Corporate" name="AddUser">
		INSERT INTO Logs_Login(loginID)
		VALUES(#SESSION.Auth.ID#)
		</cfquery>
	<cfelse>
		<cfset TotalLogins = #finduserlogs.TotalLogins#+1>
	</cfif>

<cfquery Datasource="Corporate" name="UpdateUser">
UPDATE Logs_Login
SET TotalLogins = #TotalLogins#,
LastIP = '#newIP#',
LastBrowser = '#newBrowser#',
LastLogin = '#curdate# #curtime#',
IPLog = <cfqueryparam value="#newIP#<br>#finduserlogs.IPLog#" CFSQLType="CF_SQL_CLOB">,
LoginLog = <cfqueryparam value="#curdate# #curtime# (#newIP#)<br>#finduserlogs.LoginLog#" CFSQLType="CF_SQl_CLOB">

WHERE loginID = #SESSION.Auth.ID#
</cfquery>

<cflog application="no"
	  
	   file="QE"
	   text="Login - #SESSION.Auth.Username#"
	   type="Information">
</cflock>

<!--- Everything is ok. Send the user to menu template. --->
<!--- Place the cursor in the 'User Name' field when the page loads and start the login form. --->
<cflock scope="SESSION" type="READONLY" timeout="5">
<CFIF SESSION.Auth.password is "temppwd">
<cfoutput query="finduser">
	<cflocation url="set_pwd.cfm?ID=#ID#" addtoken="No">
</cfoutput>
<CFELSEIF Session.Auth.AccessLevel eq "CAR">
	<cflocation url="#CARRootDir#CARTrainingFiles.cfm" addtoken="No">
<CFELSEIF SESSION.Auth.AccessLevel eq "AS">
	<cflocation url="#CARRootDir#ASReports.cfm?Year=#curyear#" addtoken="No">
<CFELSE>
<!--- else = Superuser (SU) --->
	<cflocation url="index.cfm" addtoken="No">
</CFIF>
</cflock>

</cfif>
<cfelse>
<!--- /// --->
<CFQUERY BLOCKFACTOR="100" name="MaxID" DataSource="Corporate">
SELECT MAX(ID) as maxID FROM LoginLock
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Lock" DataSource="Corporate">
SELECT * FROM LoginLock
WHERE ID = #MaxID.maxID#
</cfquery>

<cfif Lock.LoginLock eq 0>
<cfform name = "login" action = "#CGI.SCRIPT_NAME#" method = "post">
<!--- The action attribute CGI.SCRIPT_NAME always holds the relative URL to the currently executing template.
So when the user click on 'Login' the same template reloads. --->
<!--- Field for "User Name". --->
<!--- The attribute required is set to yes. So if the field is empty,
the text in the massage attribute will be displayed. --->

<b>User Name</b><br>
<cfinput name="username" type="text" size="25" maxlength="25" required="yes" message="Please enter User Name.">
<br>
<!--- Field for "Password". --->
<b>Password</b><br>
<cfinput name="password" type="password" size="25" maxlength="25" required="yes" message="Please enter Password.">
<br>
<input type="submit" value="Login">
</cfform>
<br>

<cfoutput>
<u>Login Problems?</u><br>
Login Help - <a href="#IQADir#webhelp/webhelp_login.cfm">Webhelp - Login</a><br>
Send password - <a href="#CARDir#send_password.cfm">click here</a><br>
Send username - <a href="#CARDir#send_username.cfm">click here</a><br><br>
</cfoutput>

<cfelse>
<!--- if logins are disabled --->
<cfoutput query="Lock">
Logins are disabled.<br>

From 05/22/2009 7:00PM until 05/24/2009 7:00PM (Times listed in CST)<br><br>

Reason:<br>
#Message#<br><br>
</cfoutput>

Contact <a href="mailto:Christopher.J.Nicastro@ul.com">Christopher Nicastro</a> for further information.<br><br>
</cfif>

<!--- shown whether or not logins are allowed --->
<cfoutput>
Return to <a href="#CARDir#">CAR Website Main Page</a><br><br>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->