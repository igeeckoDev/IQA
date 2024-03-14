<!--- Start of Page File --->
<cfset subTitle = "Request Password - #Request.SiteTitle#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif IsDefined("Form.username")> 
   <CFQUERY BLOCKFACTOR="100" name="finduser" Datasource="Corporate"> 
SELECT * 
FROM IQADB_LOGIN "LOGIN" 
WHERE username = '#Form.Username#'
AND Status IS NULL
</cfquery>
	
  <CFIF #finduser.RecordCount# IS 0>
  <p>Invalid Username.</p>	
  <CFELSE>	

<CFQUERY BLOCKFACTOR="100" NAME="finduser" Datasource="Corporate"> 
SELECT * 
FROM IQADB_LOGIN "LOGIN"
WHERE username = '#FORM.username#'
AND Status IS NULL
</CFQUERY>	
	
<cfmail 
from="Internal.Quality_Audits@ul.com" 
to="#Email#" 
subject="IQA Audit Database Password"
query="finduser">

IQA Audit Database login information:
username - #Form.username#
password - #password#

Please save this email for future reference.

You can view the IQA Site here:
#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/
</cfmail>

<CFOUTPUT query="finduser">
<p><b>Email Sent</b><br>
Your password has been mailed to #Email#.<br><br>

<p><a href="admin/global_login.cfm">Login</a> to the IQA site.</p>
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