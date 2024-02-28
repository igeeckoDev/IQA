<cfset subTitle = "IQA Audit Activity, Audit Coverage, and Schedule Attainment">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
1. <b>IQA Audit Schedule Attainment</b> - <a href="#IQADir#metrics_new.cfm?&AuditedBy=IQA">View</a><br /><Br />

2. <b>IQA Audit Schedule Attainment - by Audit Type</b> - <a href="#IQADir#IQAAuditChart.cfm">View</a><br /><Br />

3. <b>IQA Audit Coverage by Standard Category</b> - <a href="AuditCoverage_New.cfm?year=#curyear#">View</a><br /><Br />

4. <b>IQA Activity - Audit Coverage</b><br />
&nbsp;&nbsp; - Program/Scheme Coverage - <a href="prog_plan.cfm">View</a><br />
&nbsp;&nbsp; - Site Coverage - <a href="site_plan.cfm">View</a><br />
<!---&nbsp;&nbsp; - North American Certifications Program Office (NA CPO) Programs Coverage - <a href="prog_plan.cfm?View=NACPO">View</a><br />--->
&nbsp;&nbsp; - MMS Program Coverage - <a href="MMS_Plan.cfm">View</a><br />
&nbsp;&nbsp; - Certification Body Coverage - <a href="CB_Plan.cfm?Year=2015">View</a><br />
&nbsp;&nbsp; - Global Process Coverage - <a href="Global_Plan.cfm">View</a><br />
</cfoutput><br />

<u>Note</u> - <font color="red">These pages may be slow to load - please be patient while the information is gathered.</font><br /><Br />

<u>Expected Load Times</u><Br />
IQA Audit Coverage by Standard Category - 1-3 seconds<Br />
Program/Scheme Coverage: 20-25 seconds<br />
Site Coverage: 5-10 seconds<br />
MMS Program Coverage: 1-2 seconds<br />
Certification Body Coverage: 1-2 seconds<br>
Global Process Coverage: 2-5 seconds<br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->