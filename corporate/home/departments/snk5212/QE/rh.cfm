<!--- DV_CORP_002 02-APR-09 --->
<link href="css.css" rel="stylesheet" media="screen">

<cfquery datasource="Corporate" name="RH"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 1971ee65-a5af-418c-99e3-127f01bdc59f Variable Datasource name --->
SELECT * from RH
WHERE filename = '#URL.filename#'
ORDER BY RevNo DESC
<!---TODO_DV_CORP_002_End: 1971ee65-a5af-418c-99e3-127f01bdc59f Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<table>
<tr>
<td class="Web-Title">
Revision History<br>
</td>
</tr>
<tr>
<td class="web-content">
<cfoutput query="RH">
<u>File: #filename#</u><br><br>
<u>Revision Number</u>: #RevNo#<br>
<u>Revision Date</u>: #DateFormat(RevDate, 'mmmm dd, yyyy')#<br>
<u>Revision Author</u>: #RevAuthor#<br>
<u>Revision Details</u>: #RevDetails#<br><hr>
</cfoutput>
</td>
</tr>
</table>