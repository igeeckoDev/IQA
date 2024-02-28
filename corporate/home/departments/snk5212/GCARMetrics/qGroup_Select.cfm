<!--- Start of Page File --->
<cfset subTitle = "Select Custom CAR Grouping">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("URL.msg")>
	<cfoutput>
    	<span class="warning"><b>#url.msg#</b></span>
    </cfoutput><br /><br />
</cfif>

<cfquery name="getGroups" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DISTINCT groupName, groupType as FunctionField
FROM GCAR_Metrics_Function_Grouping
GROUP BY groupType, groupName
ORDER BY groupType, groupName
</cfquery>

<cfset setQueryString = "&Group=Yes&Manager=None&View=All&Type=All&Program=null&showPerf=No">

<cfset FunctionFieldHolder = "">

<b>Custom CAR Groupings</b><br /><Br />

<a href="getEmpNo.cfm?page=Group_Add">Add Grouping</a><br /><br />

<Table border="1">
	<tr>
        <th width="250">Group Name</th>
        <th>View CARs</th>
        <th>View Definition</th>
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
        	<cfif FunctionField eq "CARProgramAffected">
				<a href="qProgram_Grouping.cfm?groupName=#groupName#&var=#FunctionField##setQueryString#">View CARs</a>
            <cfelse>
            	<a href="qManager.cfm?groupName=#groupName#&var=#FunctionField##setQueryString#">View CARs</a>
            </cfif>
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