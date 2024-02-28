:: <a href="kbindex.cfm">Knowledge Base Index</a><br>
<cflock scope="Session" timeout="5">
	<cfif SESSION.Auth.AccessLevel eq "SU"
		OR SESSION.Auth.AccessLevel eq "Admin">
:: <a href="AddKBTopic.cfm">Add new Knowledge Base Main Topic</a><br>
:: <a href="AddKBItem.cfm">Add new Knowledge Base Article</a><br>
	</cfif>
</cflock>
<!---:: <a href="../kb/attachments/directory_listing.cfm">Knowledge Base File Attachment Directory Listing</a><br>--->