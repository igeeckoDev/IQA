<cfoutput>
	<script language="JavaScript" src="#IQADir#webhelp/webhelp.js"></script>
</cfoutput>

<cfquery Datasource="Corporate" name="Region">
SELECT * from IQARegion, IQASubRegion
WHERE NOT IQASubRegion.SubRegion = 'None'
AND IQARegion.Region = IQASubRegion.Region
ORDER BY IQARegion.Region, IQASubRegion.SubRegion
</CFQUERY>

<br>
<b>Corporate</b><br>
<cfoutput>
<a href="#IQADir#metrics_new.cfm?&AuditedBy=IQA">Corporate IQA Metrics</a>
</cfoutput>
<br><br>

<!---
<cfoutput>
<b>Third Party Report Card</b> (2006-2007)<br>
&nbsp;&nbsp; - <a href="report/report.cfm?Year=#curyear#">View</a>
</cfoutput>
<br><br>
--->

<!--- Hide (No Content)
<b>IQA Related Metrics</b> - <a href="CARFiles.cfm?Category=Metrics">View</a><br><br>
--->

<cfoutput>
<b>IQA Activity</b><br>
&nbsp;&nbsp; - Audited Program Coverage - <a href="#IQADir#prog_plan.cfm">View</a><br>
&nbsp;&nbsp; - Audited Site Coverage - <a href="#IQADir#site_plan.cfm">View</a><br>
<!---
Removed due to change in responsibility of TPTDP
&nbsp;&nbsp; - Audited Third Party Coverage - <a href="TP_Plan.cfm">View</a><br>
--->
&nbsp;&nbsp; - Audited NACPO Programs Coverage - <a href="#IQADir#Prog_Plan.cfm?View=NACPO">View</a><br>
&nbsp;&nbsp; - MMS Program Coverage - <a href="#IQADir#MMS_Plan.cfm">View</a>
<br><br>

<!---
<b>Corporate Finance</b><br>
&nbsp;&nbsp; - <a href="#IQADir#metrics_finance.cfm?Year=#CurYear#&AuditedBy=Finance">View</a>
--->
<br><br>
</cfoutput>

<!---
<cfset RegHolder="">

<CFOUTPUT Query="Region">
<cfif region is NOT "corporate" AND region is NOT "global">
<cfif RegHolder IS NOT Region>
<cfIf len(RegHolder)><br></cfif>
<b>#Region#</b><br>
</cfif>
&nbsp;&nbsp; - <a href="#IQADir#metrics.cfm?Year=#CurYear#&AuditedBy=#SubRegion#">#SubRegion#</a><br>
<cfset RegHolder = Region>
</cfif>
</CFOUTPUT>
<br>
--->