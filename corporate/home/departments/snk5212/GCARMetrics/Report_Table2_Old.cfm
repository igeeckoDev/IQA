<!--- subtitle for StartOfPage--->
<cfset subTitle = "CAR Trend Reports - View <a href='Report_Details.cfm?ID=#URL.ID#'>#url.varValue#</a> Report - Customer Complaint CARs">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- Assign appropriate lables/names based on url variables --->
<cfinclude template="shared/incVariableTitles.cfm">

<!--- get group Items when url.group = Yes --->
<cfif isDefined("URL.Group") AND url.Group eq "Yes">
<cfset z = 1>
    <cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT groupName, groupType, ItemName
    FROM GCAR_Metrics_Function_Grouping
    WHERE groupName = '#url.varvalue#'
    AND groupType = '#url.var#'
    ORDER BY itemName
    </cfquery>
    
	<cfset qCARCount.TotalCARs = 0>

	<cfoutput query="getItems">
        <cfquery name="getCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT Count(*) as CountItem
        FROM GCAR_Metrics
        WHERE 
        <cfinclude template="shared/incProgramQuery.cfm">
        #url.var# = '#ItemName#'
        AND #url.var1# = '#url.var1Value#'
        <cfinclude template="shared/incManagerAndViewQuery.cfm">
        </cfquery>
    
        <cfset qCARCount.TotalCARs = getCount.CountItem + qCARCount.TotalCARs>
    </cfoutput>
    
    <!--- Get list of distinct values in order to loop through and count --->
    <cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT DISTINCT #url.var2# as d#url.var2#
    FROM GCAR_Metrics
    WHERE 
    <cfinclude template="shared/incProgramQuery.cfm">
    (<cfloop query="getItems" endRow="#getItems.RecordCount#">
    	<cfif url.var eq "CARProgramAffected">
        	<cfif url.varValue eq "UL Mark">
	        	<!--- all iterations of UL Mark and ULI Mark in a string --->
                #url.varValue# LIKE '%UL Mark%'
                OR #url.varValue# LIKE '%ULI Mark%'
        	<cfelse>
            	#url.var# LIKE '#itemName#'
            </cfif>
		<cfelse>
	        #url.var# = '#itemName#'
    	</cfif>
        <!--- add OR for all but the last loop --->
        <cfif z LT getItems.recordcount>OR</cfif>
        <!--- +1 to counter --->
        <cfset z = z+1>
    </cfloop>)   
    AND #url.var1# = '#url.var1Value#'
    <cfinclude template="shared/incManagerAndViewQuery.cfm">
    GROUP BY #url.var2#
    ORDER BY #url.var2# ASC
    </cfquery>
<cfelse>
	<!--- url.var defines sort field --->
    <Cfset dValue = "d#url.var2#">
    
    <!--- Total Number of CARs found during the search --->
    <cfquery name="qCARCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Count(*) as TotalCARs
    FROM GCAR_Metrics
    WHERE 
    <cfinclude template="shared/incProgramQuery.cfm">
    #url.var# = '#url.varValue#' AND 
    #url.var1# = '#url.var1Value#'
    <cfinclude template="shared/incManagerAndViewQuery.cfm">
    </cfquery>
    
    <!--- Get list of distinct values in order to loop through and count --->
    <cfquery name="getItems" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT DISTINCT #url.var2# as d#url.var2#
    FROM GCAR_Metrics
    WHERE 
    <cfinclude template="shared/incProgramQuery.cfm">
    #url.var# = '#url.varValue#' AND
    #url.var1# = '#url.var1Value#'
    <cfinclude template="shared/incManagerAndViewQuery.cfm">
    GROUP BY #url.var2#
    ORDER BY #url.var2# ASC
    </cfquery>
</cfif>

<cfoutput>
	<cfinclude template="shared/incSearchCriteriaReport.cfm">
</cfoutput>

<cfinclude template="shared/incTableHeaderReport.cfm">

		<cfoutput query="getItems">
			<cfif isDefined("URL.Group") AND url.Group eq "Yes">
                <cfset itemVar = itemName>
            <cfelse>
                <cfset itemVar = Evaluate("#dValue#")>
            </cfif>
		<tr class="blog-content" align="center" valign="top">
			<td align="left">#itemVar#</td>
			<cfset qTotal = 0>
			<cfloop index="i" from="2008" to="2011">
				<cfquery name="qResult" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT Count(#url.var2#) as CARCount, CARYear, #url.var2#
				FROM GCAR_Metrics
				WHERE 
				<cfinclude template="shared/incProgramQuery.cfm">
				#url.var2# = '#itemVar#'
				AND #url.var# = '#itemVar#' 
				AND #url.var1# = '#url.var1Value#'
				AND CARYear = #i#
				<cfinclude template="shared/incManagerAndViewQuery.cfm">
				GROUP BY #url.var2#, CARYear
				</cfquery>
		
				<cfinclude template="shared/incDataTableYears.cfm">
			</cfloop>
				<cfinclude template="shared/incDataTableTotals.cfm">
			</tr>
		</cfoutput>
	</table>
    
<cfinclude template="shared/incSaveQueryReport.cfm">

<u>Help</u><br />
:: <a href="Overview_TrendReports.cfm">CAR Trend Reports Overview</a><br /><br />

<cfquery name="ShowComments" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, 
<cfif url.var1Value eq "Closed - Verified as Ineffective">
IneffectiveComments 
<cfelseif url.var1Value eq "Customer Complaint">
ComplaintsComments
</cfif>
as Comments
FROM GCAR_METRICS_QREPORTS
WHERE 
ID = #URL.ID#
<!--- Function = '#url.varValue#' --->
</cfquery>

<cfif url.var1Value eq "Closed - Verified as Ineffective">
	<cfset urlComments = "IneffectiveComments">
<cfelseif url.var1Value eq "Customer Complaint">
	<cfset urlComments = "ComplaintsComments">
</cfif>

<cfoutput query="ShowComments">
<cflock scope="Session" timeout="6">
<!--- Check to see if user is logged in --->
<cfif isDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.IsLoggedIn eq "Yes">
	<!--- Show Comments --->
    <b>Quality Analysis - Comments</b><br />
	<cfif isDefined("Comments") AND len(Comments)>
    #Comments#
    <cfelse>
    None Listed
    </cfif><br /><br />
    
    <!--- Show available admin actions - add/edit --->
	<u>Quality Analyst - Available Actions</u><br />
    <!--- Add new notes and store current notes in history --->
    :: <a href="Report_Details_Notes.cfm?Type=#urlComments#&ID=#ID#&Action=Add">Add New</a> Comments<br />
    <!--- check for existing notes - edit current note --->
    <cfif isDefined("Comments") AND len(Comments)>
    :: <a href="Report_Details_Notes.cfm?Type=#urlComments#&ID=#ID#&Action=Edit">Edit Current</a> Comments<br />
    </cfif>
    :: <a href="Report_ViewHistory.cfm?ID=#ID#">View</a> Comment History<br />
    :: <a href="Report_EmailOwner.cfm?ID=#ID#">Email</a> Owner<br />
<!--- If not logged in, show comments (if any) --->
<cfelse>
	<!--- Show Comments (if any) --->
	<cfif isDefined("Comments") AND len(Comments)>
    <b>Quality Analysis - Comments</b><br />
    #Comments#
    </cfif><br /><br />
</cfif>
</cflock>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->