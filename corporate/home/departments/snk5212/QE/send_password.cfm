<!--- Start of Page File --->
<cfset subTitle = "Request Password - #Request.SiteTitle#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif IsDefined("Form.username")>
    <CFQUERY BLOCKFACTOR="100" name="finduser" DataSource="Corporate">
    SELECT * FROM  CAR_LOGIN  "LOGIN" WHERE username = '#Form.Username#'
    </cfquery>

  <CFIF #finduser.RecordCount# IS 0>
  <p>Invalid Username.</p>
  <CFELSE>

<CFQUERY BLOCKFACTOR="100" NAME="finduser" DataSource="Corporate">
SELECT * FROM  CAR_LOGIN  "LOGIN" WHERE username = '#FORM.username#'
</CFQUERY>

<cfmail 
	replyto="#Request.ErrorMailTo#"
	from="CAR.Process.Web.Site@ul.com"
	to="#Email#"
	subject="CAR Process Website Password"
	query="finduser">

CAR Process Website login information:
username - #Form.username#
password - #password#

Please save this email for future reference.

You can view the CAR Process Website here:
http://#CGI.Server_Name#/departments/snk5212/QE/
</cfmail>

<CFOUTPUT query="finduser">
<p><b>Email Sent</b><br>
Your password has been mailed to #Email#.<br><br>

<p><a href="admin/global_login.cfm">Login</a> to the CAR Website.</p>
</CFOUTPUT>

  </cfif>
</cfif>

<cfform name="send_password" action="#CGI.SCRIPT_NAME#" method="post">
<b>Enter User Name</b><br>
<cfinput name="username" type="text" size="25" maxlength="25" required="yes" message="Please enter User Name.">
<br>
<input type="submit" value="Submit Info">
</cfform>
<br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->