<cfset subTitle = "Web Help - Audit Notifications/Site Contacts">
<cfinclude template="webhelp_StartOfPage.cfm">

<b><u>Site Contacts</u></b><br>
For each UL site, the Audit Database keeps a list of contacts who are informed of upcoming audits. The Audit Scheduler currently sends out audit notifications for IQA Audits the first day of the month preceding an audit. (i.e., on April 1, notifications are sent for all audits scheduled for May) The contacts include:<br>
<ul class="arrow2">
<br />
<li class="arrow2">IQA Audit Contacts</li>
<li class="arrow2">Regional Audit Contacts</li>
<!--- removed 11/09/2009 
<li>QRS Contact</li>
--->
</ul>

If there are multiple names for one field, the addresses should be separated with a comma.<br><br>

Regional Quality Staff can update their region's contacts by selecting 'Site Profiles' or 'Location Information' on the admin menu. <!---QRS can view all contacts and only edit the QRS contact under 'Location Information'.---> IQA can edit all contacts for all sites. For IQA logins, the notification list is listed under 'Site Profiles' and then 'Audit Contacts' under the UL site name. <u>These contacts are listed with their <font color="red">external UL email address</font></u>.<br><br>

<font color="red"><u>Important</u></font>: If the email address is improperly entered, the audit notification will not be sent out. Please use the <a href="/phonelist/" target="_blank">Global Employee Directory</a> to verify the email addresses are correct. The preferred method would be to copy/paste the email addresses to prevent unintentional typographical errors.<br><br>

<!--- 11/09/2009 added detail about primary AND other contacts fields --->
<b><u>Audit Details 'Primary Contact' and 'Other Contact(s)'</u></b><br>
When adding an audit, there is a field for 'Primary Contact' and 'Other Contact(s)'. If there are any additional contacts that should be notified of the audit, please enter these email addresses here. These Primary and Other Contacts are the 'To' and 'CC' fields of the audit scope letter and report notification. Please add only one email to the Primary Contact field, Other Contacts can be more than one email address.<br><br>

<!--- 11/09/2009 added --->
<font color="red"><u>Important</u></font>: The Audit Scope Letter, Report Notification, and Audit Notifications will not be sent properly if incorrect email addresses are used, or names. Please be very careful to verify your work when entering email addresses of audit contacts.<br><br>

<cfinclude template="webhelp_EndOfPage.cfm">