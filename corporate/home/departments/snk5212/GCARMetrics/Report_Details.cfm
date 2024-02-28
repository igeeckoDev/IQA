<cfquery name="Report" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "<a href='Report.cfm'>CAR Trend Reports</a> - View #Report.Function# Report">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="Reports" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	ID, TopItems, TopItems_CARSource, TopItems_CARRootCauseCategory, Function, FunctionField, SortField, PostedDate, History, GeneralComments as Comments, Owner, CC, ReportType, Status, isGroup
FROM 
	GCAR_METRICS_QREPORTS
WHERE 
	ID = #URL.ID#
</cfquery>

<cfif isDefined("url.Deleted") AND url.Deleted eq "Yes">
	<span class="warning"><b>Report Deleted</b></span><br />
    <cfoutput>
If this was done in error, you can reinstate this report now - <a href="Report_Reinstate.cfm?ID=#ID#">Reinstate Report</a><Br />
	</cfoutput>
    If you wish to reinstate this report later, please view the <a href="Report_ShowDeleted.cfm">Deleted Reports</a> page.<br /><br />
</cfif>

<cfif isDefined("url.Reinstated") AND url.Reinstated eq "Yes">
	<span class="warning"><b>Report Reinstated</b></span><br />
    <cfoutput>
If this was done in error, you can delete this report now - <a href="Report_Delete.cfm?ID=#ID#">Delete Report</a><Br />
	</cfoutput>
    If you wish to delete this report later, you can do so from this page.<br /><br />
</cfif>

<cfif isDefined("url.added") AND url.added eq "Yes">
	<cfoutput query="Reports">
		<cfinclude template="shared/incVariables_Report.cfm">
        <span class="warning"><b>Report Added</b><br /></span>
        <u>#FunctionFieldName#</u> - #Function#<br />
        <u>Sort Field</u> - #sortFieldName#<br /><br />      
	</cfoutput>
</cfif>

<cfoutput query="Reports">
<cfinclude template="shared/incVariables_Report.cfm">
<b>#Function# (#FunctionFieldName#)</b><br />
<cfif isGroup eq "Yes">
	Custom CAR Grouping (<a href="Grouping_Definition.cfm?groupName=#Function#&groupType=#FunctionField#">View Grouping</a>)<br />
</cfif>
</cfoutput>

<cfoutput query="Reports">
<cfif Reports.ReportType eq "QE">
    <u>Owner(s)</u>: <cfif len(Owner)><Br />#replace(Owner, ",", "<br />", "All")#<br /><cfelse>None Listed<br /></cfif>
      
    <u>CC / FYI Contact(s)</u>: <cfif len(CC)><Br />#replace(CC, ",", "<br />", "All")#<br /><cfelse>None Listed<br /></cfif>
</cfif>
<u>Report Type</u>: <cfif ReportType eq "QE">Quality Engineering Supported<cfelse>#ReportType#</cfif><br /><br />

<b>#Function# Reports Available</b><br />

