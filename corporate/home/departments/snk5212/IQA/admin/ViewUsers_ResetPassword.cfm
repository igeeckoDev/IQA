<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Accounts"> 
SELECT * FROM IQADB_LOGIN
WHERE ID = #URL.ID#
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "IQA Audit Database Users - Reset Password">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfFORM METHOD="POST" name="sAccredAction" ACTION="ViewUsers_ResetPassword_Action.cfm?ID=#URL.ID#">
<cfoutput query="Accounts">
Do you wish to reset the password for the user <b>#Username#</b>?<br /><br />
</cfoutput>

Selecting 'Confirm' will reset the user's password and send them an email of this change with instructions on how to proceed.<br />
Selecting 'Cancel' will return you to the user's account detail page.<br /><br />

<INPUT TYPE="Submit" name="PasswordReset" Value="Confirm">
<INPUT TYPE="Submit" name="PasswordReset" Value="Cancel">
</cfform>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->