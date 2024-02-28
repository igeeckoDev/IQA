<cfquery name="FAQ4" datasource="Corporate" blockfactor="100">
SELECT * FROM CAR_FAQ4
WHERE STATUS = 1
ORDER BY ID
</cfquery>

<table border="1" width="666" style="border-collapse: collapse;">
<tr>
<td class="blog-title" align="center">Type of Noncompliance</td>
<td class="blog-title" align="center">Initial CAR Owner</td>
</tr>
<cfoutput query="FAQ4">
<tr>
<td class="Blog-content" align="left" valign="top">
#TypeOfNC#
</td>
<td class="Blog-content" align="left" valign="top">
#InitialCAROwner#
</td>
</tr>
</cfoutput>
</table>