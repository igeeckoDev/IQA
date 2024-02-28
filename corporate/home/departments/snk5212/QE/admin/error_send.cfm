<CFQUERY BLOCKFACTOR="100" NAME="Notify" DataSource="Corporate">
UPDATE CAR_ERROR
SET
ResponseDate = #CreateODBCDateTime(now())#,
Response='Sent'

WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Output" DataSource="Corporate">
SELECT * FROM CAR_Error
WHERE ID = #URL.ID#
</CFQUERY>

<cfmail from="CAR.Error.Reporting@ul.com" to="#Email#" cc="#Request.ErrorMailTo#" subject="#Request.SiteTitle# Error Reporting" query="Output" Type="HTML">
This email is in response to an #Request.SiteTitle# Error Report you sent on #Logged#.<bR><br>

Issue: <br>
#Issue#<br><br>

Corrective Action Summary:<br> 
#CAShort#<br><br>

Preventive Action Summary:<br> 
#PAShort#<br><br>

Response Date:<br>
#Dateformat(ResponseDate, "mm/dd/yyyy")# #TimeFormat(ResponseDate, "hh:MM ttt")#<br>
-------<br>
Error ID: #ID#<br>
Date/Time: #Logged#<br>
Sent By: #Name# (#Email#)<br><br>

Details:<br>
#Details#<br><br>
</cfmail>

<cflocation url="error_view.cfm?id=#url.id#" ADDTOKEN="No">