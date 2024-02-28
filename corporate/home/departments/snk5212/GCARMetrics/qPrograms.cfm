<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Select Program Affected">

<!--- set values for url variables for page 
and subTitle / subTitle2 for StartOfPage.cfm --->
<cfinclude template="shared/incVariables.cfm">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- output every CARProgramAffected field from all CARs --->
<CFQUERY BLOCKFACTOR="100" NAME="programs" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARProgramAffected 
FROM GCAR_Metrics
WHERE
<cfinclude template="shared/incManagerAndViewQuery1.cfm">
ORDER BY CARProgramAffected
</cfquery>

<cfquery name="qCount" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(CARNumber) as Count
FROM GCAR_Metrics
WHERE
<cfinclude template="shared/incManagerAndViewQuery1.cfm">
</cfquery>

	<cfoutput>
	<b>Search Criteria</b>: <span class="warning"><b>GCAR Metrics Data last updated on #Request.DataDate#</b><br /><br />

	<!--- Note - datamart is no longer available, and the replacement (datahub) is under development currently. Until the replacement is finished, GCAR Metrics will not be updated.</b>---></span>
	
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
	<br> * All CARs (Does not include New or Submitted #Type#)<br>
	<cfelseif url.View eq "Open">
	<br> * Open #Type# (Does not include New, Submitted, or Closed #Type#)<br>
	</cfif>
</cfoutput>
<Br>

<!--- create a string/list of the results, the delimiter is !!  --->
<cfset xyz = #ValueList(programs.CARProgramAffected, '!!')#>
<!--- output original valuelist xyz
<cfdump var="#xyz#">
--->

<!--- each field above may have more than one program listed, when this is true, the delimiter is |
Some programs also have this value in place of a comma. We need to sub out these program names before we 
replace the | delimiter with !! Each prog name will get a separate replacement value so we can put them back in appropriately later on --->
<cfset xyz2 = #replace(xyz, "Nordic Certification Scheme (Denmark;Sweden;Norway;Finland)", "ABC", "All")#>
<cfset xyz2_2 = #replace(xyz2, "Nordic Certification Scheme (Denmark", "ABC_2", "All")#>
<cfset xyz3 = #replace(xyz2, "Radio and Telecommunications Certification Body Program (USA;Canada;Singapore)", "DEF", "All")#>
<cfset xyz4 = #replace(xyz3, "Ministry of Health;Labor and Welfare (MHLW) - PAL", "GHI", "All")#>
<cfset xyz5 = #replace(xyz4, "UL Verification Mark for Transmission Performance of Copper Telecommunications Cabling;Levels XP Structured Cabling and Proprietary Structured Cabling", "JKL", "All")#>
<cfset xyz6 = #replace(xyz5, "Vehicle Certification Agency (VCA);U.K", "MNO", "All")#>
<cfset xyz6_2 = #replace(xyz6, "UL-EU Mar", "PQR", "All")#>
<!--- replace all | delimiters in the entire string with !! --->
<cfset xyz7 = #replace(xyz6_2, ";", "!!", "All")#>
<!--- replace the substitution values with the program name, including commas this time --->
<cfset xyz8 = #replace(xyz7, "ABC", "Nordic Certification Scheme (Denmark, Sweden, Norway, Finland)", "All")#>
<cfset xyz8_2 = #replace(xyz8, "ABC_2", "Nordic Certification Scheme (Denmark, Sweden, Norway, Finland)", "All")#>
<cfset xyz9 = #replace(xyz8_2, "DEF", "Radio and Telecommunications Certification Body Program (USA, Canada, Singapore)", "All")#>
<cfset xyz10 = #replace(xyz9, "GHI", "Ministry of Health, Labor and Welfare (MHLW) - PAL", "All")#>
<cfset xyz11 = #replace(xyz10, "JKL", "UL Verification Mark for Transmission Performance of Copper Telecommunications Cabling, Levels XP Structured Cabling and Proprietary Structured Cabling", "All")#>
<cfset xyz12 = #replace(xyz11, "PQR", "UL-EU Mark", "All")#>
<cfset xyz13 = #replace(xyz12, "c-UL Mark", "Canada Safety Scheme", "All")#>
<cfset xyz14 = #replace(xyz13, "ULI Mark", "UL Mark", "All")#>
<cfset xyz15 = #replace(xyz14, "UL Mark", "U.S. Safety Scheme", "All")#>
<cfset finalString = #replace(xyz15, "MNO", "Vehicle Certification Agency (VCA), U.K", "All")#>

<!--- Convert list to 1 column query var --->
<cfset query = queryNew("val") />
<cfloop list="#finalString#" index="i" delimiters="!!">
<cfset queryAddRow(query) />
<cfset querySetCell(query, "val", i) />
</cfloop>

<!--- Remove duplicates and sort results using query of query and "group by" --->
<cfquery name="sortedQuery" dbtype="query">
SELECT val, count(*) as numOcurrences
FROM query
GROUP BY val
ORDER BY numOcurrences desc, val asc
</cfquery>

<!--- Table Output --->
<Table border="1">
	<tr align="center">
		<th>Program Affected</td>
		<cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
	        <cfoutput>
    	    	<th>#i#</th>
        	</cfoutput>
        </cfloop>
		<th>Total</td>
		<th>Search</td>
	</tr>

<cfoutput query="sortedquery">
<tr class="blog-content" valign="top">
	<!--- Program --->
	<cfset newVal = #replace(val, ", ", "|", "All")#>
	<td align="left">#val#</td>

	<!--- set variable qTotal to 0, we are going to verify the variable numOcurrences is accurate --->
	<cfset qTotal = 0>
	<!--- create a loop to cycle through minYear to maxyear to search for val/program name and output count --->
	<cfloop index="i" from="#Request.minYear#" to="#Request.maxYear#">
	<!--- query for val (specific program from list we created and filtered) in CARs for a given year --->
		<CFQUERY BLOCKFACTOR="100" NAME="qResult" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT Count(CARNumber) as CARCount 
		FROM GCAR_Metrics
		WHERE 
        <cfif newVal eq "UL Mark">
        CARProgramAffected NOT LIKE '%c-UL Mark%' 
        AND CARProgramAffected NOT LIKE '%UL Mark for%' 
        AND (CARProgramAffected LIKE '%ULI Mark%' OR CARProgramAffected LIKE '%UL Mark%') 
        <cfelse>
		CARProgramAffected LIKE '%#newVal#%'
		</cfif>
        AND CARYear = #i#
		<cfinclude template="shared/incManagerAndViewQuery.cfm">
		</cfquery>

		<!---
		<!--- combining UL Mark and ULI Mark counts --->
		<cfif newVal eq "UL Mark">
        	<!--- Count all ULI Mark instances --->
			<CFQUERY BLOCKFACTOR="100" NAME="ULI" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Count(CARNumber) as CARCount 
			FROM GCAR_Metrics
			WHERE CARProgramAffected LIKE '%ULI Mark%'
			AND CARYear = #i#
			<cfinclude template="shared/incManagerAndViewQuery.cfm">			
			</cfquery>
            
            <!--- Count all CARs where BOTH ULI Mark and UL Mark are found --->
			<CFQUERY BLOCKFACTOR="100" NAME="ULandULI" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT Count(CARNumber) as CARCount 
			FROM GCAR_Metrics
			WHERE (CARProgramAffected LIKE '%ULI Mark%' AND CARProgramAffected LIKE '%UL Mark%')
			AND CARYear = #i#
			<cfinclude template="shared/incManagerAndViewQuery.cfm">			
			</cfquery>
		</cfif>
		--->
		
		<cfif qResult.RecordCount eq 1>
			<!---
			<cfif newVal eq "UL Mark">
            	<!--- [UL Mark instances + ULI Mark] - [UL Mark AND ULI Mark found] = count of A OR B without duplicates --->
				<cfset qResult.CARCount = #qResult.CARCount# + #ULI.CARCount# - #ULandULI.CARCount#>
				<cfset qTotal = #qTotal# + #qResult.CARCount#>	
			<cfelse>
				<cfset qTotal = #qTotal# + #qResult.CARCount#>			
			</cfif>
			--->
            <cfset qTotal = #qTotal# + #qResult.CARCount#>	
			<td align="center">#qResult.CARCount#</td>	
		<cfelseif qResult.RecordCount eq 0>
			<cfset qTotal = qTotal>
			<td align="center">--</td>
		</cfif>
	</cfloop>
	<!--- total --->
	<td align="center">#qTotal#</td>
	<td align="center" valign="middle">
		<a href="index.cfm?View=#url.view#&Manager=#url.Manager#&Program=#newVal#&type=#url.type#">
			<img src="#SiteDir#SiteImages/table_row.png" align="absmiddle" border="0">
		</a>
	</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->