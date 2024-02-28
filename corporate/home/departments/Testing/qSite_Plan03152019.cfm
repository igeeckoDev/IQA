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

<CFQUERY BLOCKFACTOR="100" name="Offices" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist = 'Yes'
AND Physical = 'Yes'
AND CB = 'No'
AND SuperLocation <> 'Yes'
Order By OfficeName
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
This page shows all Local Function (Site) Audits of each UL Location. Some audits cover multiple locations. For more information, please view the Legend and Footnotes at the bottom of this page.<br /><br />

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
Start Year:<cfloop index="k" from="2006" to="#threeYears#"> [<a href="site_plan.cfm?Year=#k#">#k#</a>] </cfloop><br />
End Year: #curyear#<br /><Br />
</cfoutput>

<!--- set table width --->
<cfset tWidth = 350 + (((curyear - startyear) + 1) * 100)>

<cfoutput>
<table border="1" width="#tWidth#" style="border-collapse: collapse;">
</cfoutput>
<tr>
    <td align="center" valign="top" class="blog-title" width="350">
	    Site
    </td>
	<cfloop index="i" from="#StartYear#" to="#curyear#">
	<cfset colspan = (#curyear# - #StartYear#) + 1>
    <td align="center" valign="top" class="blog-title" width="100">
        <cfoutput>#i#</cfoutput>
    </td>
</cfloop>
</tr>
<cfoutput query="Offices">
	<CFQUERY BLOCKFACTOR="100" name="Audits" Datasource="Corporate">
    SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year"
    FROM AuditSchedule
    WHERE OfficeName = '#OfficeName#'
    AND (AuditType2 = 'Local Function' or audittype2 = 'Local Function FS' or audittype2 = 'Local Function CBTL')
    AND AuditedBy = 'IQA'
    AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
    ORDER BY YEAR_, ID
    </CFQUERY>

<tr>
    <td align="left" valign="top" class="blog-content">
    #OfficeName#
    <cfif OfficeName is "UL-CCIC Company Limited (Shanghai / Guangzhou / Suzhou)"
        OR OfficeName is "UL Japan, Inc. (Ise / Yokohama / Tokyo)">
     - <a href="##notes">1</a>
    <cfelseif OfficeName is "Canada (All Locations)"
        OR OfficeName is "Central US (NBK, Minn, Dallas)"
        OR OfficeName is "Central US West (San Jose, Boulder)"
        OR Officename is "Germany (Munich, Frankfurt)"
        OR OfficeName is "North EULA (Demko, Sweden)">
     - <a href="##notes">2</a>
    <cfelseif OfficeName is "New Zealand (Christchurch and Auckland)">
     - <a href="##notes">3</a>
    <cfelseif OfficeName is "UK (Guildford, Warrington)">
     - <a href="##notes">4</a>
    <cfelseif OfficeName is "Guangzhou, China Representative Office">
     - <a href="##notes">5</a>
    <cfelseif OfficeName is "UL Korea, Ltd. Yeido Laboratory">
     - <a href="##notes">6</a>
    <cfelseif OfficeName is "UL-CCIC Company Limited Beijing Branch">
     - <a href="##notes">7</a>
    </cfif>
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
            WHERE OfficeName = '#OfficeName#'
            AND (AuditType2 = 'Local Function' or audittype2 = 'Local Function FS' or audittype2 = 'Local Function CBTL')
            AND AuditedBy = 'IQA'
            AND Year_ = #j#
            AND (Status IS NULL OR Status = '' OR Status = 'Deleted')
            ORDER BY YEAR_, ID
            </CFQUERY>

            <td align="center" valign="top" class="blog-content">
				
				<cfif Results.recordcount gt 0>
				<CFSET counts1= #Results.recordcount#>    
					#counts1#
                <cfelse>
				<CFSET counts1= 0>                  
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
<tr>
    <td class="blog-title" valign="top" align="left">
    	<br />
        Site Audits - Footnotes
    </td>
</tr>
<tr>
    <td class="blog-content" valign="top" align="left">
        <a name="notes"></a>
        1 - New Locations Created for 2007<br>
        2 - New Locations Created for 2008<br />
        3 - New Location Created for 2009<br />
        4 - New Location Created for 2010<br />
        5 - No IQA Site Audit of this location - FUS Activity only<br>
        6 - Covered by UL Korea, Ltd. Audit<br>
        7 - No IQA Site Audit of this location - Only Chinese Mark Access Service Activity<br />
</td>
</tr>
<tr>
    <td class="blog-title" valign="top" align="left">
    	<br />
	    List of Super-Locations and their associated UL Offices
    </td>
</tr>
<tr>
    <td class="blog-content" valign="top" align="left">
        <CFQUERY BLOCKFACTOR="100" name="Supers" Datasource="Corporate">
        SELECT OfficeName, ID
        FROM IQAtblOffices
        WHERE SuperLocation = 'Yes'
        ORDER BY OfficeName
        </CFQUERY>

        <cfoutput query="Supers">
        <u>#OfficeName#</u><Br>

            <CFQUERY BLOCKFACTOR="100" name="Locations" Datasource="Corporate">
            SELECT OfficeName
            FROM IQAtblOffices
            WHERE SuperLocationID = #Supers.ID#
            ORDER BY OfficeName
            </CFQUERY>

            <cfloop query="Locations">
            #OfficeName#<br>
            </cfloop><br>
        </cfoutput>
	</td>
</tr>
</table>

<!---
<cfset tickEnd = GetTickCount()>
<cfset testTime = tickEnd - tickBegin>
<cfoutput>Test time was: #testTime# milliseconds</cfoutput><br /><br />
--->