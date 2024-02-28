<cfif isDefined("Form.Status")>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Edit">
UPDATE Auditors_LTA
SET

<cfif form.status is "Active">
Status = NULL,
ActiveDate = #CreateODBCDate(Form.StatusDate)#,
RemoveDate = NULL
<cfelseif form.status is "Removed">
Status = 'removed',
RemoveDate = #CreateODBCDate(Form.StatusDate)#,
ActiveDate = NULL
</cfif>

WHERE ID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="History">
SELECT History 
FROM Auditors
WHERE ID = #URL.ID#
</cfquery>

<cflock scope="SESSION" timeout="6">
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Edit2">
	UPDATE Auditors_LTA
	SET
	
	History = '#History.History#<br><br>Auditor Edited #curdate#<br>Status Changed to #form.Status#<br>Effective Date #Form.StatusDate#<br>Changed By: #SESSION.Auth.Name#/#Session.Auth.UserName#'
	
	WHERE ID = #URL.ID#
	</CFQUERY>
</cflock>

<cflocation url="LTA_Auditors.cfm" addtoken="no">

<cfelse>

<cflocation url="LTA_Auditors_Edit.cfm?ID=#ID#" addtoken="no">

</cfif>