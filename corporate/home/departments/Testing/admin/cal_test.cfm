<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="check">
SELECT * FROM CalibrationItems
WHERE MeetingID = #URL.ID#
</CFQUERY>

<cfif check.recordcount eq 0>
<cfset maxItemId.maxItemID = 1>
<cfelse>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxItemID">
SELECT MAX(ItemID)+1 as maxItemID FROM CalibrationItems
WHERE MeetingID = #URL.ID#
</CFQUERY>
</cfif>

<cfoutput>
#maxItemID.maxItemID#
</cfoutput>
