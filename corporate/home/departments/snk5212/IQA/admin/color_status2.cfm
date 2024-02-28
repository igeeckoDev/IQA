<b>Legend</b>:<br>
<img src="../images/red.jpg" border="0"> - Audit Rescheduled<br>
<cfif auditedby is "IQA">
<img src="../images/orange.jpg" border="0"> - Audit Completed, No Close Out Letter (TP Only)<br>
</cfif>
<img src="../images/yellow.jpg" border="0"> - Audit Scheduled<br>
<cfif auditedby is "QRS" or auditedby is "AS" or auditedby is "AllAccred">
<img src="../images/green.jpg" border="0"> - Audit Completed<br>
<cfelse>
<img src="../images/green.jpg" border="0"> - Audit Completed, Report Completed<br>
<img src="../images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
</cfif>
<img src="../images/black.jpg" border="0"> - Audit Cancelled<br>
<img src="../images/ico_article.gif" border="0"> - View Notes (for Cancelled and Rescheduled Audits)<br>