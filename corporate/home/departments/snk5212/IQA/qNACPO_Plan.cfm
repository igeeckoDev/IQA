<cfset tickBegin = GetTickCount()>

<cfif NOT isDefined("URL.Year")>
	<cfset StartYear = #curyear# - 3>
<cfelse>
	<cfif url.Year is "All">
	    <cfset StartYear = 2008>
    <cfelse>
    	<cfset StartYear = url.year>
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="Progs" Datasource="Corporate">
SELECT Program, Responsibility, Manager FROM ProgDev
WHERE Manager = 'Carney, W.'
AND IQA = 1
Order By Program
</CFQUERY>

<cfoutput>
	<script language="JavaScript" src="#IQADir#webhelp/webhelp.js"></script>
</cfoutput>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=175,left = 200,top = 200');");
}
// End -->
</script>

<cfoutput>
<div align="Left" class="blog-time">
IQA Activity Help - <A HREF="javascript:popUp('#IQADir#webhelp/webhelp_IQAActivity.cfm')">[?]</A><br /><br />
</div>

<b>NACPO Programs Coverage</b><br />
This page shows all NACPO Programs. Program audits covering each program are listed. For more information, please view the Legend for more information about Audit Status.<br /><br />

See IQA - > Metrics -> IQA Audit Activity and Coverage -> <a href="site_plan.cfm">Site Coverage</a> for more audit coverage detail<br><br />

<CFQUERY BLOCKFACTOR="100" name="baseline" Datasource="Corporate">
SELECT * FROM baseline
WHERE Year_ = #curyear#
</CFQUERY>

<cfif baseline.baseline is 0>
	<font color="red"><b>#curyear# IQA Audit Schedule is tentative</b></font><br>
</cfif>
<font color="red">This table shows <u>all</u> audits (scheduled and completed)</font><br /><Br />

<cfset threeYears = #curyear# - 2>
Start Year:<cfloop index="k" from="2008" to="#threeYears#"> [<a href="Prog_Plan.cfm?View=NACPO&Year=#k#">#k#</a>] </cfloop><br />
End Year: #curyear#<br /><Br />

<!--- set table width --->
<cfset tWidth = 350 + (((curyear - startyear) + 1) * 100)>

<table border="1" width="#tWidth#">
</cfoutput>
<tr>
    <td align="center" valign="top" class="blog-title" width="350">
	    Program
    </td>
    <cfloop index="i" from="#StartYear#" to="#curYear#">
    <cfset colspan = (#curyear# - #StartYear#) + 1>
	    <td align="center" valign="top" class="blog-title" width="100">
    		<cfoutput>#i#</cfoutput>
    	</td>
    </cfloop>
</tr>

<cfoutput query="Progs">
<tr>
	<td align="left" valign="top" class="blog-content">
    	#Program#
    </td>
	<CFQUERY BLOCKFACTOR="100" name="Audits" Datasource="Corporate">
	SELECT AuditSchedule.*, AuditSchedule.year_ AS Year
    FROM AuditSchedule
	WHERE Area = '#Progs.Program#'
    AND AuditType2 = 'Program'
	AND AuditedBy = 'IQA'
	AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
	Order By Year_, ID
	</CFQUERY>

	<cfif Audits.recordcount eq 0>
        <td align="center" valign="top" class="blog-content" colspan="#colspan#">
            None
        </td>
    <cfelse>
    	<cfloop index="j" from="#StartYear#" to="#curYear#">
            <CFQUERY BLOCKFACTOR="100" name="Results" Datasource="Corporate">
            SELECT AuditSchedule.*, AuditSchedule.year_ AS Year
            FROM AuditSchedule
            WHERE Area = '#Progs.Program#'
            AND AuditType2 = 'Program'
            AND AuditedBy = 'IQA'
            AND Year_ = #j#
            AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
            Order By Year_, ID
            </CFQUERY>

            <td align="center" valign="top" class="blog-content">
                <cfif Results.recordcount gt 0>
                    <cfloop query="Results">
                        <a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
                        <cfinclude template="#IQARootDir#plan_status.cfm">
                            <cfif reschedulenextyear is "Yes">
                                <a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')">
                                    <img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes">
                                </a>
                            <cfelseif status is "deleted" or status is "removed">
                                <a href="javascript:popUp('#IQARootDir#status2_notes.cfm?id=#id#&year=#year#')">
                                    <img src="#IQARootDir#images/ico_article.gif" border="0" title="View Notes">
                                 </a>
                            </cfif><br>
                    </cfloop>
                <cfelse>
                    x
                </cfif>
            </td>
		</cfloop>
    </cfif>
	</td>
</tr>
</cfoutput>
</table>

<br>

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
<tr>
    <td class="blog-title" valign="top" align="left">
    	<br />NACPO Programs
    </td>
</tr>
<tr>
    <td class="blog-content" valign="top" align="left">
        <u>NACPO Programs</u>:<br>
        <cfoutput query="Progs">
        - #Program#<br>
        </cfoutput><br />
	</td>
</tr>
</table>

<cfset tickEnd = GetTickCount()>
<cfset testTime = tickEnd - tickBegin>
<cfoutput>Test time was: #testTime# milliseconds</cfoutput><br /><br />