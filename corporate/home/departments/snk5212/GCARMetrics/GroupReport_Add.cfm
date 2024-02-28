<!--- Start of Page File --->
<cfset subTitle = "Add a CAR Trend Report - Custom CAR Grouping">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="getGroups" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DISTINCT groupName, groupType as FunctionField
FROM GCAR_Metrics_Function_Grouping
GROUP BY groupType, groupName
ORDER BY groupType, groupName
</cfquery>

<cfset setQueryString = "&Group=Yes&Manager=None&View=All&Type=All&Program=null&showPerf=No">

<cfset FunctionFieldHolder = "">

<b>View Custom CAR Groupings</b><br /><Br />
<Table border="1">
	<tr>
        <th width="250">Group Name</th>
        <th>Create Report</th>
        <th>Show Grouping</th>
	</tr>
<cfoutput query="getGroups">
	<!--- Assign appropriate lables/names based on url variables --->
    <cfinclude template="shared/incVariables_Report.cfm">

	<cfif FunctionFieldHolder IS NOT FunctionField>
        <cfIf len(FunctionField)></tr><tr><td colspan="3"></cfif>
        <b><u>#FunctionFieldName#</u> Groupings</b>
        </tr>
    </cfif>
    <tr>
		<td>#GroupName#</td>
		<td align="center">
			<a href="GroupReport_Create.cfm?Function=#groupName#&FunctionField=#FunctionField#&ReportType=#url.ReportType#">Create Report</a>
		</td>
        <td align="center">
        	<a href="Grouping_Definition.cfm?groupName=#groupName#&groupType=#FunctionField#">Show Grouping</a>
        </td>
    </tr>

<cfset FunctionFieldHolder = FunctionField>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->