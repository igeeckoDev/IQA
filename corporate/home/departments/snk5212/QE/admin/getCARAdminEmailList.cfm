<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Admin Email List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

Select the text and copy. Then, paste it into an email 'To' field.<br><br>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="CARAdminList">
SELECT Email FROM CARAdminList
WHERE Status = 'Active' 
OR Status = 'CAR Administration Support' 
OR Status = 'In Training'
ORDER BY Email
</CFQUERY>

<cfset Emails = #valueList(CARAdminList.Email, '; ')#>

<Table>
<tr>
<td width=400>
<cfoutput>#Emails#</cfoutput>
</td>
</tr>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->