<!---<cfset tickBegin = GetTickCount()>--->

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
IQA Activity Help - <A HREF="javascript:popUp('#IQADir#webhelp/webhelp_IQAActivity.cfm')">[?]</A></div>
</cfoutput><br />

<CFQUERY BLOCKFACTOR="100" name="Areas" Datasource="Corporate">
SELECT DISTINCT Area FROM AuditSchedule
WHERE AuditType2 = 'MMS - Medical Management Systems'
AND AuditedBy = 'IQA'
AND (Status IS NULL OR Status = 'Deleted')
Order By Area
</CFQUERY>

<b>MMS Program Audits</b><br />
This page shows all Program Audits of each aspect of the MMS Program. For more information, please view the Legend at the bottom of this page.<br /><br />

<CFQUERY BLOCKFACTOR="100" name="baseline" Datasource="Corporate">
SELECT * FROM baseline
WHERE Year_ = #curyear#
</CFQUERY>

<cfif baseline.baseline is 0>
	<font color="red"><b><cfoutput>#curyear#</cfoutput> IQA Audit Schedule is tentative</b></font><br>
</cfif>
<font color="red">This table shows <u>all</u> audits (scheduled and completed)</font><br /><Br />

<table border="1" width="600">
<tr>
    <td align="center" valign="top" class="blog-title" width="300">
    	Program
    </td>
<cfloop index="i" from="2009" to="#curyear#">
	<cfset colspan = (#curyear# - 2009) + 1>
    <td align="center" valign="top" class="blog-title" width="100">
        <cfoutput>#i#</cfoutput>
    </td>
</cfloop>
</tr>

<cfoutput query="Areas">
	<CFQUERY BLOCKFACTOR="100" name="Audits" Datasource="Corporate">
	SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year
	FROM AuditSchedule
	WHERE Area = '#Area#'
	AND AuditedBy = 'IQA'
	AND (Status IS NULL OR Status = 'Deleted')
	Order By Year, ID, Area
	</CFQUERY>

<tr>
    <td align="left" valign="top" class="blog-content">
    	#Area#
    </td>
		<cfif Audits.recordcount eq 0>
    		<td align="center" valign="top" class="blog-content" colspan="#colspan#">
	        	None
			</td>
        <cfelse>
        	<cfloop index="j" from="2009" to="#curYear#">
                <CFQUERY BLOCKFACTOR="100" name="Results" Datasource="Corporate">
                SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year
                FROM AuditSchedule
                WHERE Area = '#Area#'
                AND Year_ = #j#
                AND AuditedBy = 'IQA'
                AND (Status IS NULL OR Status = 'Deleted')
                Order By Year_, ID, Area
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

<br />

<br>
<u><b> Audit Status Legend</b></u>:<br>
<cfoutput>
<img src="#IQARootDir#images/red.jpg" border="0"> - Audit Rescheduled for Next Year<br>
<img src="#IQARootDir#images/yellow.jpg" border="0"> - Audit Scheduled<br>
<img src="#IQARootDir#images/green.jpg" border="0"> - Audit Completed, Report Completed<br>
<img src="#IQARootDir#images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
<img src="#IQARootDir#images/black.jpg" border="0"> - Audit Cancelled<br>
<img src="#IQARootDir#images/ico_article.gif" border="0"> - View Notes (for Cancelled and Rescheduled Audits)<br><br>
</cfoutput>

<!---
<cfset tickEnd = GetTickCount()>
<cfset testTime = tickEnd - tickBegin>
<cfoutput>Test time was: #testTime# milliseconds</cfoutput><br /><br />
--->