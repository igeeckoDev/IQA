<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Output Data to Excel">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<!--- Assign appropriate lables/names based on url variables --->
<cfinclude template="shared/incVariableTitles.cfm">

<b>Search Criteria</b>:<br>
<u>CAR Status</u> - 
<cfif URL.View eq "All">
	<b>All</b> (Does not include New or Submitted CARs)
<cfelseif URL.View eq "Open">
	<b>Open</b> (Does not include New, Submitted, or Closed CARs)
<cfelseif URL.View eq "Closed">
	<b>Closed</b>
</cfif><br>

<u>Classification</u> - 
<cfif url.Type eq "All">
	<b>All</b> 
<cfelseif url.Type eq "Finding">
	<b>Findings</b>
<cfelseif url.Type eq "Observation"> 
	<b>Observations</b>
</cfif><br>

<cfif url.Manager neq "None">
	<u>Manager Name</u> - #url.Manager#<br>
</cfif>

<cfif isDefined("URL.Program") AND url.Program NEQ "Null">
	<cfset newVal = #replace(url.Program, "|", ", ", "All")#>
	<u>Program Name</u> - #newVal#<br>
</cfif>

<cfif IsDefined("url.var")>
	<u>#Search#</u>
	<cfif isDefined("url.varValue")>
	 - #url.varValue#
	<cfelse>
	 by Year
	</cfif><br>
</cfif>

<cfloop index="i" from="1" to="7">
	<cfif IsDefined("url.var#i#")>
		<u>#Evaluate("Search#i#")#</u>
		<cfif isDefined("url.var#i#Value")>
		 - #Evaluate("url.var#i#Value")#
		<cfelse>
		 by Year
		</cfif><br>
	</cfif>
</cfloop><br>
</cfoutput>

<cfquery name="qRecordCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
Select Count(docID) as CARCount	
FROM GCAR_Metrics
WHERE 
<cfinclude template="shared/incProgramQuery.cfm">
	<cfif url.refPage eq "/departments/snk5212/GCARMetrics/qManager.cfm">
		<cfif NOT isDefined("URL.FullTable")>
        #url.var# = '#url.varValue#'
        <cfelse>
        1=1
        </cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail.cfm">
	#url.var# = '#url.varValue#'
		<cfif NOT isDefined("URL.FullTable")>
        AND #url.var1# = '#url.var1Value#'
        </cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail2.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
    	<cfif NOT isDefined("URL.FullTable")>
		AND #url.var2# = '#url.var2Value#'
		</cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail3.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
		<cfif NOT isDefined("URL.FullTable")>
    	AND #url.var3# = '#url.var3Value#'
		</cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail4.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
    	<cfif NOT isDefined("URL.FullTable")>
		AND #url.var4# = '#url.var4Value#'
		</cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail5.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	AND #url.var4# = '#url.var4Value#'
		<cfif NOT isDefined("URL.FullTable")>
    	AND #url.var5# = '#url.var5Value#'
        </cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail6.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	AND #url.var4# = '#url.var4Value#'
	AND #url.var5# = '#url.var5Value#'
    	<cfif NOT isDefined("URL.FullTable")>
		AND #url.var6# = '#url.var6Value#'
		</cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail7.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	AND #url.var4# = '#url.var4Value#'
	AND #url.var5# = '#url.var5Value#'
	AND #url.var6# = '#url.var6Value#'
	    <cfif NOT isDefined("URL.FullTable")>
		AND #url.var7# = '#url.var7Value#'
		</cfif>
	</cfif>
<cfinclude template="shared/incManagerAndViewQuery.cfm">
</cfquery>

<cfif qRecordCount.CARCount lt 2000>

<cfquery name="qData" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
Select 
	docID, 
	CARNumber, 
	CARState, 
	CARsource, 
	CARAdministrator, 
	CAROwner, 
	CARFindOrObservation, 
	CARProgramAffected, 
	CARSiteAudited, 
	CARAuditedRegion, 
	CARRootCauseCategory, 
	CARSubType, 
	CARType, 
	CARTypeNew, 
	CARYear, 
	CARDeptQualityManager, 
	CAROwnersManager, 
	CAROwners2ndLevelManager, 
	CAROwners3rdLevelManager, 
	CAROwners4thLevelManager, 
	CARRegionalQualityManager,
	CAROpenDate,
	CARCloseDate,
	CAROriginator,
	CARHistory, 
	CARStandardNumber,
	CARClause,
	RE1,
	RE2,
	RE3,
	RE4,
	REM,
	MaxResponse,
	IE1,
	IE2,
	IE3,
	IE4,
	IEM,
	MaxImplement,
	ION,
	RON
	
