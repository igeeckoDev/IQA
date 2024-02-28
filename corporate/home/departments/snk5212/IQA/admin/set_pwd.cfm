<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Global Login - Set Password">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" name="finduser" Datasource="Corporate"> 
SELECT * FROM IQADB_LOGIN 
WHERE ID = #URL.ID#
</cfquery>

<script language="javascript"> 
<!-- 
function check_current_pw() 
{
	if (document.theForm.ConfirmP1.value != document.theForm.ConfirmP2.value){
		alert ("The confirmation password and new password to not match.");
		return false;
	 } 
	 
  return true;	 
}
//-->
</script>

<div class="blog-time">Login Help - <A HREF="javascript:popUp('../webhelp/webhelp_login.cfm')" title="IQA Web Help Link">[?]</A></div><br>

<CFOUTPUT query="finduser">
Welcome, #name#!<br>
Since this is your first time logging into this system, please change your password.<br>
An email will be sent to the email address provided below.<br><br>

You will be redirected back to the site once the password change has been processed.<br><br>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="theForm" ACTION="set_pwd_update.cfm?ID=#ID#" onsubmit="return check_current_pw()">
<INPUT TYPE="HIDDEN" name="username" value="#username#">
<INPUT TYPE="HIDDEN" name="password" value="#password#">
<INPUT TYPE="HIDDEN" name="ID" value="#ID#">

New Password:<br>
<cfINPUT TYPE="password" NAME="ConfirmP1" required="yes" message="Enter your new password"><br><br>

Confirm Password:<br>
<cfINPUT TYPE="password" NAME="ConfirmP2" required="yes"  message="Confirm your password"><br><br>

You will receive a confirmation of the password change sent to:<br>
<u>#Email#</u><br><br>

<INPUT TYPE="Submit" value="Submit Changes">

</cfFORM>
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->