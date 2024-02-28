<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset SubTitle = "CAR Trend Reports - <a href=Report_Owners.cfm>Functional Group Owners</a> - Email Owner(s)">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif url.ID NEQ "All">
    <cfquery name="checkEmail" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Owner, Function, FunctionField, SortField
    FROM GCAR_Metrics_QReports
    WHERE ID = #URL.ID#
    </cfquery>
    
    <cfoutput query="checkEmail">
    <cfinclude template="shared/incVariables_Report.cfm">
    	<cfif len(Owner)>
			<cflocation url="Report_EmailOwner_Send.cfm?ID=#URL.ID#" addtoken="no">
        <cfelse>
        :: #Function# by #sortFieldName#<br><br>
        No Owner is listed. Please <a href="Report_ChangeOwner.cfm?ID=#URL.ID#">add the Owner</a>.
        </cfif>
    </cfoutput>
<cfelseif url.ID EQ "All">
    <cfquery name="checkEmail" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Owner, Function, FunctionField, SortField, ID
    FROM GCAR_Metrics_QReports
    WHERE Owner IS NULL
    AND ReportType = 'QE'
    </cfquery>
    
	<cfif checkEmail.recordCount gt 0>
    The following reports do not have an Owner listed.<br>
	Please add Owners in order to use the 'Send Email to All Owners' function.<br><Br>
	
    	<cfoutput query="checkEmail">
			<cfinclude template="shared/incVariables_Report.cfm">
			:: #Function# by #sortFieldName# [<a href="Report_ChangeOwner.cfm?ID=#ID#">Add Owner</a>]<br>
        </cfoutput><Br>
    <cfelse>
        <cfquery name="AllOwners" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT Owner, Function, FunctionField, SortField 
        FROM GCAR_Metrics_QReports
        WHERE ReportType = 'QE'
        ORDER BY Function
        </cfquery>
    
    <cflocation url="Report_EmailOwner_Send.cfm?ID=#URL.ID#" addtoken="no">
    </cfif>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->