<cfquery name="FAQ15" datasource="Corporate" blockfactor="100">
SELECT *
FROM CAR_FAQ15
WHERE ID <> 7
ORDER BY ID
</cfquery>

<table border="1" width="666" style="border-collapse: collapse;">
<tr>
<td class="blog-title" align="center">Process Step</td>
<td class="blog-title" align="center">Items to Confirm</td>
</tr>
<tr>
<cfoutput query="FAQ15">
<tr>
<td class="Blog-content" align="center" valign="top">
<br>#TitleText#<br><br>
<cfif ID NEQ 7>
	<img src="#CARRootDir#images/arrow1.jpg" border="0" align="bottom"><br>
	<img src="#CARRootDir#images/arrow2.jpg" border="0" align="absbottom">
</cfif>
</td>
<td class="Blog-content">#ItemsToConfirm#</td>
</tr>
</cfoutput>
</table>