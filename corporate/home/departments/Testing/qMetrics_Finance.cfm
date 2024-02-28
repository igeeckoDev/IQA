<cfinclude template="metricsfinance.cfm">

<p align="left">Metrics - 
<cfoutput>
<cfloop from="2007" to="#curyear#" index="i">
	<cfif url.year eq "#i#">
		<b>[ #i# ]</b>&nbsp;
	<cfelse>
		<a href="metrics_finance.cfm?Year=#i#&AuditedBy=#URL.AuditedBy#">[ #i# ]</a>&nbsp;
	</cfif>
</cfloop>
</cfoutput><Br><br>
</p></td>
                     </tr>
	  					<tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content" valign="top">
						  
<b><cfoutput>#URL.AuditedBy# Audit Metrics - Schedule Attainment - #URL.Year#</cfoutput></b><br>
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
<u>Total Audits Scheduled: <B>#TotalAudits.Count#</B></u>
<br>
<u>Total Audits Completed: <B>#Completed.Count#</B></u>
<br>
<u>Cancelled Audits</u>: <B>#Deleted.Count#</B>
<br>
<u>Total Audits Rescheduled (within #url.year#): <B>#rescheduleTotal.Count#</b> - <cfset percent = #PercentageTotal.PercentageTotal# * 100> <B>#NumberFormat(percent, "9999.99")#%</B></u><br>
<u>*Total Audits Rescheduled for Next Year: <b>#Next.Count#</b></u><br><br>

* Audits Rescheduled for Next Year do not count for Audits Scheduled, Completed, or Cancelled in #url.year#.

<br><br>
</cfif>
</cfoutput>