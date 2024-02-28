<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" name="Progs" Datasource="Corporate">
SELECT * FROM ProgPlanAllDev
WHERE Responsibility IS NULL
AND Manager = 'Carney, W.'
Order By Program
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="Progs2" Datasource="Corporate">
SELECT * FROM ProgPlanAllDev
WHERE ( Responsibility IS NULL OR NOT Responsibility = '')
AND Manager = 'Carney, W.'
Order By Program
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" name="List" Datasource="Corporate">
SELECT * FROM ProgPlanAllDev
WHERE Manager = 'Carney, W.'
Order By Program
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audited NACPO Programs Coverage - IQA Activity">
<cfinclude template="SOP.cfm">

<!--- / --->

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=175,left = 200,top = 200');");
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
<img src="images/red.jpg" border="0"> - Audit Rescheduled for Next Year<br>
<img src="images/yellow.jpg" border="0"> - Audit Scheduled<br>
<img src="images/green.jpg" border="0"> - Audit Completed, Report Completed<br>
<img src="images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
<img src="images/black.jpg" border="0"> - Audit Cancelled<br>
<img src="images/ico_article.gif" border="0"> - View Notes (for Cancelled and Rescheduled Audits)<br>

<br>
<table border="1" width="600">
<tr>
<td align="center" valign="top" class="blog-title" width="420">
Program
</td>
<td align="center" valign="top" class="blog-title" width="90">
Audits<br>
2006
</td>
<td align="center" valign="top" class="blog-title" width="90">
Audits<br>
2007
</td>
<td align="center" valign="top" class="blog-title" width="90">
Audits<br>
2008
</td>
</tr>
<cfoutput query="Progs">
	<CFQUERY BLOCKFACTOR="100" name="Audits6" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT a.*,a.year_ as year
 FROM AuditSchedule a
 WHERE Area = '#Progs.Program#'
	 AND YEAR_='2006' AND  AuditedBy = 'IQA'
 ORDER BY YEAR_, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

	<CFQUERY BLOCKFACTOR="100" name="Audits7" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT a.*,a.year_ as year
 FROM AuditSchedule a
 WHERE Area = '#Progs.Program#'
	 AND YEAR_='2007' AND  AuditedBy = 'IQA'
 ORDER BY YEAR_, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" name="Audits8" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT a.*,a.year_ as year FROM
 AuditSchedule a
 WHERE Area = '#Progs.Program#'
	 AND YEAR_='2008' AND  AuditedBy = 'IQA'
 ORDER BY YEAR_, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
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
- Select &nbsp;<img src="images/ico_article.gif" border="0"> above to view notes<br><br>
<cfelseif status is "deleted">
<u>Audit Cancelled</u><br>
- Select &nbsp;<img src="images/ico_article.gif" border="0"> above to view notes<br><br>
</cfif>
<u>Audit Details</u>
- Click Audit Number above<br>
</div>
</div>
<!--- status color --->
		<cfinclude template="plan_status.cfm">
		<cfif reschedulenextyear is "Yes">
			<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')"><img src="images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelseif status is "deleted">
			<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')"><img src="images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelse>
		</cfif>
		<br>		
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
- Select &nbsp;<img src="images/ico_article.gif" border="0"> above to view notes<br><br>
<cfelseif status is "deleted">
<u>Audit Cancelled</u><br>
- Select &nbsp;<img src="images/ico_article.gif" border="0"> above to view notes<br><br>
</cfif>
<u>Audit Details</u>
- Click Audit Number above<br>
</div>
</div>
<!--- status color --->
	<cfinclude template="plan_status.cfm">
		<cfif reschedulenextyear is "Yes">
			<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')"><img src="images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelseif status is "deleted">
			<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')"><img src="images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelse>
		</cfif>
		<br>
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
- Select &nbsp;<img src="images/ico_article.gif" border="0"> above to view notes<br><br>
<cfelseif status is "deleted">
<u>Audit Cancelled</u><br>
- Select &nbsp;<img src="images/ico_article.gif" border="0"> above to view notes<br><br>
</cfif>
<u>Audit Details</u>
- Click Audit Number above<br>
</div>
</div>
<!--- status color --->
	<cfinclude template="plan_status.cfm">
		<cfif reschedulenextyear is "Yes">
			<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')"><img src="images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelseif status is "deleted">
			<a href="javascript:popUp('status2_notes.cfm?id=#id#&year=#year#')"><img src="images/ico_article.gif" border="0" title="View Notes"></a>
		<cfelse>
		</cfif>
		<br>
	</cfloop>
</cfif>
&nbsp;
</td>
<!--- //// --->
</tr>
</cfoutput>
</table>

<br><br>
The following programs will be audited as part of a site audit:<br>
See Site Audits for more detail<br><br>
<table border="1">
<tr>
<td align="center" valign="top" class="blog-title">
Program
</td>
<td align="center" valign="top" class="blog-title">
Site
</td>
<td align="center" valign="top" class="blog-title">
Site Audits 2006
</td>
<td align="center" valign="top" class="blog-title">
Site Audits 2007
</td>
<td align="center" valign="top" class="blog-title">
Site Audits 2008
</td>
</tr>
<cfoutput query="Progs2">
	<CFQUERY BLOCKFACTOR="100" name="AuditsSite6" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT a.*,a.year_ as year
 FROM AuditSchedule a
 WHERE OfficeName = '#Progs2.Responsibility#'
	 AND YEAR_='2006' AND KP LIKE '%#program#%'
 ORDER BY YEAR_, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>	

	<CFQUERY BLOCKFACTOR="100" name="AuditsSite7" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT a.*,a.year_ as year
 FROM AuditSchedule a
 WHERE OfficeName = '#Progs2.Responsibility#'
	 AND YEAR_='2007' AND KP LIKE '%#program#%'
 ORDER BY YEAR_, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" name="AuditsSite8" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT a.*,a.year_ as year
 FROM AuditSchedule a
 WHERE OfficeName = '#Progs2.Responsibility#'
	 AND YEAR_='2008' AND KP LIKE '%#program#%'
 ORDER BY YEAR_, ID
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>
<tr>
<td align="left" valign="top" class="blog-content">
#Program#
</td>
<td align="left" valign="top" class="blog-content">
#Responsibility#
</td>
<td align="center" valign="top" class="blog-content">
<cfif AuditsSite6.recordcount eq 0>
x
<cfelse>
	<cfloop query="AuditsSite6">
	<a href="auditdetails.cfm?year=#year#&id=#id#">
	#year#-#id#
	</a>
	<br>
	</cfloop>
</cfif>
</td>
<td align="center" valign="top" class="blog-content">
<cfif AuditsSite7.recordcount eq 0>
x
<cfelse>
	<cfloop query="AuditsSite7">
	<a href="auditdetails.cfm?year=#year#&id=#id#">
	#year#-#id#
	</a>
	<br>
	</cfloop>
</cfif>
</td>
<td align="center" valign="top" class="blog-content">
<cfif AuditsSite8.recordcount eq 0>
x
<cfelse>
	<cfloop query="AuditsSite8">
	<a href="auditdetails.cfm?year=#year#&id=#id#">
	#year#-#id#
	</a>
	<br>
	</cfloop>
</cfif>
</td>
</tr>
</cfoutput>
</table>

<br><br>
<u>NACPO Programs</u>:<br>
<cfoutput query="List">
- #Program#<br>
</cfoutput>
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">
