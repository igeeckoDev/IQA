<!--- set url variable - manager --->
<cfif NOT isDefined("url.Manager")>
	<cfset url.Manager = "None">
</cfif>

<!--- set url variable - view --->
<cfif NOT isDefined("url.View")>
	<cfset url.View = "All">
</cfif>

<!--- set url variable - program --->
<cfif NOT isDefined("url.Program")>
	<cfset url.Program = "null">
</cfif>

<!--- set url variable - Type --->
<cfif NOT isDefined("url.Type")>
	<cfset url.Type = "All">
</cfif>

<!--- set values for url variables for page 
and subTitle / subTitle2 for StartOfPage.cfm --->
<cfinclude template="shared/incVariables.cfm">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="qCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count
FROM GCAR_Metrics
WHERE
<cfinclude template="shared/incProgramQuery.cfm">
<cfinclude template="shared/incManagerAndViewQuery1.cfm">
</cfquery>

<cfoutput>
	<b>Search Criteria</b>: <span class="warning"><b>GCAR Metrics Data last updated on #Request.DataDate#</b><br /><br />

	<!--- Note - datamart is no longer available, and the replacement (datahub) is under development currently. Until the replacement is finished, GCAR Metrics will not be updated.</b>---></span>
	
	<u>Data Set</u> -
	<cfif URL.View eq "All">
		<b>All #Type#</b> [#qCount.Count# CARs found]<Br>
		* All CARs (Does not include New or Submitted #Type#)<br><br>
	<u>CAR Status</u>: 
		<b>All</b> 
		[<a href="#CGI.Script_Name#?View=Open&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">Open</a>] 
		[<a href="#CGI.Script_Name#?View=Closed&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">Closed</a>]
	<cfelseif URL.View eq "Open">
		<b>Open #Type#</b> [#qCount.Count# CARs found]<br>
		* Open #Type# (Does not include New, Submitted, or Closed #Type#)<br><br>
	<u>View</u>: 
		[<a href="#CGI.Script_Name#?View=All&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">All</a>] 
		<b>Open</b>
		[<a href="#CGI.Script_Name#?View=Closed&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">Closed</a>]
	<cfelseif URL.View eq "Closed">
		<b>Closed #Type#</b> [#qCount.Count# CARs found]<br>
	<u>View</u>:
		[<a href="#CGI.Script_Name#?View=All&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">All</a>] 
		[<a href="#CGI.Script_Name#?View=Open&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">Open</a>]
		<b>Closed</b>
	</cfif><br>
	
	<u>Classification</u>: 
	<cfif url.Type eq "All">
	<b>All</b> 
	[<a href="#CGI.Script_Name#?View=#url.View#&Manager=#url.Manager#&Program=#url.Program#&Type=Finding">Findings</a>] 
	[<a href="#CGI.Script_Name#?View=#url.View#&Manager=#url.Manager#&Program=#url.Program#&Type=Observation">Observations</a>]
	<cfelseif url.Type eq "Finding">
	[<a href="#CGI.Script_Name#?View=#url.View#&Manager=#url.Manager#&Program=#url.Program#&Type=All">All</a>] 
	<b>Findings</b>
	[<a href="#CGI.Script_Name#?View=#url.View#&Manager=#url.Manager#&Program=#url.Program#&Type=Observation">Observations</a>]
	<cfelseif url.Type eq "Observation">
	[<a href="#CGI.Script_Name#?View=#url.View#&Manager=#url.Manager#&Program=#url.Program#&Type=All">All</a>] 
	[<a href="#CGI.Script_Name#?View=#url.View#&Manager=#url.Manager#&Program=#url.Program#&Type=Finding">Findings</a>] 
	<b>Observations</b>
	</cfif><br>

	<cfif url.Program neq "Null">
		<br>
		<u>Program Name</u>: #url.Program# [<a href="#CGI.Script_Name#?View=#URL.View#&Manager=#url.Manager#&Program=Null">Remove</a>]<br>
	</cfif>
</cfoutput>
<br>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CAROwnersManager as Managers
FROM GCAR_Metrics
<cfinclude template="shared/incUrlView.cfm">
ORDER BY CAROwnersManager
</cfquery>

<cfset qM1 = ValueList(qManagers.Managers)>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CAROwners2ndLevelManager as Managers
FROM GCAR_Metrics
<cfinclude template="shared/incUrlView.cfm">
ORDER BY CAROwners2ndLevelManager
</cfquery>

<cfset qM2 = ValueList(qManagers.Managers)>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CAROwners3rdLevelManager as Managers
FROM GCAR_Metrics
<cfinclude template="shared/incUrlView.cfm">
ORDER BY CAROwners3rdLevelManager
</cfquery>

<cfset qM3 = ValueList(qManagers.Managers)>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CAROwners4thLevelManager as Managers
FROM GCAR_Metrics
<cfinclude template="shared/incUrlView.cfm">
ORDER BY CAROwners4thLevelManager
</cfquery>

<cfset qM4 = ValueList(qManagers.Managers)>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARDeptQualityManager as Managers
FROM GCAR_Metrics
<cfinclude template="shared/incUrlView.cfm">
ORDER BY CARDeptQualityManager
</cfquery>

<cfset qM5 = ValueList(qManagers.Managers)>

<cfquery name="qManagers" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CAROwner as Managers
FROM GCAR_Metrics
<cfinclude template="shared/incUrlView.cfm">
ORDER BY CAROwner
</cfquery>

<cfset qM6 = ValueList(qManagers.Managers)>

<!--- concatenate with cfsavecontent --->
<cfsavecontent variable="cfstring">
	<cfoutput>
		<cfloop from="1" to="6" index="i">
			#Evaluate("qM#i#")#,
		</cfloop>
	</cfoutput>
</cfsavecontent>

<!--- all strings concatenated 
<cfoutput>#cfstring#</cfoutput>
--->

<!--- Convert list to 1 column query var --->
<cfset query = queryNew("val") />
<cfloop list="#cfString#" index="i" delimiters=",">
<cfset queryAddRow(query) />
<cfset querySetCell(query, "val", i) />
</cfloop>

<!--- Remove duplicates and sort results using query of query and "group by" --->
<cfquery name="sortedQuery" dbtype="query">
SELECT val
FROM query
GROUP BY val
ORDER BY val asc
</cfquery>

<!--- Output table of distinct Managers 
<Table border="1">
<cfoutput query="sortedquery">
<tr>
<td>#val#</td>
</tr>
</cfoutput>
</table>
--->

<span class="blog-content">
<b>View CARs by Owner / Owner's Manager</b><br>
CARs by Manager displays all CARs where the manager (or owner) is listed in the Escalation Path of the CAR. That is, in one or more of the fields listed below. Once a Manager is selected, you can filter this data by all other search criteria. CAR Owners are now included in this search.<br><br>

	<ul class="arrow2">
    	<li class="arrow2">Owner</li>
      	<li class="arrow2">Owner's Manager</li>
		<li class="arrow2">Owner's 2nd Level Manager</li>
		<li class="arrow2">Owner's 3rd Level Manager</li>
		<li class="arrow2">Owner's 4th Level Manager</li>
		<li class="arrow2">Department Quality Manager</li>
	</ul><Br>

<b>Search for Name</b><br>
In order to find an Owner/Manager name, start typing Manager's <span class="warning">first name</span>.

<div style="position:relative; z-index:3">
<cfform name="InputTypeTextAutosuggestTest" method="post" action="vManagerSelect.cfm?View=#url.View#&Program=#url.Program#&Type=#url.Type#">
<cfinput 
	name="Name" 
	type="text" 
	autosuggest="#ValueList(sortedQuery.val)#">
<br /><br>

<cfinput 
	name="SubmitName" 
	type="submit" 
	value="Submit">
</cfform>
</div>

</span>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->