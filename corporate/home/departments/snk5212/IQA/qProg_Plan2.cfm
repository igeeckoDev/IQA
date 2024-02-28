<!---<cfset tickBegin = GetTickCount()>--->

<cfif NOT isDefined("URL.Year")>
	<cfset StartYear = #curyear# - 3>
<cfelse>
	<cfif url.Year is "All">
	    <cfset StartYear = 2006>
    <cfelse>
    	<cfset StartYear = url.year>
	</cfif>
</cfif>

<cfif NOT isDefined("URL.View")>
	<cfset URL.View = "All">
<cfelse>
	<cfif URL.View neq "NACPO">
    	<cfset URL.View = "All">
    </cfif>
</cfif>

<!--- get a list of NACPO programs - programs where Bill Carney is the Manager --->
<CFQUERY BLOCKFACTOR="100" name="Progs" Datasource="Corporate">
SELECT * FROM ProgDev
WHERE IQA = 1
AND Status IS NULL

<!---
<cfif isDefined("URL.View")>
	<cfif URL.View eq "NACPO">
    	AND Manager = 'Carney, W.'
		OR Manager = 'Mahrenholz, B.'
		OR Manager = 'Bruce Mahrenholz'
    </cfif>
</cfif>
--->

ORDER BY Program
</CFQUERY>

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/sitePopUp.js"></script>
</cfoutput>

<cfoutput>
<div align="Left" class="blog-time">
<script language="JavaScript" src="#IQADir#webhelp/webhelp.js"></script>
IQA Activity Help - <A HREF="javascript:popUp('#IQADir#webhelp/webhelp_IQAActivity.cfm')">[?]</A><br><br>
</div>

<b>Audits of <cfif URL.View eq "NACPO">NA CPO (UL Mark) </cfif>Programs</b><br />
This page shows how <cfif URL.View eq "NACPO">NA CPO (UL Mark) </cfif>Programs are covered by IQA. There are several ways a Program is covered:<br>
<u>Program Audit</u> - Where a Program Audit is conducted on the program.<br>
<u>Local Function (Site Audit)</u> - Where the program is listed as a Key Process in the audit.<br>
<u>Audit Report</u> - The program is listed in the Audit Report as covered during a Local or Global audit.<br><br>

Please view the Legend at the bottom of this page for information about Audit Status.<br /><br />

<CFQUERY BLOCKFACTOR="100" name="baseline" Datasource="Corporate">
SELECT * FROM baseline
WHERE Year_ = #curyear#
</CFQUERY>

<cfif baseline.baseline is 0>
	<font color="red"><b>#curyear# IQA Audit Schedule is tentative</b></font><br>
</cfif>
<font color="red">This table shows <u>all</u> audits (scheduled and completed)</font><br /><Br />

