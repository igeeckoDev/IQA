<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Add Report Page 3 - Effectiveness">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" name="outputOfReportData" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	ProgramReportCard_Report3.Rating, ProgramReportCard_Report3.Comments, ProgramReportCard_Areas.AreaName, ProgramReportCard_Report3.CriteriaType,
	ProgramReportCard_Areas.ID
FROM
	ProgramReportCard_Report3, ProgramReportCard_Areas
WHERE
	ProgramReportCard_Areas.ID = ProgramReportCard_Report3.AreaID
	AND ProgramReportCard_Report3.ID = #URL.ID#
	AND ProgramReportCard_Report3.Year_ = #URL.Year#
ORDER BY
	ProgramReportCard_Areas.ID, ProgramReportCard_Report3.CriteriaType
</cfquery>

<cfset AreaHolder = "">

<cfoutput query="outputOfReportData">
	<cfif AreaHolder IS NOT AreaName>
	<cfIf len(Areaholder)>
	<hr width="85%"><br>
	</cfif>

	<b><u>#AreaName#</u></b><br><br>
	</cfif>

<b>#CriteriaType#</b><br>
<u>Rating</u>: #Rating#<br>

<CFQUERY BLOCKFACTOR="100" name="getCriteria" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
select CriteriaText
from ProgramReportCard_Criteria
where AreaID = #ID#
and criteriaType = '#criteriaType#'
and Rating = #Rating#
</cfquery>

<u>Criteria:</u> #getCriteria.CriteriaText#<br>
<u>Comments:</u> #Comments#<br><br>

<cfset AreaHolder = AreaName>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->