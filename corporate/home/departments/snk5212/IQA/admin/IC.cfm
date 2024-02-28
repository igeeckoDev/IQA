<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "UL Locations - International Certification Form Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IC">
SELECT IC, ICComments, OfficeName, ID
FROM IQAtblOffices
WHERE Exist = 'Yes'
AND Physical = 'Yes'
AND SuperLocation = 'No'
ORDER BY OfficeName
</cfquery>

<table border="1">
<tr>
    <td class="blog-title" align="center">Office Name</td>
    <td class="blog-title" align="center">IC Form<br>Required</td>
    <td class="blog-title" align="center">Comments/<br>Details</td>
    <td class="blog-title" align="center">Site Profile</td>
</tr>
<cfoutput query="IC">
<tr>
    <td class="blog-content">#OfficeName# 	
		<cflock scope="Session" timeout="5">
			<cfif Session.Auth.AccessLevel eq "SU" or SESSION.Auth.AccessLevel eq "Admin">
				[<a href="IC_Edit.cfm?ID=#ID#">edit</a>]
			</cfif>
		</cflock>
	</td>
    
	<td class="blog-content" align="center"><cfif IC is "Yes"><b>x</b><cfelse>--</cfif></td>
    <td class="blog-content" align="center"><a href="IC_Details.cfm?ID=#ID#">view</a></td>
    <td class="blog-content" align="center"><a href="Office_Details.cfm?ID=#ID#">View</a></td>
</tr>
</cfoutput>
</table><br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->