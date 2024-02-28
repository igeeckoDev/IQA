<!---
<CFQUERY BLOCKFACTOR="100" name="Progs" Datasource="Corporate">
SELECT * FROM ProgPlanAllDev
Order By Program
</CFQUERY>
--->

<CFQUERY BLOCKFACTOR="100" name="Progs" Datasource="Corporate">
SELECT * FROM ProgDev
WHERE IQA = 1
ORDER BY Program
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="Progs2" Datasource="Corporate">
SELECT * FROM ProgDev
WHERE IQA = 1 
AND Responsibility IS NOT NULL
ORDER BY Program
</CFQUERY>

<!---
<CFQUERY BLOCKFACTOR="100" name="Progs2" Datasource="Corporate">
SELECT * FROM ProgPlanAllDev
WHERE Responsibility IS NOT NULL
Order By Program
</CFQUERY>
--->

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=175,left = 200,top = 200');");
}
// End -->
</script>

<div align="Left" class="blog-time">
<cfoutput>
<script language="JavaScript" src="#IQADir#webhelp/webhelp.js"></script>
IQA Activity Help - <A HREF="javascript:popUp('#IQADir#webhelp/webhelp_IQAActivity.cfm')">[?]</A>
</cfoutput>
</div>

<br>

<u><b>Legend</b></u>:<br>
<cfoutput>
<img src="#IQARootDir#images/red.jpg" border="0"> - Audit Rescheduled for Next Year<br>
<img src="#IQARootDir#images/yellow.jpg" border="0"> - Audit Scheduled<br>
<img src="#IQARootDir#images/green.jpg" border="0"> - Audit Completed, Report Completed<br>
<img src="#IQARootDir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
<img src="#IQARootDir#images/black.jpg" border="0"> - Audit Cancelled<br>
<img src="#IQARootDir#images/ico_article.gif" border="0"> - View Notes (for Cancelled and Rescheduled Audits)<br>
</cfoutput>

<br>
<table border="1" width="690">
<tr>
<td align="center" valign="top" class="blog-title" width="420">
Program
</td>
<td align="center" valign="top" class="blog-title" width="90">
2006
</td>
<td align="center" valign="top" class="blog-title" width="90">
2007
</td>
<td align="center" valign="top" class="blog-title" width="90">
2008
</td>
<td align="center" valign="top" class="blog-title" width="90">
2009
</td>
<td align="center" valign="top" class="blog-title" width="90">
2010
</td>
</tr>
<cfoutput query="Progs">
	<CFQUERY BLOCKFACTOR="100" name="Audits6" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year" 
FROM AuditSchedule
WHERE Area = '#Progs.Program#'
AND YEAR_ = 2006 
AND AuditedBy = 'IQA'
ORDER BY YEAR_, ID
</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Audits7" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE Area = '#Progs.Program#'
AND YEAR_ = 2007 
AND  AuditedBy = 'IQA'
ORDER BY YEAR_, ID
</CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" name="Audits8" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year" 
FROM AuditSchedule
WHERE Area = '#Progs.Program#'
AND YEAR_ = 2008 
AND  AuditedBy = 'IQA'
ORDER BY YEAR_, ID
</CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" name="Audits9" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE Area = '#Progs.Program#'
AND YEAR_ = 2009 
AND AuditedBy = 'IQA'
ORDER BY YEAR_, ID
</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Audits10" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE Area = '#Progs.Program#'
AND YEAR_ = 2010
AND AuditedBy = 'IQA'
ORDER BY YEAR_, ID
</CFQUERY>
<tr>
<td align="left" valign="top" class="blog-content">
#Program#
</td>
<!--- 2006 --->
<!--- scheduled --->
<td align="center" valign="top" class="blog-content">
<cfif Audits6.recordcount eq 0>
x
<cfelse>
	<cfloop query="Audits6">
		<cfif status neq "removed">
	 <a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
<!--- status color --->
		<cfinclude template="#IQARootDir#plan_status.cfm">
		<cfif reschedulenextyear is "Yes">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelseif status is "deleted">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelse>
		</cfif>
		<br>
		</cfif>	
	</cfloop>
</cfif>
&nbsp;
</td>
<!--- 2007 --->
<!--- scheduled --->
<td align="center" valign="top" class="blog-content">
<cfif Audits7.recordcount eq 0>
x
<cfelse>
	<cfloop query="Audits7">
		<cfif status neq "removed">
	 <a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
