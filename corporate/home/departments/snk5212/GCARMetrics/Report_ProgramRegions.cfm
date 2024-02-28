<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - Program Regions">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="ProgramRegions" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#"> 
SELECT * 
FROM GCAR_Metrics_Program_Regions
WHERE STATUS IS NULL
ORDER BY Region, CARProgramAffected
</cfquery>

<Table border="1">
<tr>
    <th>Program Name</th>
    <th>Region</th>
</tr>
<cfoutput query="ProgramRegions">
<tr>
	<td>#CARProgramAffected#</td>
   	<td>#Region#</td>
</tr>
</cfoutput>
</Table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->