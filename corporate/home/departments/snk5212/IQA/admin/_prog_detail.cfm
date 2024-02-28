<!--- 4/29/2000 
Updated Datasouce to Request.DSN
Updated URL Variables to contain cfqueryparam tag
Tested output due to Cf8/Oracle conversion
--->

<cfquery Datasource="Corporate" name="ProgDetail"> 
SELECT IQAtblOffices.ID, IQAtblOffices.OfficeName, ProgDev.* 
FROM IQAtblOffices, ProgDev
WHERE ProgDev.ID = #URL.ProgID#
AND IQAtblOffices.ID = ProgOversight
</CFQUERY>

<cfquery Datasource="Corporate" name="RH"> 
SELECT ID, ProgId, RevNo, RevDate, RevAuthor, RevDetails 
FROM ProgDev_RH
WHERE RevNo = (SELECT MAX(RevNo) from ProgDev_RH WHERE ProgID = #url.progid#)
AND ProgID = #url.progid#
</CFQUERY>

<cfquery Datasource="Corporate" name="ProgLoc"> 
SELECT IQAtblOffices.ID, IQAtblOffices.OfficeName, ProgDev.ID, ProgLocDev.* 
FROM IQAtblOffices, ProgDev, ProgLocDev
WHERE ProgDev.ID = #URL.ProgID#
AND IQAtblOffices.ID = LocOp
AND ProgDev.ID = ProgID
ORDER BY OfficeName
</CFQUERY>

<cfquery Datasource="Corporate" name="ProgDev">
SELECT * from ProgDev
WHERE ProgDev.ID = #URL.ProgID#
</CFQUERY>

<cfquery Datasource="Corporate" name="ProgAudits">
SELECT AuditSchedule.ID, AuditSchedule.Year_ as Year, AuditSchedule.AuditedBy, Baseline.Baseline 
FROM AuditSchedule, Baseline
WHERE (AuditSchedule.Area = <cfqueryparam value="#ProgDev.Program#" cfsqltype="CF_SQL_VARCHAR">
OR AuditSchedule.KP LIKE <cfqueryparam value="%#ProgDev.Program#%" cfsqltype="CF_SQL_VARCHAR">)
AND AuditSchedule.AuditType2 <> 'Field Services'
AND AuditSchedule.AuditedBy = 'IQA'
AND AuditSchedule.status IS NULL
AND AuditSchedule.Year_ = Baseline.Year_
AND Baseline.Baseline = 1
ORDER BY AuditSchedule.Year_ DESC, AuditSchedule.ID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Program Detail">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput query="ProgDetail">
<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.accesslevel is "CPO" or SESSION.Auth.accesslevel is "SU">
[<a href="_prog_edit.cfm?progid=#ProgDev.id#">Edit</a> Program Details]<br><br>
	<cfelse>
	<br>
	</cfif>
</cflock>

<b>Program</b><br>
#Program#
<br><br>

<cfif len(ProgramSummary)>
	<!--- For Program Summary Expand/Collapse --->
	<style type="text/css">
	.togList
	{
	font-family: verdana;
	font-size: 11px;
	}
	
	.togList dt
	{
	cursor: pointer; cursor: hand;
	}
	
	.togList dt span
	{
	font-family: verdana;
	font-size: 11px;
	}
	
	.togList dd
	{
	width: 500px;
	padding-bottom: 0px;
	}
	
	html.isJS .togList dd
	{
	display: none;
	}
	</style>

	<script type="text/javascript">
	/* Only set closed if JS-enabled */
	document.getElementsByTagName('html')[0].className = 'isJS';
	
	function tog(dt)
	{
	var display, dd=dt;
	/* get dd */
	do{ dd = dd.nextSibling } while(dd.tagName!='DD');
	toOpen =!dd.style.display;
	dd.style.display = toOpen? 'block':''
	dt.getElementsByTagName('span')[0].innerHTML
	= toOpen? '<a>Hide Summary [-]</a>':'<a>View Summary [+]</a>' ;
	}
	</script>

<dl class="togList">
<b>Program Summary</b>
<dt onclick="tog(this)"><span><a>View Summary [+]</a></span></dt>
<dd>#ProgramSummary#</dd>
</dl>
</cfif>


<b>Program Manual</b><br>
<cfif Manual is NOT "">
 <cfloop list="#Manual#" index="i">
  #i#
 </cfloop>
<cfelse>
None Listed
</cfif><br><br>

<b>Type of Program</b><br>
#Type#<br><br>
</cfoutput>

<cfif ProgDetail.Type is "Ancillary">
<cfoutput query="ProgDetail">
	<cfquery Datasource="Corporate" name="Ancillary"> 
	SELECT * from ProgDev
	WHERE ID = #ProgDetail.Parent#
	</CFQUERY>
</cfoutput>	

<cfoutput query="Ancillary">
<b>Associated Program</b><br>
#Program#<br><br>
</cfoutput>
</cfif>

<cfoutput query="ProgDetail">
<b>Program Owner</b><br>
<cfif ProgOwner is "" or ProgOwner is "-">No Program Owner Listed<cfelse>#ProgOwner# - (<a href="mailto:#POEmail#">#POEmail#</a>)</cfif><br>
<u>Owner</u> - #LocOwner#<br>
<u>Region</u> - #Region#<br><br>

<b>Program Manager</b><br>
<cfif Manager is "" or Manager is "-">No Program Manager Listed<cfelse>#Manager# - (<a href="mailto:#PMEmail#">#PMEmail#</a>)</cfif>
<br><br>

<cfif Type is "Ancillary" OR len(Specialist)>
<b>Program Specialist</b><br>
#Specialist# - (<a href="mailto:#SEmail#">#SEmail#</a>)<br><br>
</cfif>

<b>Oversight Location</b><br>
#OfficeName#<br><br>
</cfoutput>

<cfset ProgHolder=""> 
<cfset ATHolder="">
<b>Operating Locations</b><br>
<cfif url.progid is 71>
All UL Offices <a href="Office_list.cfm">[view]</a><br>
<cfelse>
<cfif progloc.recordcount is 0>
No Locations Listed<br>
<cfelse>
<CFOUTPUT Query="ProgLoc">
<cfif officename is "">
No Locations Listed
<cfelse>
<!---<cfif ProgHolder IS NOT Program> 
<cfIf ProgHolder is NOT ""><br></cfif>
</cfif>
	<cfif ATHolder IS NOT ActivityType> 
	<cfIf ATHolder is NOT ""><br></cfif>
	<b>#ActivityType#</b><br>
	</cfif>--->
	&nbsp; - #OfficeName#<br>
	<!---<cfset ATHolder = ActivityType>
	<cfset ProgHolder = Program>--->
</cfif>
</CFOUTPUT>
</cfif>
</cfif>
<br>

<cfoutput query="ProgDetail">
<b>CPO (Certification Programs Office)</b><br>
<cfif cpo is 1>Yes<cfelse>No</cfif><br><br>

<b>CPC (Certification Programs Council)</b><br>
<cfif CPCMR is 1>Yes<cfelse>No</cfif><br><br>

<b>Bronze/Silver</b><br>
<cfif silver is 1>Yes<cfelse>No</cfif><br><br>

<b>Program Audited by IQA</b><br>
<cfif iqa is 1>Yes<cfelse>No</cfif><br><br>

<b>Status</b><br>
<cfif Status is "">Active
<cfelseif Status is "Withdrawn">#Status# - #dateformat(EndDate, "mm/dd/yyyy")#
<cfelseif Status is "Pending">#Status#<cfif StartDate is NOT ""> - #dateformat(StartDate, "mm/dd/yyyy")#</cfif>
<cfelse>#Status#
</cfif><br><br>

<cfif GuideRef is NOT "">
<b>Guide Reference</b><br>
#GuideRef#<br><br>
</cfif>

<b>Comments</b><br>
<cfif comments is NOT "">
#Comments#
<cfelse>
No Comments
</cfif>
<br><br>

<b>Notes</b><br>
<cfif len(notes)>
#Notes#
<cfelse>
No Notes
</cfif>
<br><br>
</cfoutput>

<cfif ProgAudits.recordcount is 0>
<b>Audits</b><br>
There have been no audits of 
<cfoutput query="ProgAudits"><u>#Program#</u></cfoutput> by IQA.<br>
<cfelse>
<cfset YearHolder=""> 
<cfoutput query="ProgAudits">
	<cfif YearHolder IS NOT Year> 
	<cfIf YearHolder is NOT ""><br></cfif>
	<b><u>#Year# Audits</u></b><br> 
	</cfif>
 - <a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#year#-#id#-#auditedby#</a><br>
	<cfset YearHolder = Year>
</cfoutput>
</cfif><br>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=450,left = 200,top = 200');");
}
// End -->
</script>

<cfoutput query="RH" group="RevNo">
<b>Current Revision</b><br>
<u>Revision Number</u>: #RevNo#<br>
<u>Revision Date</u>: #dateformat(RevDate, "mmmm dd, yyyy")#<br>
<u>Revision Author</u>: #RevAuthor#<br>
<u>Revision Details</u>: #RevDetails#<br><br>

<b>Full Revision History</b><br>
<A HREF="javascript:popUp('#IQADir#_prog_rh.cfm?progID=#url.progID#')">View</a> Revision History<br><br>
</cfoutput>

--<br><br>

Note - Please contact <a href="mailto:David.Magri@ul.com">David Magri</a> for any questions, concerns, or comments with the UL Programs Master List.<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->