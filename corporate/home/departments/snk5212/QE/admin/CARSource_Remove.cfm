<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate"> 
SELECT * FROM CARSource
WHERE ID = #URL.ID#
</cfquery>

<cfif URL.Action is "Remove">
	<cfif Form.Remove is "Cancel Request">
		<cflocation url="CARSource_View.cfm?duplicate=Cancel&value=#CARSource.CARSource#&Action=Remove" addtoken="No">
	<cfelseif form.Remove is "Confirm Request">
		<CFQUERY BLOCKFACTOR="100" NAME="Add" DataSource="Corporate"> 
		UPDATE CARSource
		SET
		status = 0
		WHERE ID = #URL.ID#
		</cfquery>
		
		<cflocation url="CARSource_View.cfm?duplicate=Remove&value=#CARSource.CARSource#&Action=Remove" addtoken="No">
	</cfif>
<cfelseif URL.Action is "Reinstate">
	<cfif Form.Remove is "Cancel Request">
		<cflocation url="CARSource_Add.cfm?duplicate=Cancel&value=#CARSource.CARSource#&Action=Reinstate" addtoken="No">
	<cfelseif form.Remove is "Confirm Request">
		<CFQUERY BLOCKFACTOR="100" NAME="Add" DataSource="Corporate">
		UPDATE CARSource
		SET
		status = 1
		WHERE ID = #URL.ID#
		</cfquery>
		<cflocation url="CARSource_View.cfm?duplicate=Remove&value=#CARSource.CARSource#&Action=Reinstate" addtoken="No">
	</cfif>
</cfif>