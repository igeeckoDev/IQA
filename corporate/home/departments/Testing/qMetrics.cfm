<cfinclude template="metricsqueries.cfm">

<cfoutput>
<cfloop from="2010" to="#curyear#" index="i">
	<cfif url.year eq "#i#">
		<b>[ #i# ]</b>&nbsp;
	<cfelse>
		<a href="metrics.cfm?Year=#i#&AuditedBy=#URL.AuditedBy#">[ #i# ]</a>&nbsp;
	</cfif>
</cfloop>
</cfoutput><Br><br>

<cfif URL.Year is CurYear>
as of <cfset today = DateFormat(now(), "mmmm d, yyyy")><cfoutput>#today#</cfoutput><br>
<cfelse>
</cfif>
<br>
<a href="metrics_region.cfm">View other Regions</a>
<br>
<br>

<cfoutput>
<cfif TotalAudits.Count is 0>
No audits found.
<cfelse>

<u>Total Audits Scheduled: <B>#TotalAudits.Count#</B></u><br>
<cfif URL.Year lt 2008>
Third Party Audits: <B>#TotalTPTDP.Count#</B><br>
</cfif>
Quality System Audits: <B>#TotalQS.Count#</B><br>
Technical Assessment Audits: <B>#TotalTA.Count#</B>
<br><br>

<u>Total Audits Completed: <B>#TotalCompleted.Count#</B></u><br>
<cfif URL.Year lt 2008>
Third Party Audits: <B>#CompletedTPTDP.Count#</B><br>
</cfif>
Quality System Audits: <B>#CompletedQS.Count#</B><br>
Technical Assessment Audits: <B>#TACompleted.Count#</B>
<br><br>

<u>Cancelled Audits</u>: <B>#Deleted.Count#</B><br>
<cfif URL.Year lt 2008>
Third Party Audits: <B>#DeletedTPTDP.Count#</B><br>
</cfif>
Quality System Audits: <B>#DeletedQS.Count#</B><br>
Technical Assessment Audits: <B>#DeletedTA.Count#</B>
<br><br>

<u>Rescheduled for Next Year Audits</u>:  <B>#NextYear.Count#</B><br>
<cfif URL.Year lt 2008>
Third Party Audits: <B>#NextYearTPTDP.Count#</B><br>
</cfif>
Quality System Audits: <B>#NextYearQS.Count#</B><br>
Technical Assessment Audits: <B>#NextYearTA.Count#</B>
<br><br>

<u>Total Audits Rescheduled: <B>#rescheduleTotal.Count#</b> - <cfset percent = #PercentageTotal.PercentageTotal# * 100> <B>#NumberFormat(percent, "9999.99")#%</B></u><br>

<cfif URL.Year is 2004>
Third Party Audits: <B>#rescheduleTPTDPfor2004.Count#</B> - <cfset percent = #PercentageTPTDPfor2004.PercentageTPTDP04# * 100> <B>#NumberFormat(percent, "9999.99")#%</b><br>

2004 Third Party Audits<br>moved to 2005: <B>#rescheduleTPTDPfor2005.Count#</B> - <cfset percent = #PercentageTPTDPfor2005.PercentageTPTDP05# * 100> <B>#NumberFormat(percent, "9999.99")#%</b><br>
<cfelse>

	<cfif URL.Year lt 2008>
		<cfif totalTPTDP.Count is 0>
		Third Party Audits: <b>0 - 0.00%</b>
		<br>
		<cfelse>

		Third Party Audits: <B>#rescheduleTPTDP.Count#</B> - <cfset percent = #PercentageTPTDP.PercentageTPTDP# * 100> <B>#NumberFormat(percent, "9999.99")#%</b>
		<br>
		</cfif>
	</cfif>
</cfif>

<cfif totalqs.Count is 0>
Quality System Audits: <b>0 - 0.00%</b>
<br>
<cfelse>
Quality System Audits: <B>#rescheduleQS.Count#</b> - <cfset percent = #PercentageQS.PercentageQS# * 100> <B>#NumberFormat(percent, "9999.99")#%</B>
<br>
</cfif>

<cfif totalta.Count is 0>
Technical Assessment Audits: <b>0 - 0.00%</b>
<br>
<cfelse>
Technical Assessment Audits: <B>#rescheduleTA.Count#</b> - <cfset percent = #PercentageTA.PercentageTA# * 100> <B>#NumberFormat(percent, "9999.99")#%</B>
<br>
</cfif>
<br>

</cfif>
</cfoutput>