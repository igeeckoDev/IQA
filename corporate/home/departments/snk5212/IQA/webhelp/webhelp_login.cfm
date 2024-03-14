<cfset subTitle = "Web Help - Login">
<cfinclude template="webhelp_StartOfPage.cfm">

<!--- 12/29/2010 - added CAR Process login info --->
<b><u>Login</u></b><br>
Select 'login' on the upper right of the IQA Audit Database home page or the CAR Process home page.<br />
<cfoutput>
[IQA: <a href="#IQADir#">IQA Audit Database Home</a>]<br>
[CAR Process: <a href="#CARDir#">CAR Process Home</a>]<br>
</cfoutput><br />

Type in your user name and password and select 'Login'.<br><br>

IQA: You will be taken to either the IQA audit schedule or your region/area's audit schedule with a top level menu to navigate your available admin functions.<br>
CAR Process: You will be taken to a new menu to navigate your available admin functions.<br /><br>

<!--- 11/09/2009 editorial changes made below... added 'send username', and link to emp directory --->
<cfoutput>
<b><u>Unknown user name</u></b><br>
If you have forgotten your user name, select the link below the login form entitled <u>Send Username</u>. Enter your external UL email address and select 'submit info'. Your user name and password will be sent to your email address on record. If your email address is not found, first please check the spelling and syntax or use the <a href="#request.serverProtocol##request.serverDomain#/phonelist/">Employee Directory</a> to verify your external email address. If it is still not found, you may not have an account for this system. Please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Chris Nicastro</a> for further assistance.<br><br>
</cfoutput>
<!--- 11/09/2009 editorial changes made below... added 'send password', and 'please contact' information --->
<b><u>Unknown password</u></b><br>
If you know your user name and have forgotten your password, select the link below the login form entitled <u>Send Password</u>. Enter your user name and select 'submit info'. Your user name and password will be sent to your email address on record. If no account is found, Please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Chris Nicastro</a> for further assistance.<br><br>

<cfinclude template="webhelp_EndOfPage.cfm">