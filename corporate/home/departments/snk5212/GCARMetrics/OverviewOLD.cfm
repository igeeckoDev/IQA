<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset SubTitle = "GCAR Metrics Overview">
<!--- /// --->

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>Note</b> - The system was designed to be used with <u>Internet Explorer</u>. Some differences may exist when using other browsers.<br><br>

If you are having trouble with exporting CAR data with a browser other than IE, try using IE and follow the steps in <a href="http://usnbkiqas100p/departments/snk5212/GCARMetrics/Overview.cfm#5">Item 5 "Exporting GCAR Data"</a>, item 1 and 2.<Br>

<br>
<hr class='dash'>
<br>

<cfquery name="OverviewTopics" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, Title, Content FROM GCAR_Metrics_Overview
ORDER BY ID
</cfquery>

<cfoutput query="OverviewTopics">
 <img src="../SiteImages/arrow2_bullet.gif"> <a href="Overview.cfm###ID#">#Title#</a><br>
</cfoutput>

<br>
<hr class='dash'>
<br>

<cfoutput query="OverviewTopics">
<a name="#ID#"></a>
<h2>#ID#. #Title#</h2>
#Content#<br>
<hr width="75%" align="center"><Br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->