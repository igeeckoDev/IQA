<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" name="Offices" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist = 'Yes'
AND Physical = 'Yes'
Order By OfficeName
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audited Site Coverage - IQA Activity">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<div align="Left" class="blog-time">
IQA Activity Help - <A HREF="javascript:popUp('../webhelp/webhelp_IQAActivity.cfm')">[?]</A></div>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=450,left = 200,top = 200');");
}
// End -->
</script>

<style type="text/css">
  div.transparent {
    filter:alpha(opacity=100);
    background-color: f2f2f2;
    display:none;
    width:250;
    height:200;
    position:absolute;
    color: black;
    border: 1 black solid;
}
</style>
<script>
    /* this function shows the pop-up when
     user moves the mouse over the link */
    function Show(xGUID)
    {
        /* get the mouse left position */
        x = event.clientX + document.body.scrollLeft;
        /* get the mouse top position  */
        y = event.clientY + document.body.scrollTop + 35;
        /* display the pop-up */
        document.getElementById(xGUID).style.display="block";
        /* set the pop-up's left */
        document.getElementById(xGUID).style.left = x;
        /* set the pop-up's top */
        document.getElementById(xGUID).style.top = y;
    }
    /* this function hides the pop-up when
     user moves the mouse out of the link */
    function Hide(xGUID)
    {
        /* hide the pop-up */
        document.getElementById(xGUID).style.display="none";
    }
</script>

<br>

<u><b>Legend</b></u>:<br>
<img src="../images/red.jpg" border="0"> - Audit Rescheduled for Next Year<br>
<img src="../images/yellow.jpg" border="0"> - Audit Scheduled<br>
<img src="../images/green.jpg" border="0"> - Audit Completed, Report Completed<br>
<img src="../images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
<img src="../images/black.jpg" border="0"> - Audit Cancelled<br>
<img src="../images/ico_article.gif" border="0"> - View Notes (for Cancelled and Rescheduled Audits)<br>

<br>
<table border="1" width="600">
<tr>
<td align="center" valign="top" class="blog-title" width="350">
Program
</td>
<cfloop index="i" from="2006" to="#curyear#">
	<td align="center" valign="top" class="blog-title" width="125">
	Audits<br>
	<cfoutput>#i#</cfoutput>
	</td>
</cfloop>
</tr>
<cfoutput query="Offices">
	<cfloop index="i" from="2006" to="#curyear#">
		<CFQUERY BLOCKFACTOR="100" name="qOffices" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM AuditSchedule
 WHERE OfficeName = '#Offices.OfficeName#'
		 AND  (AuditType2 = 'Local Function' or audittype2 = 'Local Function FS' or audittype2 = 'Local Function CBTL')
		 AND YEAR_='#i#' AND  AuditedBy = 'IQA'
 ORDER BY YEAR_, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<tr>
<td align="left" valign="top" class="blog-content">
#OfficeName#
<cfif id is 19 or id is 71 or id is 51>
 - <a href="##notes">1</a>
<cfelseif id is 55 or id is 38 or id is 54 or id is 44>
 - <a href="##notes">2</a>
<cfelseif id is 43>
 - <a href="##notes">3</a>
<cfelseif id is 16>
 - <a href="##notes">4</a>
<cfelseif id is 17>
 - <a href="##notes">5</a>
<cfelseif id is 6>
 - <a href="##notes">6</a>
<cfelseif id is 7>
 - <a href="##notes">7</a>
</cfif>
</td>

<td align="center" valign="top" class="blog-content">
<cfif qOffices.recordcount eq 0>
x
<cfelse>
	<cfloop query="qOffices">
	 <a href="auditdetails.cfm?year=#year#&id=#id#" onMouseOut="Hide(#xGUID#)" onMouseMove="Show(#xGUID#)">#year#-#id#</a>
<!--- details popup --->
<div id="#xGUID#" class="transparent" style="border: 1px solid black" align="left">
<div style="background-color: ##A6A6A6" align="left">
<b>Audit Details - #Year#-#ID#</b></div>
<div style="background-color: ##f2f2f2; padding:2px;" align="left">
#OfficeName#<br>

<cfset CompareDate = Compare(StartDate, EndDate)>
<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>

<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">
#MonthAsString(Month)#, #Year#<br>
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">
#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0>
#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelse>
<cfif End1 eq Start1>
#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#<br>
<cfelse>
#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#<br>
</cfif>
</cfif>

#auditType#, #AuditType2#<br>
#Area#<br>								
Lead Auditor - #LeadAuditor#<br><br>
<cfif reschedulenextyear is "Yes">
<u>Audit Rescheduled for Next Year</u><br>
- Select &nbsp;<img src="../images/ico_article.gif" border="0"> above to view notes<br><br>
<cfelseif status is "deleted">
<u>Audit Cancelled</u><br>
- Select &nbsp;<img src="../images/ico_article.gif" border="0"> above to view notes<br><br>
</cfif>
<u>Audit Details</u>
- Click Audit Number above<br>
</div>
</div>
<!--- status color --->	 
		<cfinclude template="plan_status.cfm">
		<cfif reschedulenextyear is "Yes">
			<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')"><img src="../images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelseif status is "deleted">
			<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')"><img src="../images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelse>
		</cfif>
		<br>
	</cfloop>
</cfif>
&nbsp;
</td>
</tr>
</cfloop>
</cfoutput>
</table>
<br>
<table border="0">
<tr>
<td class="blog-title" valign="top" align="left">
Notes
</td>
</tr>
<tr>
<td class="blog-content" valign="top" align="left">
<a name="notes"></a>
1 - Audit as part of UL Apex Co,. Ltd (Ise/Yokohama) location<br>
2 - Audit as part of UL-CCIC Company Limited (Shanghai/Guangzhou/Suzhou) location<br>
3 - New Location Created for 2007<br>
4 - New Location Created for 2007<br>
5 - No IQA Audit - FUS Activity only<br>
6 - Covered by UL Korea, Ltd. Audit<br>
7 - No IQA Audit - Only Chinese Mark Access Service Activity
</td>
</tr>
</table>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->