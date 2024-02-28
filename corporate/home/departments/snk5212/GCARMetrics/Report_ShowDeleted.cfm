<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - Index of Deleted CAR Trend Reports">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="Reports" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, Function, FunctionField, sortField, ReportType
FROM GCAR_METRICS_QREPORTS
WHERE Status = 'Removed'
ORDER BY FunctionField, SortField, Function
</cfquery>

<u><b>Deleted CAR Trend Reports</b></u><br />
Select a report below in order to reinstate the report as an active and viewable report.<br><br />

<cfif Reports.RecordCount eq 0>
There are currently no deleted CAR Trend Reports
<cfelse>

<cfif isDefined("Form.EmpNo")>
    <cflock scope="SESSION" timeout="60">
        <cfset SESSION.Auth = StructNew()>
        <cfset SESSION.Auth.IsLoggedIn = "No">
        <cfset SESSION.Auth.AccessLevel = "UserReportManage">
        <cfset SESSION.Auth.IsLoggedInApp = "#this.Name#">
        <cfset SESSION.Auth.EmpNo = "#Form.EmpNo#">
        <cfset SESSION.Auth.Name = "#Form.EmpNo#">
    </cflock>
</cfif>

<cfset FunctionFieldHolder = "">
<cfset SortFieldHolder = "">

<cfoutput query="Reports">
<cfinclude template="shared/incVariables_Report.cfm">
<cfif FunctionFieldHolder IS NOT FunctionField>
    <cfIf len(FunctionFieldHolder)><br></cfif>
    <!--- translation from field name to label name - i.e., CARTypeNew = Process Impacted, etc --->
    <b>#FunctionFieldName#</b><br>
    <cfset sortFieldHolder = "">
</cfif>

<cfif SortFieldHolder IS NOT SortField>
	<cfif len(SortFieldHolder)><br /></cfif>
    #space2#<u>by #SortFieldName#</u><br />
</cfif>

#space# <a href="Report_Reinstate.cfm?ID=#ID#">#Function#</a> (#ReportType#)<br>
<cfset FunctionFieldHolder = FunctionField>
<cfset sortFieldHolder = SortField>
</cfoutput><Br><br>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->