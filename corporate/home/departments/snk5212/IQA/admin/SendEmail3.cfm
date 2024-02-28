<cfquery name="UpdateEmail" datasource="Corporate" blockfactor="100"> 
UPDATE IQADB_SendEmail
SET

Reference='#Form.Reference#',
Subject='#form.Subject#',
EmailBody='#form.EmailBody#',
<cflock scope="Session" timeout="5">
	Author='#SESSION.Auth.Email#',
</cflock>
<cfif form.sendCC is NOT "">
	SendCC='#Form.SendCC#',
</cfif>	
SendTo='#Form.SendTo#',
SendDate=#CreateODBCDate(curdate)#
	
WHERE ID = #URL.ID#
</cfquery>

<cfquery name="Email" datasource="Corporate" blockfactor="100"> 
SELECT * FROM IQADB_SendEmail
WHERE ID = #URL.ID#
</cfquery>

<cfoutput>
	<link href="#REQUEST.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<cfmail query="Email" to="#SendTo#" from="#Author#" cc="#SendCC#" bcc="#Author#" Subject="#Subject#" failto="Christopher.J.Nicastro@ul.com" mailerid="IQAEmail#ID#" type="html">
<span class="blog-content">
Reference: #Reference#<br /><br />

#EmailBody#
</span>
</cfmail>

<cflocation url="SendEmail_ViewID.cfm?ID=#URL.ID#" addtoken="no">