<!--- status color --->
	<cfinclude template="#IQARootDir#plan_status.cfm">
		<cfif reschedulenextyear is "Yes">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelseif status is "deleted">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelse>
		</cfif>
		<br>
		</cfif>
	</cfloop>
</cfif>
&nbsp;
</td>
<!--- //// --->
<!--- 2008 --->
<!--- scheduled --->
<td align="center" valign="top" class="blog-content">
<cfif Audits8.recordcount eq 0>
x
<cfelse>
	<cfloop query="Audits8">
		<cfif status neq "removed">
	 <a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
<!--- status color --->
	<cfinclude template="#IQARootDir#plan_status.cfm">
		<cfif reschedulenextyear is "Yes">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelseif status is "deleted">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelse>
		</cfif>
		<br>
		</cfif>
	</cfloop>
</cfif>
&nbsp;
</td>
<!--- //// --->
<!--- 2009 --->
<!--- scheduled --->
<td align="center" valign="top" class="blog-content">
<cfif Audits9.recordcount eq 0>
x
<cfelse>
	<cfloop query="Audits9">
		<cfif status neq "removed">
	 <a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
<!--- status color --->
	<cfinclude template="#IQARootDir#plan_status.cfm">
		<cfif reschedulenextyear is "Yes">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelseif status is "deleted">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelse>
		</cfif>
		<br>
	</cfif>
	</cfloop>
</cfif>
&nbsp;
</td>
<!--- //// --->
<!--- 2010 --->
<!--- scheduled --->
<td align="center" valign="top" class="blog-content">
<cfif Audits10.recordcount eq 0>
x
<cfelse>
	<cfloop query="Audits10">
		<cfif status neq "removed">
	 <a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
<!--- status color --->
	<cfinclude template="#IQARootDir#plan_status.cfm">
		<cfif reschedulenextyear is "Yes">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelseif status is "deleted">
			<a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')"><img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelse>
		</cfif>
		<br>
		</cfif>
	</cfloop>
</cfif>
&nbsp;
</td>
</tr>
</cfoutput>
</table>

