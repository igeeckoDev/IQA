<cfquery name="Function" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Function, FunctionField
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "CAR Trend Reports - <a href='Report_Details.cfm?Function=#Function.Function#&FunctionField=#Function.FunctionField#'>#Function.Function#</a> - Add Comments">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<script 
	language="javascript" 
	type="text/javascript" 
	src="#CARDir#tinymce/jscripts/tiny_mce/tiny_mce.js">
</script>

<script language="javascript" type="text/javascript">
tinyMCE.init({
	mode : "textareas",
	content_css : "#SiteDir#SiteShared/cr_style.css"
});
</script>
</cfoutput>

<cfquery name="ReportDetails" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, ReportType, Function, FunctionField, SortField, PostedDate, History, Owner, #url.Type# as Comments
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<cfoutput query="ReportDetails">
	<cfinclude template="shared/incVariables_Report.cfm">
	<b>#Function# (#FunctionFieldName#)</b><br />
	<cfif ReportType eq "QE">
    	<u>Owner</u>: <cfif len(Owner)>#Owner#<cfelse>None Listed</cfif>
    <cfelse>
    	<u>Owner</u>: #ReportType#
    </cfif><br /><br />
</cfoutput>

<cfif url.type eq "GeneralComments">
	<cfset CommentsName = "General Comments">
<cfelseif url.type eq "CARSourceComments">
	<cfset CommentsName = "CAR Source Comments">
<cfelseif url.type eq "CARStateComments">
	<cfset CommentsName = "CAR State Comments">
<cfelseif url.type eq "TopIssuesComments">
	<cfset CommentsName = "Top Issues Comments">
<cfelseif url.type eq "IneffectiveComments">
	<cfset CommentsName = "Ineffective CARs Comments">
<cfelseif url.type eq "ComplaintsComments">
	<cfset CommentsName = "Customer Complaints Comments">
<cfelseif url.type eq "CARRootCauseCategoryComments">
	<cfset CommentsName = "Root Cause Category Comments">
</cfif>

<cfif isDefined("Form.Submit")>

<cflock scope="session" timeout="6">
	<cfset historyLog = "[#dateformat(now(), "mm/dd/yyyy")# #timeformat(now(), 'hh:mm tt')#] #SESSION.AUTH.NAME# - <b>#url.Action#ed #CommentsName#</b>">
    <Cfset commentsLog = "<u>#CommentsName# #url.Action#ed</u>: #dateformat(now(), "mm/dd/yyyy")# #timeformat(now(), 'hh:mm tt')#<br><u>Author</u>: #SESSION.AUTH.NAME#">
</cflock>

<!--- add historyLog value we just created (PLACED ABOVE the comments) plus new comments from the form to the already existing history --->
<cfset newHistory = "#historyLog#<br>#Form.Comments#<br><br><hr><br><br>#ReportDetails.History#">

<!--- add commentsLog we just created (PLACED BELOW the comments) to the new comments from the form --->
<cfset newComments = "#Form.Comments#<br>#commentsLog#">

<cfquery name="AddToHistory" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE GCAR_METRICS_QREPORTS
SET
History = <CFQUERYPARAM VALUE="#newHistory#" CFSQLTYPE="CF_SQL_CLOB">
WHERE ID = #URL.ID#
</cfquery>

<cfquery name="AddToComments" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE GCAR_METRICS_QREPORTS
SET
#url.type# = <CFQUERYPARAM VALUE="#newComments#" CFSQLTYPE="CF_SQL_CLOB">
WHERE ID = #URL.ID#
</cfquery>

<cfquery name="InputCheck" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History, #url.Type# as Comments
FROM GCAR_METRICS_QREPORTS
WHERE ID = #URL.ID#
</cfquery>

<cflocation url="#form.refer#" addtoken="no">

<cfelse>

<!--- Show Comments --->
<cfoutput query="ReportDetails">
<b><cfif ReportType eq "QE">Quality Analysis - </cfif>Current #CommentsName#</b><br />
	<cfif isDefined("Comments") AND len(Comments)>
    	#Comments#
    <cfelse>
	    None Listed
    </cfif>
<br /><br />

<b>#url.Action# #CommentsName#</b>:<br />

<cfform action="#cgi.script_name#?#cgi.query_string#" name="form" method="post">
<cftextarea WRAP="PHYSICAL" 
    ROWS="10" 
    COLS="60" 
    NAME="Comments">
   	<cfif url.Action eq "Edit">
	    #ReportDetails.Comments#
	</cfif>
</cftextarea><br />

<cfset goToPage = replace(cgi.HTTP_REFERER, "#request.serverProtocol##request.serverDomain#/departments/snk5212/GCARMetrics/", "")>
<cfinput type="hidden" name="refer" value="#goToPage#" />

<cfinput type="Submit" name="Submit" value="Add #CommentsName#">
</cfform>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->