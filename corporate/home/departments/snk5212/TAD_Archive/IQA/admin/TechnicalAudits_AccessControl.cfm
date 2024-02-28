<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Access Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>View Users</b><br><br>
<CFQUERY Name="Users" Datasource="Corporate">
SELECT *
From IQADB_Login
WHERE AccessLevel = 'Technical Audit'
ORDER BY Status DESC, Name
</CFQUERY>

<cfif isDefined("url.msg")>
	<cfoutput>
    	<font class="warning"><b>Message</b>: #url.msg#</font><br /><br />
    </cfoutput>
</cfif>

<table border="1">
<tr>
	<th>Name</th>
    <th>Email</th>
    <th>Status</th>
    <th>Change Status</th>
</tr>
<cfoutput query="Users">
<tr>
	<td>#Name#</td>
    <td>#Email#</td>
	<td style="text-transform: capitalize;">
		<cfif len(Status)>
        	#Status#
		<cfelse>
        	Active
		</cfif>
	</td>
	<td align="center">
    	<cfif Email neq "Lenore.J.Berman@ul.com" AND Email neq "Antonio.L.Romanacce@ul.com">
            <A href="TechnicalAudits_AccessControl_Edit.cfm?ID=#ID#&verifyID=#Hash(ID)#">
                <img src="#SiteDir#SiteImages/ico_article.gif" border="0" />
            </A>
        <cfelse>
        N/A
	    </cfif>
    </td>
</tr>
</cfoutput>
</table>

<br /><br />
<a href="TechnicalAudits_AccessControl_Add.cfm"><b>Add</b></a> Account<br /><br />

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->