<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Deputy Technical Audits Manager Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("URL.msg")>
	<cfoutput>
		<font class="warning">Message:</font> #URL.msg#<br /><br />
	</cfoutput>
</cfif>

<cfquery Datasource="UL06046" name="TAM"> 
SELECT 
	Name, Email, Status, ID
FROM 
	TechnicalAudits_TAMList
WHERE
	Status IS NULL
ORDER BY 
	Name
</CFQUERY>

<a href="TechnicalAudits_TAM_Add_Search.cfm"><b>Add Name</b></a><br /><br />

<table border="1">
<tr>
	<th>Name</th>
	<th>Email</th>
<!---
    <th>Status</th>
    <th>Manage</th>
--->
</tr>
<CFOUTPUT Query="TAM"> 
	<tr align="left" valign="top">
    	<td nowrap>#Name#</td>
   	    <td align="center">#Email#</td>
<!---
        <td align="center"><cfif len(status)>#Status#<cfelse>Active</cfif></td>
        <td align="center">
        	<a href="TechnicalAudits_TAM_Edit.cfm?ID=#ID#">
        		<img src="#SiteDir#SiteImages/ico_article.gif" border="0" />
            </a>
        </td>
--->
    </tr>
</CFOUTPUT>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->