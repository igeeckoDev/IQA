<cflock scope="Session" timeout="5">
<table width="600">
<tr>
<td width="600" colspan="2" class="blog-content" valign="top" align="left">
<cfoutput>
:: <a href="Andon_Add.cfm">Andon Checklist - Add New</a><br>
	<cfif SESSION.Auth.AccessLevel eq "SU">
    :: <a href="manage.cfm?Role=Andon">Manage Andon Users</a><br />
    </cfif>
:: <a href="admin.cfm">Return to IQA Admin Menu</a><br />
</cfoutput> 
<cfinclude template="Andon_user_credentials.cfm">
</td>
</tr>
</table>
</cflock>