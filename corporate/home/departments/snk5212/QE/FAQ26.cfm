<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Root Cause Category - View">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="FAQ26" datasource="Corporate" blockfactor="100">
SELECT * FROM CAR_RootCause
WHERE Status = 1
ORDER BY Category
</cfquery>

<table border="1" width="666" style="border-collapse: collapse;">
<tr>
<td class="blog-title" align="center">Root Cause Category</td>
<td class="blog-title" align="center">Description</td>
<cflock scope="Session" timeout="6">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
    	<td class="blog-title" align="center">Edit</td>
    </cfif>
</cflock>
</tr>

<cfoutput query="FAQ26">
<tr>
<td class="Blog-content" align="left" valign="top">
#Category#
</td>
<td class="Blog-content" align="left" valign="top">
#Description#
</td>
<cflock scope="Session" timeout="6">
	<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
    	<td class="blog-title" align="center"><a href="RootCause_Edit.cfm?ID=#ID#"><img src="#CARRootDir#images/ico_article.gif" border=0 /></a></td>
    </cfif>
</cflock>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->