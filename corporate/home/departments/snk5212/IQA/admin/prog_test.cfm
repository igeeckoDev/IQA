<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY name="Programs" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 524dde65-abc4-4457-b16f-2067ffb2f4b7 Variable Datasource name --->
SELECT Type, IQA, Program FROM Programs
WHERE IQA = 1
ORDER BY Program
<!---TODO_DV_CORP_002_End: 524dde65-abc4-4457-b16f-2067ffb2f4b7 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<SELECT NAME="Area" displayname="Program">
		<OPTION VALUE="">Select Program Below
		<OPTION Value="">---
<CFOUTPUT QUERY="Programs">
		<OPTION VALUE="#Program#"> - #Program#
</cfoutput>
</SELECT>