<CFQUERY DataSource="Corporate" Name="Details" maxRows="1"> 
SELECT webHelp.ID, webHelp.fileName, webHelp.Title, webHelp.Category, webHelp_Rev.RevNumber, webHelp_Rev.RevDate, webHelp_Rev.ID as webHelp_RevID
FROM webHelp, webHelp_Rev
WHERE webHelp.ID = #URL.ID#
AND webHelp.ID = webHelp_Rev.webHelpID
ORDER BY RevNumber DESC
</CFQUERY>

<CFQUERY DataSource="Corporate" Name="newMaxID" maxRows="1"> 
SELECT MAX(ID)+1 as newWebHelp_RevID FROM WebHelp_Rev
</CFQUERY>


New Rev (webHelp_Rev.RevNumber + 0.1)<br>
New Rev Date (Select)<br>
New Review ID (newMaxID.newWebHelp_RevID)<br>
New Rev Description<br><br>

update webHelp_Rev....
ID
WebHelpID
RevNumberOld = 0
RevDateDescription
RevNumber