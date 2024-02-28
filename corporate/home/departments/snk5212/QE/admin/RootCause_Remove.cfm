<CFQUERY BLOCKFACTOR="100" NAME="RootCause" DataSource="Corporate"> 
SELECT * FROM CAR_RootCause
WHERE ID = #URL.ID#
</cfquery>

<cfif URL.Action is "Remove">
	<cfif Form.Remove is "Cancel Request">
		<cflocation url="RootCause_Add.cfm?duplicate=Cancel&value=#RootCause.Category#&Action=Remove" addtoken="No">
	<cfelseif form.Remove is "Confirm Request">
		<CFQUERY BLOCKFACTOR="100" NAME="Add" DataSource="Corporate"> 
		UPDATE CAR_RootCause
		SET
		status = 0
		WHERE ID = #URL.ID#
		</cfquery>
		
		<cflocation url="RootCause_Add.cfm?duplicate=Remove&value=#RootCause.Category#&Action=Remove" addtoken="No">
	</cfif>
<cfelseif URL.Action is "Reinstate">
	<cfif Form.Remove is "Cancel Request">
		<cflocation url="RootCause_Add.cfm?duplicate=Cancel&value=#RootCause.Category#&Action=Reinstate" addtoken="No">
	<cfelseif form.Remove is "Confirm Request">
		<CFQUERY BLOCKFACTOR="100" NAME="Add" DataSource="Corporate"> 
		UPDATE CAR_RootCause
		SET
		status = 1
		WHERE ID = #URL.ID#
</cfquery>
		<cflocation url="RootCause_Add.cfm?duplicate=Remove&value=#RootCause.Category#&Action=Reinstate" addtoken="No">
	</cfif>
</cfif>

