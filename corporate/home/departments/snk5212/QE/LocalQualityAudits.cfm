<!--- Start of Page File --->
<cfset subTitle = "ANSI / OSHA / SCC Reports from Local Quality Audits - #url.year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="SearchResults" >
SELECT YEAR_ as "Year", ID, Month, StartDate, EndDate, OfficeName, audittype, auditedby, RescheduleNextYear, status, leadauditor, ascontact, auditor, sitecontact, audittype2

FROM AuditSchedule

WHERE Approved = 'Yes'
AND Status IS Null
AND (AUDITEDBY <> 'IQA' AND AUDITEDBY <> 'AS')
AND (AUDITTYPE LIKE 'ANSI%' OR AUDITTYPE LIKE 'OSHA%' OR AUDITTYPE LIKE 'SCC%')
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
AND Year_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER">

ORDER BY AuditType, Month, ID
</cfquery>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Distinct">
SELECT
	DISTINCT AuditType
FROM
	AuditSchedule

WHERE 
	Approved = 'Yes'
AND Status IS Null
AND (AUDITEDBY <> 'IQA' AND AUDITEDBY <> 'AS')
AND (AUDITTYPE LIKE 'ANSI%' OR AUDITTYPE LIKE 'OSHA%' OR AUDITTYPE LIKE 'SCC%')
AND (RescheduleNextYear IS NULL OR RescheduleNextYear = 'No')
AND Year_ = <cfqueryparam value="#URL.Year#" CFSQLTYPE="CF_SQL_INTEGER">
</CFQUERY>

<u>Search Criteria</u>:
<b style="text-transform: capitalize;">
Local Quality Audits - (ANSI/OSHA/SCC Only)
</b><br><br>
<cfoutput>
Search Returned #searchresults.recordcount# Audits<br><br>

Jump to Year:<br>
<SELECT NAME="YearJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Year Below
		<option value="javascript:document.location.reload();">
<cfloop index="i" to="2010" from="2007">
		<OPTION VALUE="LocalQualityAudits.cfm?year=#i#">#i#
</cfloop>
</SELECT>
<br><br>
</cfoutput>

<cfset NumFields = 4>

<b>View Accreditor</b>:<br>
<cfoutput query="Distinct">
 :: <a href="###AuditType#">#AuditType#</a><br>
</cfoutput><br>

<table border="1">
<tr>
	<td class="Blog-title" align="center">Audit Number<br>(Link to Audit Details Page)</td>
	<td class="Blog-title" align="center">Location</td>
	<td class="Blog-title" align="center">Dates</td>
   	<td class="Blog-title" align="center">View/Add<br>Report</td>
</tr>
<cfset TypeHolder = "">
<cfoutput query="SearchResults">
	<cfif TypeHolder IS NOT AuditType>
		<cfIf TypeHolder is NOT ""></cfif>
		<tr>
			<td colspan="#NumFields#" class="Blog-Title">
				<a name="#AuditType#"></a>
				<b>#AuditType#</b>
			</td>
		</tr>
	</cfif>

<tr>
	<td class="Blog-content">
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
    function Show(id)
    {
        /* get the mouse left position */
        x = event.clientX + document.body.scrollLeft;
        /* get the mouse top position  */
        y = event.clientY + document.body.scrollTop + 35;
        /* display the pop-up */
        document.getElementById(id).style.display="block";
        /* set the pop-up's left */
        document.getElementById(id).style.left = x;
        /* set the pop-up's top */
        document.getElementById(id).style.top = y;
    }
    /* this function hides the pop-up when
     user moves the mouse out of the link */
    function Hide(id)
    {
        /* hide the pop-up */
        document.getElementById(id).style.display="none";
    }
</script>

<a href="../IQA/auditdetails.cfm?id=#ID#&year=#Year#" target="_blank" onMouseOut="Hide(#id#)" onMouseMove="Show(#id#)">
#year#-#id#-#AuditedBy#
</a>
<div id="#ID#" class="transparent" style="border: 1px solid black" align="left">
<div style="background-color: ##A6A6A6" align="left">
<b>Audit Details<br />#Year#-#ID#-#AuditedBy#</b></div>
<div style="background-color: ##f2f2f2; padding:2px;" align="left">
	Site: #OfficeName#<br>
	Accreditor: #auditType#<br>

<!--- uses incDates.cfc --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">
    
	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>
	
	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>
    
    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>

<!--- output of incDates.cfc --->
#DateOutput#<Br />

	UL Site Contact: #SiteContact#<br>
	Click Audit Number to view details
	</div>
</div>
	</td>
	<td class="Blog-content">#OfficeName#</td>
	<td class="Blog-content">
		<!--- output of incDates.cfc --->
		#DateOutput#
	</td>
    <td class="Blog-content" align="center"><a href="ASReports_details.cfm?ID=#ID#&Year=#Year#">View</a></td>
</tr>
<cfset TypeHolder = AuditType>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->