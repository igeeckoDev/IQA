<b>Legend</b>:<br>
<img src="images/red.jpg" border="0"> - Audit Rescheduled<br>
<cfif url.auditedby is "IQA" AND url.year LTE 2007>
<img src="images/orange.jpg" border="0"> - Audit Completed, No Close Out Letter (TP Only)<br>
</cfif>
<img src="images/yellow.jpg" border="0"> - Audit Scheduled<br>
<cfif url.auditedby is "QRS" or url.auditedby is "AS" or url.auditedby is "AllAccred" or url.auditedby is "Finance">
<img src="images/green.jpg" border="0"> - Audit Completed<br>
<cfelse>
<img src="images/green.jpg" border="0"> - Audit Completed, Report Completed<br>
<img src="images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
</cfif>
<img src="images/black.jpg" border="0"> - Audit Cancelled<br>