<br><br>
2006-2010: The following programs were audited as part of a site audit:<br>
See Site Audits for more detail<br><br>
<table border="1">
<tr>
<td align="center" valign="top" class="blog-title">
Program
</td>
<td align="center" valign="top" class="blog-title">
Site
</td>
<cfloop index="i" from="2006" to="2010">
<td align="center" valign="top" class="blog-title">
Site Audits<br><cfoutput>#i#</cfoutput>
</td>
</cfloop>
</tr>
<cfoutput query="Progs2">
<CFQUERY BLOCKFACTOR="100" name="AuditsSite6" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE OfficeName = '#Progs2.Responsibility#'
AND YEAR_= 2006 
AND KP LIKE '%#program#%'
ORDER BY YEAR_, ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditsSite6Report" Datasource="Corporate"> 
SELECT AuditSchedule.ID, AuditSchedule.Year_ AS "Year", AuditSchedule.AuditType2, Report.Programs, AuditSchedule.Status
FROM AuditSchedule, Report
WHERE 
Report.ID = AuditSchedule.ID 
AND Report.Year_ = AuditSchedule.Year_
AND AuditSchedule.OfficeName = '#Progs2.Responsibility#'
AND AuditSchedule.YEAR_= 2006
AND Report.Programs LIKE '%#program#%'
ORDER BY AuditSchedule.YEAR_, AuditSchedule.ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditsSite7" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE OfficeName = '#Progs2.Responsibility#'
AND YEAR_= 2007 
AND KP LIKE '%#program#%'
ORDER BY YEAR_, ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditsSite7Report" Datasource="Corporate"> 
SELECT AuditSchedule.ID, AuditSchedule.Year_ AS "Year", AuditSchedule.AuditType2, Report.Programs, AuditSchedule.Status
FROM AuditSchedule, Report
WHERE 
Report.ID = AuditSchedule.ID 
AND Report.Year_ = AuditSchedule.Year_
AND AuditSchedule.OfficeName = '#Progs2.Responsibility#'
AND AuditSchedule.YEAR_= 2007
AND Report.Programs LIKE '%#program#%'
ORDER BY AuditSchedule.YEAR_, AuditSchedule.ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditsSite8" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE OfficeName = '#Progs2.Responsibility#'
AND YEAR_= 2008 
AND KP LIKE '%#program#%'
ORDER BY YEAR_, ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditsSite8Report" Datasource="Corporate"> 
SELECT AuditSchedule.ID, AuditSchedule.Year_ AS "Year", AuditSchedule.AuditType2, Report.Programs, AuditSchedule.Status
FROM AuditSchedule, Report
WHERE 
Report.ID = AuditSchedule.ID 
AND Report.Year_ = AuditSchedule.Year_
AND AuditSchedule.OfficeName = '#Progs2.Responsibility#'
AND AuditSchedule.YEAR_= 2008
AND Report.Programs LIKE '%#program#%'
ORDER BY AuditSchedule.YEAR_, AuditSchedule.ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditsSite9" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE OfficeName = '#Progs2.Responsibility#'
AND YEAR_= 2009 
AND KP LIKE '%#program#%'
ORDER BY YEAR_, ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditsSite9Report" Datasource="Corporate"> 
SELECT AuditSchedule.ID, AuditSchedule.Year_ AS "Year", AuditSchedule.AuditType2, Report.Programs, AuditSchedule.Status
FROM AuditSchedule, Report
WHERE 
Report.ID = AuditSchedule.ID 
AND Report.Year_ = AuditSchedule.Year_
AND AuditSchedule.OfficeName = '#Progs2.Responsibility#'
AND AuditSchedule.YEAR_= 2009 
AND Report.Programs LIKE '%#program#%'
ORDER BY AuditSchedule.YEAR_, AuditSchedule.ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditsSite0" Datasource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE OfficeName = '#Progs2.Responsibility#'
AND YEAR_= 2010 
AND KP LIKE '%#program#%'
ORDER BY YEAR_, ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="AuditsSite0Report" Datasource="Corporate"> 
SELECT AuditSchedule.ID, AuditSchedule.Year_ AS "Year", AuditSchedule.AuditType2, Report.Programs, AuditSchedule.Status
FROM AuditSchedule, Report
WHERE 
Report.ID = AuditSchedule.ID 
AND Report.Year_ = AuditSchedule.Year_
AND AuditSchedule.OfficeName = '#Progs2.Responsibility#'
AND AuditSchedule.YEAR_= 2010 
AND Report.Programs LIKE '%#program#%'
ORDER BY AuditSchedule.YEAR_, AuditSchedule.ID
</CFQUERY>
<tr>
<td align="left" valign="top" class="blog-content">
#Program#
</td>
<td align="left" valign="top" class="blog-content">
#Responsibility#
</td>
<td align="center" valign="top" class="blog-content">
<cfif AuditsSite6.recordcount eq 0 AND AuditsSite6Report.recordcount eq 0>
x
<cfelse>
	<cfloop query="AuditsSite6">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
	<cfloop query="AuditsSite6Report">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
</cfif>
</td>
<td align="center" valign="top" class="blog-content">
<cfif AuditsSite7.recordcount eq 0 AND AuditsSite7Report.recordcount eq 0>
x
<cfelse>
	<cfloop query="AuditsSite7">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
	<cfloop query="AuditsSite7Report">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
</cfif>
</td>
<td align="center" valign="top" class="blog-content">
<cfif AuditsSite8.recordcount eq 0 AND AuditsSite8Report.recordcount eq 0>
x
<cfelse>
	<cfloop query="AuditsSite8">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
	<cfloop query="AuditsSite8Report">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
</cfif>
</td>
<td align="center" valign="top" class="blog-content">
<cfif AuditsSite9.recordcount eq 0 AND AuditsSite9Report.recordcount eq 0>
x
<cfelse>
	<cfloop query="AuditsSite9">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
	<cfloop query="AuditsSite9Report">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
</cfif>
</td>
<td align="center" valign="top" class="blog-content">
<cfif AuditsSite0.recordcount eq 0 AND AuditsSite0Report.recordcount eq 0>
x
<cfelse>
	<cfloop query="AuditsSite0">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
	<cfloop query="AuditsSite0Report">
		<cfif status neq "removed">
			<a href="auditdetails.cfm?year=#year#&id=#id#">
			#year#-#id#
			</a>
			<br>
		</cfif>
	</cfloop>
</cfif>
</td>
</tr>
</cfoutput>
</table>