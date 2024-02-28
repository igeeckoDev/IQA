<CFQUERY BLOCKFACTOR="100" name="output" Datasource="Corporate">
SELECT * FROM Info
</cfquery>

<cfif output.recordcount is 0>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
INSERT INTO Info(ID, Name, Moves, NewFacilities, changes, scheduling, Posted)
VALUES (1, '#Form.Name#', '#Form.Moves#', '#Form.NewFacilities#', '#Form.Changes#', '#Form.Scheduling#', '#Form.Posted#')
</CFQUERY>

<cfelse>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT MAX(ID) + 1 AS new FROM Info
</CFQUERY>
   
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
INSERT INTO Info(ID, Name, Moves, NewFacilities, changes, scheduling, Posted)
VALUES (#Query.new#, '#Form.Name#', '#Form.Moves#', '#Form.NewFacilities#', '#Form.Changes#', '#Form.Scheduling#', '#Form.Posted#')
</CFQUERY>
</cfif> 
   
<CFQUERY BLOCKFACTOR="100" name="output" Datasource="Corporate">
SELECT * FROM Info
<cfif output.recordcount is 0>
WHERE ID=1
<cfelse>
WHERE ID=#Query.new#
</cfif>
</CFQUERY>  

<cfmail to="Internal.Quality_Audits@ul.com" from="Internal.Quality_Audits@ul.com" subject="#Form.Name# - Information Request">

Submitted By:
#Name#
#Dateformat(Posted, 'mm/dd/yyyy')#

Planned moves of facilities of lab areas:
#Moves#

Facilties opening:
#NewFacilities#

Regional Changes impacting the Quality Management System:
#Changes#

Areas not yet scheduled:
#Scheduling#

</cfmail>

<cfoutput query="output">
	<cflocation url="Info_Detail.cfm?ID=#ID#" addtoken="no">
</cfoutput>