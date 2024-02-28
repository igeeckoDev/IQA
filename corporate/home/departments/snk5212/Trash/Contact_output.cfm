<CFQUERY Datasource="Corporate" Name="Contacts">
SELECT * FROM IQAtblOffices
WHERE Exist = 'Yes'
AND OfficeName <> 'Corporate' 
AND OfficeName <> 'Field Services'
ORDER BY Subregion, OfficeName
</CFQUERY>

<link href="css.css" rel="stylesheet" media="screen">

<table border="1">
<cfset SB="">
<cfoutput query="Contacts">
<cfif SB IS NOT SubRegion> 
<tr><td colspan="9" class="blog-content"><b>#SubRegion#</b></td></tr>
</cfif>
<tr>
<td colspan="2" class="blog-content">#OfficeName#&nbsp;</td>
<td class="blog-content">#RQM#&nbsp;</td>
<td class="blog-content">#QM#&nbsp;</td>
<td class="blog-content">#GM#&nbsp;</td>
<td class="blog-content">#LES#&nbsp;</td>
<td class="blog-content">#Other#&nbsp;</td>
<td class="blog-content">#Other2#&nbsp;</td>
<td class="blog-content">#QRS#&nbsp;</td>
</tr>
<cfset SB="#SubRegion#">
</cfoutput>
</table>