<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>
</head>

	<body onLoad="document.login.username.focus();" leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<!-- Begin UL Net Header -->
<cfoutput><SCRIPT language=JavaScript src="#Request.header#"></script></cfoutput>
<!-- End UL Net Header--> 
	
		<div align="left">
			<table width="756" border="0" cellpadding="0" cellspacing="0" bgcolor="#cecece" class="table-main">
			<tr>
			<td>
			<div align="center">
			<table class="table-main" width="675" border="0" cellspacing="0" cellpadding="0" bgcolor="#cecece">
				<tr>
					<td class="table-bookend-top">&nbsp;</td>
				</tr>
				<tr>
					<td class="table-masthead" align="right" valign="middle"><div align="center">&nbsp;</div></td>

				</tr>
				<tr>
					
              <td class="table-menu" valign="top"><div align="center">&nbsp;</div></td>
				</tr>
				<tr>

					
              <td height="925" class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td height="927" valign="top" class="content-column-left"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-date"><p align="left"><br>
                              Global Login - Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
<!--- Check if login form is filled out, by testing if variable form.username is defined.
If yes find the user and log in, if not display the login form. --->
<cfif IsDefined("Form.username")>
   <!--- Open the database and find the entered username and password. --->
	<CFQUERY BLOCKFACTOR="100" name="finduser" DataSource="Corporate"> 
	SELECT * FROM IQADB_LOGIN "LOGIN" 
	WHERE username = <cfqueryparam value="#Form.username#" cfsqltype="CF_SQL_VARCHAR">
	</cfquery>
   <!--- If RecordCount is 0, no user is found, give an error message and open the login form.
   Else if user is found, login the user. --->
	<cfif finduser.recordcount eq 0>
		<cflocation url="global_login_new.cfm?msg=Invalid Username" Addtoken="No">
	<cfelseif finduser.recordcount eq 1>

<cffunction name="computeHash" access="public" returntype="String">
  <cfargument name="password" type="string" />
  <cfargument name="salt" type="string" />
  <cfargument name="iterations" type="numeric" required="false" default="1024" />
  <cfargument name="algorithm" type="string" required="false" default="SHA-512" />
  <cfscript>
    var hashed = '';
    var i = 1;
    hashed = hash( password & salt, arguments.algorithm, 'UTF-8' );
    for(i = 1; i <= iterations; i++) {
      hashed = hash( hashed & salt , arguments.algorithm, 'UTF-8' );
    }
    return hashed;
  </cfscript>
</cffunction>

	<cfset hashedFormPassword = computeHash(form.password, finduser.salt) />
	
		<cfif finduser.passwordNew neq hashedFormPassword>
	      	<cflocation url="global_login_new.cfm?msg=Invalid Password (Passwords are case sensitive)" ADDTOKEN="No">
		<cfelseif finduser.passwordNew eq hashedFormPassword>
			<!--- Get user info, first name, last name and access level. --->
			<cflock scope="SESSION" timeout="60">
				<cfset SESSION.Auth = StructNew()>
				<cfset SESSION.Auth.IsLoggedIn = "Yes">
				<cfset SESSION.Auth.IsLoggedInApp = #this.Name#>
				<cfset SESSION.Auth.Password = finduser.password>
				<cfset SESSION.Auth.Name = finduser.Name>
				<cfset SESSION.Auth.username = finduser.username>	  
				<cfset SESSION.Auth.accesslevel = finduser.accesslevel>
				<cfset SESSION.Auth.Region = finduser.Region>
				<cfset SESSION.Auth.SubRegion = finduser.SubRegion>
				<cfset SESSION.Auth.Office = finduser.Office>
				<cfset SESSION.Auth.Email = finduser.Email>
				<cfset SESSION.Auth.ID = finduser.ID>
				<cfset SESSION.Auth.Andon = finduser.Andon>       
				<cfset newIP = CGI.REMOTE_ADDR>
				<cfset newBrowser = CGI.HTTP_USER_AGENT>	 
			</cflock>
	  
			<!--- login total updates --->
			<cfif cgi.server_name is "usnbkiqas100p" AND curdir is "/departments/snk5212/iqa/admin/">
			<cfset TotLogins = #finduser.TotalLogins# + 1>
			
			<cfquery Datasource="Corporate" name="UpdateUser"> 
			UPDATE IQADB_LOGIN  "LOGIN" SET TotalLogins = #TotLogins#,
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
	</cfif>
<!--- end login total updates --->

<!--- Everything is ok. Send the user to menu template. --->
<!--- Place the cursor in the 'User Name' field when the page loads and start the login form. --->
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.password is "temppwd">
	<cfoutput query="finduser">
		<cflocation url="set_pwd.cfm?ID=#ID#" ADDTOKEN="No">
	</cfoutput>
<cfelseif finduser.status eq "removed">
	<cflocation url="global_login.cfm?msg=Account Deactivated" AddToken="No">
<cfelseif finduser.status eq "test">
	<cflocation url="global_login.cfm?msg=Test Accounts have been deactivated. Please contact Chris Nicastro if you have recieved this message in error." addtoken="No">
<CFELSEIF SESSION.Auth.accesslevel is "IQAAuditor">
	<cflocation url="schedule.cfm?Year=#CurYear#&Auditor=#SESSION.AUTH.Name#&AuditedBy=IQA" ADDTOKEN="No">
<cfelseif SESSION.Auth.AccessLevel is "RQM" or SESSION.Auth.AccessLevel is "OQM">
	<cflocation url="schedule.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.SubRegion#&Auditor=All" ADDTOKEN="No">
<cfelseif SESSION.Auth.AccessLevel is "Field Services" or SESSION.Auth.AccessLevel is "Finance" or SESSION.Auth.AccessLevel is "QRS" or SESSION.Auth.AccessLevel is "AS">
	<cflocation url="schedule.cfm?Year=#CurYear#&AuditedBy=#SESSION.Auth.AccessLevel#&Auditor=All" ADDTOKEN="No">
<cfelseif SESSION.Auth.AccessLevel is "CPO">
	<cflocation url="_prog.cfm?list=CPO" ADDTOKEN="No">
<CFELSE>
	<cflocation url="admin.cfm" ADDTOKEN="No">
</CFIF>
</cflock>
</cfif><!--- this is end if for the else case of recordcount eq 0 --->

<cfelse>

<!--- --->
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

<div class="blog-time">Login Help - <A HREF="javascript:popUp('../webhelp/webhelp_login.cfm')" title="IQA Web Help Link">[?]</A>
</div><br>

<cfif isDefined("URL.msg")>
<cfoutput><font color="red">#url.msg#</font><br><Br></cfoutput>
</cfif>

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
<u>Login Problems?</u><br>
Send password - <a href="../send_password.cfm">click here</a><br>
Send username - <a href="../send_username.cfm">click here</a><br><br>

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
Return to <a href="../">IQA Main Page</a><br><br>
</cfif>
						  
<!--- Footer, End of Page HTML --->
<cfinclude template="EOP.cfm">
<!--- / --->