<!--- Graph of CARs by Top X Issues (Process Impacted, Root Cause, Org/Function, etc --->
:: <a href="Report_Graph.cfm?ID=#ID#&format=flash&sortField=#SortField#&FunctionField=#FunctionField#&Function=#Function#&Group=#isGroup#&top=#topItems#">Top #topItems# Issues - #sortFieldName#</a><br />

<!--- Graph of CARs by Source --->
:: <a href="Report_Graph.cfm?ID=#ID#&format=flash&sortField=CARSource&FunctionField=#FunctionField#&Function=#Function#&Group=#isGroup#&top=#topItems_CARSource#">Top #topItems_CARSource# CAR Sources</a><br />

<!--- Graph of CARs by Root Cause Category --->
:: <a href="Report_Graph.cfm?ID=#ID#&format=flash&sortField=CARRootCauseCategory&FunctionField=#FunctionField#&Function=#Function#&Group=#isGroup#&top=#topItems_CARRootCauseCategory#">Top #topItems_CARRootCauseCategory# Root Cause Categories</a><br />

<!--- Graph of CARs by State --->
:: <a href="Report_Graph.cfm?ID=#ID#&format=flash&sortField=CARState&FunctionField=#FunctionField#&Function=#Function#&Group=#isGroup#">CARs by State</a><br />

<!--- Table of Ineffective CARs by Process Impacted --->
:: <a href="Report_Table2.cfm?ID=#ID#&View=All&Manager=None&Program=null&Type=All&var=#FunctionField#&varValue=#Function#&var1=CARState&var1value=Closed - Verified as Ineffective&var2=CARTypeNew&Group=#isGroup#&showPerf=No">Ineffective CARs</a><br>

<!--- Table of Customer Complaints by RCC --->
:: <a href="Report_Table2.cfm?ID=#ID#&View=All&Manager=None&Program=null&Type=All&var=#FunctionField#&varValue=#Function#&var1=CARTypeNew&var1value=Customer Complaint&var2=CARRootCauseCategory&Group=#isGroup#&showPerf=No">Customer Complaints</a><br><br>

<u>Help</u><br />
:: <a href="Overview_TrendReports.cfm">CAR Trend Reports Overview</a><br /><br />

<cflock scope="Session" timeout="6">
<!--- Check to see if user is logged in --->
<cfif isDefined("SESSION.Auth.IsLoggedIn")>
	<cfif SESSION.Auth.IsLoggedIn eq "Yes">
		<!--- Show Comments --->
        <b>Quality Analysis - General Comments</b><br />
        <cfif isDefined("Comments") AND len(Comments)>
        #Comments#
        <cfelse>
        None Listed
        </cfif><br /><br />
        
        <!--- Show available admin actions - add/edit --->
        <u>Quality Analyst - Available Actions</u><br />
        <!--- Add new notes and store current notes in history --->
        :: <a href="Report_Details_Notes.cfm?Type=GeneralComments&ID=#ID#&Action=Add">Add New</a> General Comments<br />
        <!--- check for existing notes - edit current note --->
        <cfif isDefined("Comments") AND len(Comments)>
        :: <a href="Report_Details_Notes.cfm?Type=GeneralComments&ID=#ID#&Action=Edit">Edit Current</a> General Comments<br />
        </cfif>
        <!--- Add/Change Owner --->
        :: <a href="Report_ChangeOwner.cfm?ID=#ID#">Change Owner</a> (Program/Process/etc Owner)<br />
        :: <a href="Report_ChangeFYI.cfm?ID=#ID#">Change CC / FYI</a><br />	
        :: <a href="Report_ViewHistory.cfm?ID=#ID#">View</a> Comment History<br />
        :: <a href="Report_EmailOwner.cfm?ID=#ID#">Email</a> Owner<br />
        <cfif NOT len(Status)>
        :: <a href="Report_Delete.cfm?ID=#ID#">Delete</a> Report<br />
        <cfelseif Status eq "Removed">
        :: <span class="warning"><b>Report Deleted</b></span> <a href="Report_Reinstate.cfm?ID=#ID#">Reinstate</a> Report<br />
        </cfif>
        <br />
	<cfelseif isDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.IsLoggedIn eq "No"> 
		<cfif SESSION.Auth.AccessLevel eq "UserReportManage" AND SESSION.Auth.EmpNo eq "#ReportType#">
			<!--- Show available user report manage actions - add/edit --->
            <u>Report Owner <b>#ReportType#</b> - Available Actions</u><br />
            :: <a href="Report_ViewHistory.cfm?ID=#ID#">View</a> Comment History<br />
            :: <a href="Report_Details_Notes.cfm?Type=GeneralComments&ID=#ID#&Action=Add">Add New</a> General Comments<br />
            <!--- check for existing notes - edit current note --->
            <cfif isDefined("Comments") AND len(Comments)>
                :: <a href="Report_Details_Notes.cfm?Type=GeneralComments&ID=#ID#&Action=Edit">Edit Current</a> General Comments
                <br />
            </cfif>
			<cfif NOT len(Status)>
            :: <a href="Report_Delete.cfm?ID=#ID#">Delete</a> Report<br />
            <cfelseif Status eq "Removed">
            :: <span class="warning"><b>Report Deleted</b></span> <a href="Report_Reinstate.cfm?ID=#ID#">Reinstate</a> Report<br />
            </cfif>
            
			<!--- Show Comments (if any) --->
            <cfif isDefined("Comments") AND len(Comments)>
            <b>Report Owner <b>#ReportType#</b> - General Comments</b><br />
            #Comments#
            </cfif><br /><br />
        </cfif>
	</cfif>
<!--- If not logged in, show comments (if any) --->
<cfelse>
	<!--- Show Comments (if any) --->
	<cfif isDefined("Comments") AND len(Comments)>
    <b><cfif ReportType eq "QE">Quality Analysis - <cfelse>Report Owner <b>#ReporType#</b> </cfif>General Comments</b><br />
    #Comments#
    </cfif><br /><br />
</cfif>
</cflock>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->