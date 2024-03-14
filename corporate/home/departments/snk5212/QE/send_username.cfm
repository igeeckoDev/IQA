<!--- Start of Page File --->
<cfset subTitle = "Request Username - #Request.SiteTitle#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif IsDefined("Form.Email")>
    <CFQUERY BLOCKFACTOR="100" name="finduser" DataSource="Corporate">
    SELECT * FROM  CAR_LOGIN  "LOGIN" WHERE Email = '#Form.Email#'
    </cfquery>

  <CFIF #finduser.RecordCount# IS 0>
  <p>Invalid Email Address (not found in this database).</p>
  <CFELSE>

<CFQUERY BLOCKFACTOR="100" NAME="finduser" DataSource="Corporate">
SELECT * FROM  CAR_LOGIN  "LOGIN" WHERE Email = '#FORM.Email#'
</CFQUERY>

<cfmail
	replyto="#Request.ErrorMailTo#"
	from="CAR.Web.Site@ul.com"
	to="#Email#"
	subject="CAR Process Website Username and Password"
	query="finduser">

CAR Process Website login information
Results for: #form.Email#:
username - #username#
password - #password#

Please save this email for future reference.

You can view the CAR Process Website here:
#request.serverProtocol##request.serverDomain#/departments/snk5212/QE/
</cfmail>

<CFOUTPUT query="finduser">
<p><b>Email Sent</b><br>
Your username and password has been mailed to #Form.Email#.<br><br>

Username Found:<br>
#username#<br><br>

<p><a href="admin/global_login.cfm">Login</a> to the CAR Website.</p>
</CFOUTPUT>

  </cfif>
</cfif>

<cfform name="send_username" action="#CGI.SCRIPT_NAME#" method="post">
<b>Enter External UL Email Address</b><br>
<cfinput name="Email" type="text" size="50" maxlength="128" required="yes" message="Please enter External UL Email Address">
<br>
<input type="submit" value="Submit Info">
</cfform>
<br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->