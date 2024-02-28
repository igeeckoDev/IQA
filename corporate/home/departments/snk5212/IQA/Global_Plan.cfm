<cfsetting requestTimeOut="300">

<!---<cfset tickBegin = GetTickCount()>--->

<!--- Start of Page File --->
<cfset subTitle = "Global Process Coverage - IQA Activity">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif NOT isDefined("URL.Year")>
	<cfset StartYear = #curyear# - 3>
<cfelse>
	<cfif url.Year is "All">
	    <cfset StartYear = 2006>
    <cfelse>
    	<cfset StartYear = url.year>
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" name="GlobalFunctions" Datasource="Corporate">
SELECT DISTINCT(Area) As GlobalFunction
FROM AuditSchedule
WHERE AuditType2 = 'Global Function/Process'
AND AuditedBy='IQA'
AND Year_ > 2011
AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
Order By GlobalFunction
</CFQUERY>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=450,left = 200,top = 200');");
}
// End -->
</script>

<div align="Left" class="blog-time">
<cfoutput>
<script language="JavaScript" src="#IQARootDir#webhelp/webhelp.js"></script>
IQA Activity Help - <A HREF="javascript:popUp('#IQARootDir#webhelp/webhelp_IQAActivity.cfm')">[?]</A>
</div><br>

<b>Site Audits</b><br />
This page shows all Global Function/Process Audits. For more information, please view the Legend and Footnotes at the bottom of this page.<br /><br />

<CFQUERY BLOCKFACTOR="100" name="baseline" Datasource="Corporate">
SELECT *
FROM baseline
WHERE Year_ = #curyear#
</CFQUERY>

<cfif baseline.baseline is 0>
	<font color="red"><b>#curyear# IQA Audit Schedule is tentative</b></font><br>
</cfif>
<font color="red">This table shows <u>all</u> audits (scheduled and completed)</font><br /><Br />

<cfset threeYears = #curyear# - 2>
Start Year:<cfloop index="k" from="2015" to="#threeYears#"> [<a href="site_plan.cfm?Year=#k#">#k#</a>] </cfloop><br />
End Year: #curyear#<br /><Br />
</cfoutput>

<!--- set table width --->
<cfset tWidth = 350 + (((curyear - startyear) + 1) * 100)>

<cfoutput>
<table border="1" width="#tWidth#" style="border-collapse: collapse;">
</cfoutput>
<tr>
    <td align="center" valign="top" class="blog-title" width="350">
	    Certification Body
    </td>
	<cfloop index="i" from="#StartYear#" to="#curyear#">
	<cfset colspan = (#curyear# - #StartYear#) + 1>
    <td align="center" valign="top" class="blog-title" width="100">
        <cfoutput>#i#</cfoutput>
    </td>
</cfloop>
</tr>
<cfoutput query="GlobalFunctions">
	<CFQUERY BLOCKFACTOR="100" name="Audits" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
    FROM AuditSchedule
    WHERE Area = '#GlobalFunction#'
    AND (AuditType2 = 'Global Function/Process')
    AND AuditedBy = 'IQA'
    AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
    ORDER BY YEAR_, ID
    </CFQUERY>

<tr>
    <td align="left" valign="top" class="blog-content">
    #GlobalFunction#
    </td>

	<cfif Audits.recordcount eq 0>
        <td align="center" valign="top" class="blog-content" colspan="#colspan#">
            None
        </td>
    <cfelse>
        <cfloop index="j" from="#StartYear#" to="#curYear#">
            <CFQUERY BLOCKFACTOR="100" name="Results" Datasource="Corporate">
            SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
            FROM AuditSchedule
            WHERE Area = '#GlobalFunction#'
		    AND (AuditType2 = 'Global Function/Process')
            AND AuditedBy = 'IQA'
            AND Year_ = #j#
            AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
            ORDER BY YEAR_, ID
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
        <img src="#IQARootDir#images/ico_article.gif" border="0"> - View Notes (for Cancelled and Rescheduled Audits)
        </cfoutput>
	</td>
</tr>
</table>

<!---
<cfset tickEnd = GetTickCount()>
<cfset testTime = tickEnd - tickBegin>
<cfoutput>Test time was: #testTime# milliseconds</cfoutput><br /><br />
--->
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->