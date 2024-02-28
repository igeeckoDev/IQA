<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Source - Configuration">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate">
SELECT * FROM CARSource
WHERE Status = 1
ORDER BY CARSource
</cfquery>

<Table border="1" width="700" style="border-collapse: collapse;">
<tr class="blog-title">
<td colspan="2" align="center">CAR Source</td>
<td align="center">CAR Source Explanation</td>
<td align="center">Verification Responsibility<br>Corporate CARs</td>
<td align="center">Verification Responsibility<br>Local CARs</td>
</tr>
<CFOUTPUT query="CARSource">
<tr class="blog-content" valign="top">
<td valign="top" align="left">#CARSource#
</td>
<td valign="top" align="left">
<cfif CARSource2 neq "">
#CARSource2#
</cfif>
&nbsp;
</td>
<td align="left" valign="top">
<cfset dump = #replace(Description, "<p>", "", "All")#>
<cfset dump2 = #replace(dump, "</p>", "", "All")#>
#dump2#
<cfif Description neq "">
	<br><br>
<cfelse>
	&nbsp;
</cfif>
</td>
<td align="center" valign="top">#CorpCAR#</td>
<td align="center" valign="top">#LocalCAR#</td>
</tr>

</CFOUTPUT>
</TABLE>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->