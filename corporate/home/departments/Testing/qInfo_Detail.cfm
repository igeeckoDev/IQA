<br>

<CFQUERY BLOCKFACTOR="100" name="output" Datasource="Corporate">
SELECT * FROM Info
WHERE ID=#URL.ID#
</CFQUERY>  

<a href="info_output.cfm">View</a> past Information Request data.<br><br>
					  
<cfoutput query="output">
<b>Submitted By:</b><br>
#Name#<br>
#Dateformat(Posted, 'mm/dd/yyyy')#<br><br>

<b>Planned moves of facilities of lab areas:</b><br>
#Moves#<br><br>

<b>Facilties opening:</b><br>
#NewFacilities#<br><br>

<b>Regional Changes impacting the Quality Management System:</b><br>
#Changes#<br><br>

<b>Areas not yet scheduled:</b><br>
#Scheduling#<br><br>
</cfoutput>