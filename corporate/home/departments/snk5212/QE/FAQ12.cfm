<cfquery name="CARSource" datasource="Corporate" blockfactor="100">
SELECT * FROM CARSource
WHERE Status = 1
ORDER BY CARSource
</cfquery>

<Table border="1" width="700">
<tr class="blog-title">
<td colspan="2" align="center">CAR Source</td>
<td align="center">CAR Source Explanation</td>
<td align="center">Verification Responsibility<br>Corporate CARs</td>
<td align="center">Verification Responsibility<br>Local CARs</td>
</tr>
<CFOUTPUT query="CARSource">
<tr class="blog-content" valign="top">
<td valign="top" align="left">#CARSource#
<cfif status eq 0><br><font color="red"><b>(removed)</b></font></cfif>
</td>
<td valign="top" align="left">
<cfif CARSource2 neq "">
#CARSource2#
</cfif>
&nbsp;
</td>
<td align="left" valign="top">#Description# &nbsp;</td>
<td align="center" valign="top">#CorpCAR#</td>
<td align="center" valign="top">#LocalCAR#</td>
</tr>
</CFOUTPUT>
</TABLE>