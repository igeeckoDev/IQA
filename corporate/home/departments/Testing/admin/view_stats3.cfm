<CFQUERY BLOCKFACTOR="100" name="Log" DataSource="Corporate">
SELECT DISTINCT Path FROM PageViews
UNION ALL
SELECT DISTINCT Path FROM PageViews2
</cfquery>

<cfdump var="#Log#">

<!---
<cfquery name="PathCount" dbtype="query">
SELECT COUNT(Path) as Count FROM Log
WHERE Path = '/departments/snk5212/iqa/_prog.cfm'
</cfquery>

<cfoutput query="PathCount">
#Count#
</cfoutput>
--->