<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset SubTitle = "GCAR Metrics Overview - CAR Trend Reports">
<!--- /// --->

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfquery name="OverviewTopics" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, Title, Content 
FROM GCAR_Metrics_Overview_Trend
ORDER BY ID
</cfquery>

<cfoutput query="OverviewTopics">
 <img src="../SiteImages/arrow2_bullet.gif"> <a href="Overview_TrendReports.cfm###ID#">#Title#</a><br>
</cfoutput>

<hr class='dash'>

<cfoutput query="OverviewTopics">
<a name="#ID#"></a>
<h2>#ID#. #Title#</h2>
#Content#
<br><br>

<hr width="75%" align="center"><Br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->