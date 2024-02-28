<cfif isDefined("Form.Status")>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit">
UPDATE Auditors_VS
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

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="History">
SELECT History FROM Auditors
WHERE ID = #URL.ID#
</cfquery>

<cflock scope="SESSION" timeout="6">
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit2">
	UPDATE Auditors_VS
	SET
	
	History = '#History.History#<br><br>Auditor Edited #curdate#<br>Status Changed to #form.Status#<br>Effective Date #Form.StatusDate#<br>Changed By: #SESSION.Auth.Name#/#Session.Auth.UserName#'
	
	WHERE ID = #URL.ID#
	</CFQUERY>
</cflock>

<cflocation url="VS_Auditors.cfm" addtoken="no">

<cfelse>

<cflocation url="VS_Auditors_Edit.cfm?ID=#ID#" addtoken="no">

</cfif>