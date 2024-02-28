<CFQUERY BLOCKFACTOR="100" NAME="Notify" DataSource="Corporate">
UPDATE ERROR_IQA
SET
ResponseDate=#CreateODBCDateTime(now())#,
Response='Sent'
WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Output" DataSource="Corporate">
SELECT * FROM Error_IQA
WHERE ID = #URL.ID#
</CFQUERY>

<cfmail from="IQA.Error.Reporting@ul.com" to="Christopher.J.Nicastro@ul.com, Kai.Huang@ul.com" cc="Internal.Quality_Audits@ul.com" subject="IQA Error Reporting" query="Output" type="html">
This email is in response to an IQA Error Report you sent on #Logged#.<br /><br />

<u>Issue</u>:<br />
#Issue#<br /><br />

<u>Corrective Action Summary</u>:<br />
#CAShort#<br /><br />

<u>Preventive Action Summary</u>:<br />
#PAShort#<br /><br />

<u>Response Date</u>:<br />
#ResponseDate#<br /><br />

-------<br /><Br />

<u>Error ID</u>: #ID#<br />
<u>Date/Time</u>: #Logged#<br />
<u>Sent By</u>: #Name# (#Email#)<br /><br />

<u>Details</u>:<br />
#Details#
</cfmail>

<cflocation url="error_view.cfm?id=#url.id#" ADDTOKEN="No">