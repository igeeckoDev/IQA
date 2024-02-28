<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Add a CAR Trend Report - Custom CAR Grouping">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfinclude template="shared/incVariables_Report.cfm">

<cfquery name="checkReports" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, Status
FROM GCAR_METRICS_QREPORTS
WHERE Function = '#url.Function#'
AND FunctionField = '#url.FunctionField#'
AND SortField = '#url.sortField#'
AND ReportType = '#url.ReportType#'
</cfquery>

<cfif checkReports.recordcount GT 0>
	<span class="warning">Report Exists</span><br /><Br />
    
	This report has already been created:<Br />
	<cfoutput query="checkReports">
	<a href="Report_Details.cfm?ID=#ID#">View Report</a> - #url.Function# (#FunctionFieldName#) by #SortFieldName#<br />
    </cfoutput><br />
<cfelse>

<cfquery name="getNewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as newID 
FROM GCAR_METRICS_QREPORTS
</cfquery>

<cfif NOT len(getNewID.newID)>
	<cfset getNewID.newID = 1>
</cfif>

<cfset PostedDate = DateFormat(now(),"mm/dd/yyyy")>
<cfset PostedTime = TimeFormat(now(), "hh:mm tt")>

<cflock scope="SESSION" timeout="6">
    <cfquery name="CreateReport" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO GCAR_METRICS_QREPORTS(ID, TopItems, Function, FunctionField, SortField, PostedDate, ReportType, isGroup)
    VALUES(#getNewID.newID#, 5, '#url.Function#', '#url.FunctionField#', '#url.SortField#', #CreateODBCDate(PostedDate)#, '#url.ReportType#', '#url.Group#')
    </cfquery>
    
<cfif isDefined("SESSION.Auth")>
    <cfset variables.History = "Report Created #dateformat(PostedDate, 'mm/dd/yyyy')# #timeformat(PostedTime, 'hh:mm tt')# by #SESSION.Auth.Name#">
<cfelse>
	<CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
	SELECT  first_n_middle, last_name, preferred_name
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE employee_number = '#url.ReportType#'
	</CFQUERY>
    
    <cfif len(NameLookup.preferred_name)>
    	<cfset variables.creator = "#NameLookup.preferred_name#">
    <cfelse>
    	<cfset variables.creator = "#NameLookup.First_n_middle# #NameLookup.last_name#">
    </cfif>
	
	<cfset variables.History = "Report Created #dateformat(PostedDate, 'mm/dd/yyyy')# #timeformat(PostedTime, 'hh:mm tt')# by #variables.creator#">
</cfif>
    
    <cfquery name="AddHistory" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE GCAR_METRICS_QREPORTS
    SET
    History = <CFQUERYPARAM VALUE="#variables.History#" CFSQLTYPE="CF_SQL_CLOB">
    WHERE ID = #getNewID.newID#
    </cfquery>
</cflock>

<cflocation url="Report_Details.cfm?ID=#getNewID.newID#" addtoken="no">

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->