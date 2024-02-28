</td>
</tr>
<tr>
<td class="web-content" align="center">
<cfinclude template="webhelp_footer.cfm">
</td>
</tr>
<tr>
<td class="blog-time" align="left">
<cfinclude template="revhist.cfm">
</td>
</tr>
</table>

<cfif isDefined("URL.Type")>
	<cfif URL.Type eq "inLine">
        <!--- Footer, End of Page HTML --->
        <cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
        <!--- / --->
    </cfif>
</cfif>