<link href="css.css" rel="stylesheet" media="screen">

<cfquery Datasource="Corporate" name="Office">
SELECT OfficeName FROM IQAtblOffices
WHERE ID = #url.ID#
</cfquery>

<cfquery Datasource="Corporate" name="RH"> 
SELECT ID, OfficeNameId, RevNo, RevDate, RevAuthor, RevDetails 
FROM SNAP_RH
WHERE OfficeNameID = #url.id#
ORDER BY RevNo DESC
</CFQUERY>

<table>
<tr>
<td class="Web-Title">
SNAP Revision History<br>
</td>
</tr>
<tr>
<td class="Web-content">
<cfoutput query="Office">
<B>#OfficeName#</B><hr>
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