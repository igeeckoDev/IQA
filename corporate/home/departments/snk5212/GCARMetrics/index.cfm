<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset SubTitle = "Start Search">

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

<!--- url variable - Geography --->

<!--- set values for url variables for page
and subTitle / subTitle2 for StartOfPage.cfm --->
<cfinclude template="shared/incVariables.cfm">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("URL.Manager")>
	<cfquery name="qCount" datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT Count(CARNumber) as Count
	FROM GCAR_Metrics
	WHERE
	<cfinclude template="shared/incProgramQuery.cfm">
	<cfinclude template="shared/incManagerAndViewQuery1.cfm">
	</cfquery>

	<cfoutput>
	
	<!---
	<b>Search Criteria</b>: <span class="warning"><b>GCAR Metrics Data last updated on #Request.DataDate#</b><br /><br />
	--->
	
	<b>Note - The datamart report used on this site is no longer available, and the replacement (datahub) is under development currently.<br><br>
	
	Until the replacement is deployed, the GCAR Metrics website will not be updated.</b><br><br>
	
	Please use the following Excel file to obtain CAR Metrics.<br><br>
	
	You can download the file and use the existing pivot table (or create your own) to manipulate the data.<br><br>
	
	This file is updated <u>once a week</u>, the date of the last update is listed on the linked page below<br>
	<a href="https://ul.sharepoint.com/sites/quality/539/Shared%20Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FStaff%20Directories%2FGCAR%20Metrics%20Excel%20File&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">GCAR Metrics</a></span>

	<!---
	<u>Current Data Set</u> -
	<cfif URL.View eq "All">
		<b>All #Type#</b> [#qCount.Count# CARs found]<br>
	<u>CAR Status</u>:
		<b>All</b>
		[<a href="#CGI.Script_Name#?View=Open&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">Open</a>]
		[<a href="#CGI.Script_Name#?View=Closed&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">Closed</a>]
	<cfelseif URL.View eq "Open">
		<b>Open #Type#</b> [#qCount.Count# CARs found]<br>
	<u>CAR Status</u>:
		[<a href="#CGI.Script_Name#?View=All&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">All</a>]
		<b>Open</b>
		[<a href="#CGI.Script_Name#?View=Closed&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">Closed</a>]
	<cfelseif URL.View eq "Closed">
		<b>Closed #Type#</b> [#qCount.Count# CARs found]<br>
	<u>CAR Status</u>:
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

    <!---
	<u>Geography</b>:
	to be added
	--->

	<cfif url.Manager neq "None">
		<u>Manager Name</u>: #url.Manager# [<a href="#CGI.Script_Name#?View=#URL.View#&Manager=None&Program=#url.Program#&Type=#url.Type#">Remove</a>]
	</cfif>

	<cfif url.Program neq "Null">
		<br>
		<u>Program Name</u>: #replace(url.Program, "|", ", ", "All")# [<a href="#CGI.Script_Name#?View=#URL.View#&Manager=#url.Manager#&Program=Null&Type=#url.Type#">Remove</a>]
	</cfif>

	<cfif url.Manager neq "None" OR url.Program neq "Null">
	<br>
	</cfif>

	<cfif url.View eq "All">
	<br /> * All #Type# (Does not include CARs that have not yet been assigned to a CAR Owner (New and Submitted CARs), or Force Closed CARs)<br />
	<cfelseif url.View eq "Open">
	<br /> * Open #Type# (Does not include CARs that have not yet been assigned to a CAR Owner (New and Submitted CARs), or CARs that have been Closed)<br />
    <cfelseif url.View eq "Closed">
    <br /> * Closed #Type# (Does not include Force Closed CARs)<br />
	</cfif>

	<cfset baseQueryString = "View=#url.View#&Manager=#url.Manager#&Program=#url.Program#&Type=#url.Type#">

	<!--- for NON IE browsers --->
    <!--[if !(IE)]><!--><br><br><hr width="50%" align="center"><br><!--><![endif]-->

	<!--- for IE browser --->
	<!--[if (IE)]><hr class='dash'><![endif]-->


	<b>Select Sort Criteria</b><Br><Br>
	<u>Location</u><br>
	<a href="qManager.cfm?#baseQueryString#&var=CARAuditedRegion&showPerf=No">Audited Region</a><Br>
	<a href="qManager.cfm?#baseQueryString#&var=CARSubType&showPerf=No">Organization / Function</a><Br>
	<a href="qManager.cfm?#baseQueryString#&var=CARSiteAudited&showPerf=No">Site Audited</a><Br>
	<br>

	<u>Quality Related</u><br>
	<a href="qManager.cfm?#baseQueryString#&var=CARTypeNew&showPerf=No">Process Impacted</a><Br>
	<a href="qManager.cfm?#baseQueryString#&var=CARRootCauseCategory&showPerf=No">Root Cause Category</a><Br>
	<a href="qManager.cfm?#baseQueryString#&var=CARType&showPerf=No">Standard Category</a><Br><br>

	<u>Program</u><br>
	<a href="qPrograms.cfm?#baseQueryString#&showPerf=No">Program Affected</a><Br><br>

	<u>Owner / Owner's Managers</u><br>
	<a href="selManager.cfm?#baseQueryString#">Owner / Manager</a><Br><br>

	<u>Other</u><br>
	<a href="qManager.cfm?#baseQueryString#&var=CARSource&showPerf=No">CAR Source</a><Br>
	<a href="qManager.cfm?#baseQueryString#&var=CARState&showPerf=No">CAR State</a><Br>
    <!---
	<a href="qManager.cfm?#baseQueryString#&var=CARStandardNumber&showPerf=No">Standard Number</a><Br>
	--->
	<br>

    <u>Custom Groupings</u><br />
    <a href="qGroup_Select.cfm">View Custom Groupings</a><br /><br />

	<!---
	 * <u>Note</u> - Owner's Manager uses the following fields from the CAR Database to sort CARs:
	<ul>
		<li>Owner's Manager</li>
		<li>Owner's 2nd Level Manager</li>
		<li>Owner's 3rd Level Manager</li>
		<li>Owner's 4th Level Manager</li>
		<li>Department Quality Manager</li>
	</ul>
	<br>

	<font color="red">CAR Performance Data</font> can be added once sort criteria is selected below. CAR Performance Data shows CAR Escalation and Overdue data in both Response and Implementation States.<br><br>
	--->
	--->
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->