FROM GCAR_Metrics
WHERE 
<cfinclude template="shared/incProgramQuery.cfm">
	<cfif url.refPage eq "/departments/snk5212/GCARMetrics/qManager.cfm">
		<cfif NOT isDefined("URL.FullTable")>
        #url.var# = '#url.varValue#'
        <cfelse>
        1=1
        </cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail.cfm">
	#url.var# = '#url.varValue#'
		<cfif NOT isDefined("URL.FullTable")>
        AND #url.var1# = '#url.var1Value#'
        </cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail2.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
    	<cfif NOT isDefined("URL.FullTable")>
		AND #url.var2# = '#url.var2Value#'
		</cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail3.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
		<cfif NOT isDefined("URL.FullTable")>
    	AND #url.var3# = '#url.var3Value#'
		</cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail4.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
    	<cfif NOT isDefined("URL.FullTable")>
		AND #url.var4# = '#url.var4Value#'
		</cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail5.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	AND #url.var4# = '#url.var4Value#'
		<cfif NOT isDefined("URL.FullTable")>
    	AND #url.var5# = '#url.var5Value#'
        </cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail6.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	AND #url.var4# = '#url.var4Value#'
	AND #url.var5# = '#url.var5Value#'
    	<cfif NOT isDefined("URL.FullTable")>
		AND #url.var6# = '#url.var6Value#'
		</cfif>
	<cfelseif url.refPage eq "/departments/snk5212/GCARMetrics/qManager_Detail7.cfm">
	#url.var# = '#url.varValue#'
	AND #url.var1# = '#url.var1Value#'
	AND #url.var2# = '#url.var2Value#'
	AND #url.var3# = '#url.var3Value#'
	AND #url.var4# = '#url.var4Value#'
	AND #url.var5# = '#url.var5Value#'
	AND #url.var6# = '#url.var6Value#'
	    <cfif NOT isDefined("URL.FullTable")>
		AND #url.var7# = '#url.var7Value#'
		</cfif>
	</cfif>
<cfinclude template="shared/incManagerAndViewQuery.cfm">

ORDER BY CARNumber
</cfquery>

<cfoutput>
<!--- Create the file name --->
<cfset fileName = "GCAROutput_#dateformat(now(), "yyyyMMMdd")#_#timeformat(now(), "hhmmsstt")#">
<cfset fileLocation = "d:\webserver\corporate\home\departments\snk5212\GCARMetrics\xls\">
<cfset theFile = "#fileLocation##fileName#.xls">
</cfoutput>

<!--- Open the File --->
<cfset fileOb = fileOpen(theFile, "append")>

<!--- Header Row --->
<cfset fileHeaderData = "<cfcontent type='application/vnd.ms-excel'>
<table border='1'>
<tr align='center' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'> 
<td><b>Link to CAR</b></td>
<td><b>CAR Number</b></td>
<td><b>CAR State</b></td>
<td><b>CAR Source</b></td>
<td><b>CAR Admin</b></td>
<td><b>CAR Owner</b></td>
<td><b>CAR Classification</b></td>
<td><b>Program Affected</b></td>
<td><b>Site Audited</b></td>
<td><b>Audited Region</b></td>
<td><b>Root Cause Category</b></td>
<td><b>Owner's Organization / Function</b></td>
<td><b>Standard Category</b></td>
<td><b>Process Impacted</b></td>
<td><b>CAR Year</b></td>
<td><b>Department Quality Manager</b></td>
<td><b>Owner's Manager</b></td>
<td><b>Owner's 2nd Level Manager</b></td>
<td><b>Owner's 3rd Level Manager</b></td>
<td><b>Owner's 4th Level Manager</b></td>
<td><b>Regional Quality Manager</b></td>
<td><b>CAR Open Date</b></td>
<td><b>CAR Close Date</b></td>
<td><b>CAR Originator</b></td>
<td><b>CAR Standard Number</b></td>
<td><b>CAR Clause</b></td>
<td><b>CAR History</b></td>
<td><b>Number of times in State:<br>Response Escalation 1</b></td>
<td><b>Number of times in State:<br>Response Escalation 2</b></td>
<td><b>Number of times in State:<br>Response Escalation 3</b></td>
<td><b>Number of times in State:<br>Response Escalation 4</b></td>
<td><b>Number of times in State:<br>Response Manual Escalation</b></td>
<td><b>Highest Response<br>Escalation State</b></td>
<td><b>Number of times in State:<br>Implementation Escalation 1</b></td>
<td><b>Number of times in State:<br>Implementation Escalation 2</b></td>
<td><b>Number of times in State:<br>Implementation Escalation 3</b></td>
<td><b>Number of times in State:<br>Implementation Escalation 4</b></td>
<td><b>Number of times in State:<br>Implementation Manual Escalation</b></td>
<td><b>Highest Implementation<br>Escalation State</b></td>
<td><b>Number of Overdue Notifications:<br>Response</b></b></td>
<td><b>Number of Overdue Notifications:<br>Implementation</b></b></td>
</tr>">

