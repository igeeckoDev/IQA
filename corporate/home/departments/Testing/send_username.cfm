<!--- Start of Page File --->
<cfset subTitle = "Request Username - #Request.SiteTitle#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif IsDefined("Form.Email")> 
   <CFQUERY BLOCKFACTOR="100" name="finduser" Datasource="Corporate"> 
SELECT * 
FROM IQADB_LOGIN "LOGIN" 
WHERE Email = '#Form.Email#'
AND Status IS NULL
</cfquery>
	
  <CFIF #finduser.RecordCount# IS 0>
  <p>Invalid Email Address (not found in this database).</p>	
  <CFELSE>	

<CFQUERY BLOCKFACTOR="100" NAME="finduser" Datasource="Corporate"> 
SELECT * 
FROM IQADB_LOGIN "LOGIN" 
WHERE Email = '#FORM.Email#'
AND Status IS NULL
</CFQUERY>	
	
<cfmail 
from="Internal.Quality_Audits@ul.com" 
to="#Email#" 
subject="IQA Audit Database Username and Password"
query="finduser">

IQA Audit Database login information
Results for: #form.Email#:
username - #username#

Please save this email for future reference.

You can view the IQA Site here:
http://usnbkiqas100p/departments/snk5212/IQA/
</cfmail>

<CFOUTPUT query="finduser">
<p><b>Email Sent</b><br>
Your username and password has been mailed to #Form.Email#.<br><br>

Username Found:<br>
#username#<br><br>

<p><a href="admin/global_login.cfm">Login</a> to the IQA site.</p>
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