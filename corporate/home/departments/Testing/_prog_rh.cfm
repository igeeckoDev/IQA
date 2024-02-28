<link href="css.css" rel="stylesheet" media="screen">

<cfquery Datasource="Corporate" name="Prog">
SELECT Program from ProgDev
WHERE ProgDev.ID = #URL.ProgID#
</CFQUERY>

<cfquery Datasource="Corporate" name="RH">
SELECT * from ProgDev_RH
WHERE ProgID = #URL.ProgID#
ORDER BY RevNo DESC
</CFQUERY>

<table>
<tr>
<td class="Web-Title">
Program Revision History<br>
</td>
</tr>
<tr>
<td class="Web-content">
<cfoutput query="Prog">
<B>#Program#</B><hr>
</cfoutput>
</td>
</tr>
<tr>
<td class="web-content">
<cfoutput query="RH">
<u>Revision Number</u>: #RevNo#<br>
<u>Revision Date</u>: #DateFormat(RevDate, 'mmmm dd, yyyy')#<br>
<u>Revision Author</u>: #RevAuthor#<br>
<u>Revision Details</u>: #RevDetails#<br><hr>
</cfoutput>
</td>
</tr>
</table>