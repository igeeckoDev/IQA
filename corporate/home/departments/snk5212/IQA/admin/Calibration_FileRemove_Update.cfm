<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachRemove">
UPDATE CalibrationMeetings_Attach
SET 
Remove = <cfqueryparam value="#URL.Remove#" CFSQLTYPE="CF_SQL_VARCHAR">
WHERE ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachFile">
SELECT * FROM CalibrationMeetings_Attach
WHERE ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

<cfif URL.Remove eq "Yes">
	<cfset status = "removed">
<cfelseif URL.Remove eq "No">
	<cfset status = "reinstated">
</cfif>

<cflocation url="Calibration_Details.cfm?ID=#URL.MeetingID#&msg=#AttachFile.filelabel# (#AttachFile.filename#) has been #status#" addtoken="No">