<cfset lastYear = #curyear# - 1>
Start Year:<cfloop index="k" from="2006" to="#url.EndYear#"> [<a href="Prog_Plan.cfm?View=#URL.View#&Year=#k#&EndYear=#URL.EndYear#">#k#</a>] </cfloop><br />
End Year: #url.EndYear#<br /><Br />

<!---
<u>View:</u>
<cfif URL.View eq "NACPO">
	[<a href="Prog_Plan.cfm">All Programs</a>] [<b>NA CPO Programs</b>]
<cfelse>
	[<b>All Programs</b>] [<a href="Prog_Plan.cfm?View=NACPO">NACPO Programs</a>]
</cfif>
<br /><Br />
--->

<cfif startYear eq curYear OR startyear eq url.endYear>
	<cfset allCount = 0>
</cfif>

<!--- set table width --->
<cfset tWidth = 350 + (((url.endyear - startyear) + 1) * 100)>

<table border="1" width="#tWidth#" style="border-collapse: collapse;">
</cfoutput>
<tr>
    <td align="center" valign="top" class="blog-title" width="350">
    	Program
    </td>
    <cfloop index="i" from="#StartYear#" to="#url.endyear#">
    <cfset colspan = (#url.endyear# - #StartYear#) + 1>
	    <td align="center" valign="top" class="blog-title" width="100">
    		<cfoutput>#i#</cfoutput>
    	</td>
    </cfloop>
</tr>

<cfset yearCompare = Compare(StartYear, url.endyear)>

<cfoutput query="Progs">
<tr>
	<td align="left" valign="top" class="blog-content">
    	#Program#
    </td>
<CFQUERY BLOCKFACTOR="100" name="ResultsProgAudit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE Area = '#Program#'
AND AuditType2 = 'Program'
AND AuditedBy = 'IQA'
AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
ORDER BY YEAR_, ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ResultsSiteAudit" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
FROM AuditSchedule
WHERE (KP LIKE '%#Program#%' OR Area = '#Program#')
AND AuditType2 <> 'Program'
AND AuditedBy = 'IQA'
AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
ORDER BY YEAR_, ID
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="ResultsReport" Datasource="Corporate">
SELECT  AuditSchedule.*, AuditSchedule.Year_ AS "Year", Report.Programs
FROM AuditSchedule, Report
WHERE
Report.ID = AuditSchedule.ID
AND Report.Year_ = AuditSchedule.Year_
AND Report.Programs LIKE '%#Program#%'
AND AuditSchedule.AuditType2 <> 'Program'
AND AuditSchedule.AuditedBy = 'IQA'
AND (AuditSchedule.Status IS NULL OR AuditSchedule.Status = '' OR AuditSchedule.Status = 'Deleted')
ORDER BY AuditSchedule.Year_, AuditSchedule.ID
</CFQUERY>
	
	<cfif ResultsProgAudit.recordcount eq 0 AND  ResultsSiteAudit.recordcount eq 0 AND ResultsReport.recordcount eq 0>
    	<td align="center" valign="top" class="blog-content" colspan="#colspan#">
        	None
        </td>
    <cfelse>
		<cfloop index="j" from="#startYear#" to="#URL.EndYear#">
		    <CFQUERY BLOCKFACTOR="100" name="ResultsProgAudit" Datasource="Corporate">
            SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
            FROM AuditSchedule
            WHERE Area = '#Progs.Program#'
            AND AuditType2 = 'Program'
            AND YEAR_ = #j#
            AND AuditedBy = 'IQA'
            AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
			AND Month < 13
            ORDER BY ID
            </CFQUERY>

            <CFQUERY BLOCKFACTOR="100" name="ResultsSiteAudit" Datasource="Corporate">
            SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
            FROM AuditSchedule
            WHERE (KP LIKE '%#Program#%' OR Area = '#Program#')
            AND AuditType2 <> 'Program'
            AND YEAR_ = #j#
            AND AuditedBy = 'IQA'
            AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
			AND Month < 13
            ORDER BY ID
            </CFQUERY>

            <CFQUERY BLOCKFACTOR="100" name="ResultsReport" Datasource="Corporate">
            SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year", Report.Programs
            FROM AuditSchedule, Report
            WHERE
            Report.ID = AuditSchedule.ID
            AND Report.Year_ = AuditSchedule.Year_
            AND AuditSchedule.Year_= #j#
            AND 
				(
					Report.Programs LIKE '%#Program#%'
					<cfif Program eq "&lt;PS&gt;E Mark (JP) (US CO)">
						OR Report.Programs LIKE '%<PS>E Mark (JP) (US CO)%'
					<cfelseif Program eq "&lt;PS&gt;E Mark (JP) (JP CO)">
						OR Report.Programs LIKE '%<PS>E Mark (JP) (JP CO)%'
					</cfif>
				)
            AND AuditSchedule.AuditType2 <> 'Program'
            AND AuditSchedule.AuditedBy = 'IQA'
            AND (AuditSchedule.Status IS NULL OR AuditSchedule.Status = '' OR AuditSchedule.Status = 'Deleted')
			AND Month < 13
            ORDER BY AuditSchedule.AuditType2, AuditSchedule.ID
            </CFQUERY>
			
            <td align="center" valign="top" class="blog-content">
                <cfif ResultsProgAudit.recordcount eq 0 AND ResultsSiteAudit.recordcount eq 0 AND ResultsReport.recordcount eq 0>
                    -
                <cfelse>
					<cfset totalCount = ResultsProgAudit.recordcount + ResultsSiteAudit.recordcount + ResultsReport.recordcount>
					Total: #totalCount#<br>
										
					<cfif ResultsProgAudit.recordcount gt 0>
                    	<u>Program Audit</u><br>
                    	<cfloop query="ResultsProgAudit">
                        	<a href="auditDetails.cfm?Year=#Year#&ID=#ID#">#Year#-#ID#</a>
                            <cfinclude template="#IQARootDir#plan_status.cfm">
                                 <cfif reschedulenextyear is "Yes">
                                    <a href="javascript:sitePopUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')">
                                    	<img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes">
                                    </a>
                                <cfelseif status is "Deleted">
                                    <a href="javascript:sitePopUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')">
                                    	<img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes">
                                    </a>
                                </cfif><br>
                        </cfloop><br>
                    </cfif>
                    <cfif ResultsSiteAudit.recordcount gt 0>
                    	<cfset TypeHolder = "">
                        <cfloop query="ResultsSiteAudit">
                            <cfif TypeHolder IS NOT AuditType2>
                                <cfIf TypeHolder is NOT ""><br></cfif>
                                <u>#AuditType2#</u><br>
                            </cfif>
                            <a href="auditDetails.cfm?Year=#Year#&ID=#ID#">#Year#-#ID#</a>
                            <cfinclude template="#IQARootDir#plan_status.cfm">
                                 <cfif reschedulenextyear is "Yes">
                                    <a href="javascript:sitePopUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')">
                                    	<img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes">
                                    </a>
									
                                <cfelseif status is "Deleted">
                                    <a href="javascript:sitePopUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')">
                                    	<img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes">
                                    </a>
                                </cfif><br>
                        <cfset TypeHolder = AuditType2>
                        </cfloop><br>
                    </cfif>
                    <cfif ResultsReport.recordcount gt 0>
                        <u>Audit Report</u><br>
                        <cfloop query="ResultsReport">
                        	<a href="auditDetails.cfm?Year=#Year#&ID=#ID#">#Year#-#ID#</a>
                            <cfinclude template="#IQARootDir#plan_status.cfm">
                                 <cfif reschedulenextyear is "Yes">
                                    <a href="javascript:sitePopUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')">
                                    	<img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes">
                                    </a>
									
                                <cfelseif status is "Deleted">
                                    <a href="javascript:sitePopUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')">
                                    	<img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes">
                                    </a>
                                </cfif><br>
                        </cfloop>
                    </cfif>
                </cfif>
			</td>
        </cfloop>
	</cfif>
</tr>

<cfif yearCompare eq 0>
	<cfset allCount = allCount + totalCount>
</cfif>

</cfoutput>
</table><br />

<cfif yearCompare eq 0>
	<cfoutput>
		Total Count of Schemes: #allCount#<br>
		Number of Schemes listed above: #progs.recordcount#<br>
		<cfset averageAuditsPerScheme = allCount / progs.recordcount>
		Average Audits per Scheme = #averageAuditsPerScheme#<Br>
	</cfoutput>
</cfif><br>

Note for 2017<br>
ECV and SPC are on a 2 year cycle and will not be audited in 2017. See "Audit Plans" page for approval.<br>
TCB - Telecommunication Certification Body (UK) is not being audited this year. (cancelled during audit planning)<br><br>

<table border="0">
<tr>
    <td class="blog-title" valign="top" align="left">
    	<br />Audit Status Legend
    </td>
</tr>
<tr>
    <td class="blog-content" valign="top" align="left">
		<cfoutput>
        <img src="#IQARootDir#images/red.jpg" border="0"> - Audit Rescheduled for Next Year<br>
        <img src="#IQARootDir#images/yellow.jpg" border="0"> - Audit Scheduled<br>
        <img src="#IQARootDir#images/green.jpg" border="0"> - Audit Completed, Report Completed<br>
        <img src="#IQARootDir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
        <img src="#IQARootDir#images/black.jpg" border="0"> - Audit Cancelled<br>
        <img src="#IQARootDir#images/ico_article.gif" border="0"> - View Notes (for Cancelled and Rescheduled Audits)<br />
        </cfoutput>
	</td>
</tr>
<cfif URL.View eq "NACPO">
<tr>
    <td class="blog-title" valign="top" align="left">
    	<br />NA CPO (UL Mark) Programs
    </td>
</tr>
<tr>
    <td class="blog-content" valign="top" align="left">
        <cfoutput query="Progs">
        - #Program#<br>
        </cfoutput><br />
	</td>
</tr>
</cfif>
</table>

<!---
<cfset tickEnd = GetTickCount()>
<cfset testTime = tickEnd - tickBegin>
<cfoutput>Test time was: #testTime# milliseconds</cfoutput><br /><br />
--->