<!--- Write to the file --->
<cfset fileWriteLine(fileOb, fileHeaderData)>

<!--- append the dynamic data to the file ---> 
<cfloop query="qData">
	<cfset formatCARAdmin = replace(CARAdministrator, '|CN=', ',CN=', 'All')>
	<cfset formatCARAdmin2 = replace(formatCARAdmin, 'CN=', '', 'All')>

<cfset fileData = "<tr valign='top' align='left' style='font-family:Arial, Helvetica, sans-serif; font-size:12px'>
<td><a href='#Request.GCARLink##docID#'>View CAR</a></td>
<td style='vnd.ms-excel.numberformat:00000000'>#CARNumber#</td>
<td>#CARState#</td>
<td>#CARSource#</td>
<td nowrap>#formatCARAdmin2#</td>
<td>#CAROwner#</td>
<td>#CARFindOrObservation#</td>
<td nowrap>#CARProgramAffected#</td>
<td>#CARSiteAudited#</td>
<td>#CARAuditedRegion#</td>
<td nowrap>#CARRootCauseCategory#</td>
<td nowrap>#CARSubType#</td>
<td nowrap>#CARType#</td>
<td nowrap>#CARTypeNew#</td>
<td style='vnd.ms-excel.numberformat:0000'>#CARYear#</td>
<td>#CARDeptQualityManager#</td>
<td>#CAROwnersManager#</td>
<td>#CAROwners2ndLevelManager#</td>
<td>#CAROwners3rdLevelManager#</td>
<td>#CAROwners4thLevelManager#</td>
<td>#CARRegionalQualityManager#</td>
<td>#dateformat(CAROpenDate, 'mm/dd/yyyy')#</td>
<td>#dateformat(CARCloseDate, 'mm/dd/yyyy')#</td>
<td>#CAROriginator#</td>
<td nowrap>#CARStandardNumber#</td>
<td nowrap>#CARClause#</td>
<td nowrap>#CARHistory#</td>
<td>#RE1#</td>
<td>#RE2#</td>
<td>#RE3#</td>
<td>#RE4#</td>
<td>#REM#</td>
<td>#MaxResponse#</td>
<td>#IE1#</td>
<td>#IE2#</td>
<td>#IE3#</td>
<td>#IE4#</td>
<td>#IEM#</td>
<td>#MaxImplement#</td>
<td>#RON#</td>
<td>#ION#</td>
</tr> ">

<!--- Write to File --->
<cfset fileWriteLine(fileOb, fileData)>
</cfloop>

<!--- Close File --->
<cfset fileClose(fileOb)>

<!--- show page content --->
<cfoutput>
#filename#.xls has been generated<br>
<a href="xls\#filename#.xls" target="_blank"><img src="#SiteDir#SiteImages/table_row.png" align="absmiddle" border="0"> View File</a><br><br>

CARs included in file: <B>#qRecordCount.CARCount#</B><br /><br />

NOTE: It may take 5-10 seconds to open the file in Excel.<br><br>

<u>Instructions to Save File</u><br>
1. Please save the excel spreadsheet in order to manipulate the data in any way.<br>
2. Select File->Save As-><br>
3. Type in a name for the file.<br>
4. Select 'Microsoft Excel Workbook' from 'Save as Type' drop down box.<br>
</cfoutput>

<cfelse>
<cfoutput>
CARs selected for output to Excel: #qRecordCount.CARCount#<br /><br />

Data output to Excel is restricted to a maximum of 2000 CARs. Please refine your search on the previous page.<br /><br />
</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->