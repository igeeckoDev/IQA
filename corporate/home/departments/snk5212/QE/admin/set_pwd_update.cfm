<CFQUERY BLOCKFACTOR="100" NAME="change_pwd" DataSource="Corporate"> 
UPDATE CAR_LOGIN "LOGIN"
SET 
password = '#FORM.ConfirmP1#'
WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="finduser" DataSource="Corporate"> 
SELECT * 
FROM CAR_LOGIN "LOGIN" 
WHERE ID = #URL.ID# 
</cfquery>

<cfmail 
from="CAR.Web.Site@ul.com" 
to="#Email#"
subject="CAR Website - Password"
query="finduser">

CAR Website login information:
username - #form.username#
password - #password#

Please save this email for future reference.

You can view the CAR website here:
http://#CGI.Server_Name#/departments/snk5212/QE/
</cfmail>

	  <cflock scope="SESSION" timeout="5">
	  <cfset SESSION.Auth = StructNew()>
      <cfset SESSION.Auth.IsLoggedIn = "Yes">
	  <cfset SESSION.Auth.Password = finduser.password>
      <cfset SESSION.Auth.Name = finduser.Name>
      <cfset SESSION.Auth.username = finduser.username>	  
      <cfset SESSION.Auth.accesslevel = finduser.accesslevel>
  	  <cfset SESSION.Auth.Email = finduser.Email>
  	  <cfset SESSION.Auth.ID = finduser.ID>	  
	  <cfset newIP = CGI.REMOTE_ADDR>
	  <cfset newBrowser = CGI.HTTP_USER_AGENT>	

	  <!--- Everything is ok. Send the user to menu template based upon their Access Level. --->
     
	<CFIF Session.Auth.AccessLevel eq "CAR">
    	<cflocation url="#CARRootDir#CARTrainingFiles.cfm" addtoken="No">
    <CFELSEIF SESSION.Auth.AccessLevel eq "AS">
    	<cflocation url="#CARRootDir#ASReports.cfm?Year=#curyear#" addtoken="No">
    <CFELSE>
    <!--- else = Superuser (SU) --->
        <cflocation url="index.cfm" addtoken="No">
    </CFIF>
      
</cflock>	
