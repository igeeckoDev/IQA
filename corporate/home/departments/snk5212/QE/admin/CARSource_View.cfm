<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate">
SELECT * FROM CARSource
ORDER BY CARSource
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="MaxID" DataSource="Corporate">
SELECT MAX(ID) as MaxID FROM CARSource
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Source - Configuration">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<cfif isDefined("URL.Duplicate") AND isDefined("URL.Value")>
	<font color="red">CAR Source
	<cfif URL.Duplicate eq "No">
		[#URL.Value#] has been added to the CAR Source List
	<cfelseif URL.Duplicate eq "Yes">
		[#URL.Value#] already exists in the CAR Source List
	<cfelseif URL.Duplicate eq "Edit">
		[#URL.OldValue#] has been changed to <b>#URL.Value#</b>
	<cfelseif URL.Duplicate eq "Remove">
		[#URL.Value#] - Status has been changed to '#URL.Action#'
	<cfelseif URL.Duplicate eq "Cancel">
		[#URL.Value#] - Status change has been cancelled. Current status is '#URL.Action#'
	</cfif>
	</font><br><br>
</cfif>
</cfoutput>

<b><a href="CARSource_Add.cfm">Add CAR Source</a></b>
<br /><br />

<Table border="1" width="700" style="border-collapse: collapse;">
<tr class="blog-title">
<td colspan="2" align="center">CAR Source</td>
<td align="center">CAR Source Explanation</td>
<td align="center">Verification Responsibility<br>Corporate CARs</td>
<td align="center">Verification Responsibility<br>Local CARs</td>
</tr>
<CFOUTPUT query="CARSource">
<tr class="blog-content" valign="top">
<td valign="top" align="left">#CARSource# <a href="CARSource_edit.cfm?ID=#ID#">[edit]</a>
<cfif status eq 0><br><font color="red"><b>(removed)</b></font></cfif>
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