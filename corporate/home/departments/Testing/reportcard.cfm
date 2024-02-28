<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Third Party Report Card">
<cfinclude template="SOP.cfm">

<!--- / --->
<br>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Ex">
SELECT * FROM ExternalLocation
WHERE ExternalLocation.ExternalLocation = '#URL.TP#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT AuditSchedule.Year_ as Year, AuditSchedule.ID, AuditSchedule.Month, ExternalLocation.Type, ExternalLocation.ExternalLocation, AuditSchedule.Report, ExternalLocation.Watch, AuditSchedule.Status, AuditSchedule.ExternalLocation

FROM AuditSchedule, ExternalLocation

WHERE ExternalLocation.ExternalLocation = '#URL.TP#'
AND ExternalLocation.ExternalLocation = AuditSchedule.ExternaLLocation
AND Auditschedule.Report = 'Completed'
</cfquery>

<cfif Check.recordcount is 0>
<p class="blog-content">There are no Audit Reports recorded, the Report Card is not available.</p>
<cfelse>

<table border="1">
<tr>
<td class="blog-content">
<cfoutput><b>#URL.TP#</b></cfoutput>
</td>
<cfoutput>
<td class="blog-content" valign="top" align="center">2005</td>
<td class="blog-content" valign="top" align="center">2006</td>
<td class="blog-content" valign="top" align="center">2007</td>
</cfoutput>
</tr>

<tr>
<td class="blog-content">
Repeat CARs
</td>

<cfloop from="2005" to="2007" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check2">
SELECT * FROM RepeatCARs
WHERE ExternalLocation = '#URL.TP#'
AND Year_ = #i#
</cfquery>

<cfif Check2.RecordCount eq 0>
N/A
<cfelse>

<cfset var=ArrayNew(1)>
<cfoutput query="Check2">
<CFSET var[1] = '#RCAR1#'>
<CFSET var[2] = '#RCAR2#'>
<CFSET var[3] = '#RCAR3#'>
<CFSET var[4] = '#RCAR4#'>
<CFSET var[5] = '#RCAR5#'>
<CFSET var[6] = '#RCAR6#'>
<CFSET var[7] = '#RCAR7#'>
<CFSET var[8] = '#RCAR8#'>
<CFSET var[9] = '#RCAR9#'>
<CFSET var[10] = '#RCAR10#'>
<CFSET var[11] = '#RCAR11#'>
<CFSET var[12] = '#RCAR12#'>
<CFSET var[13] = '#RCAR13#'>
<CFSET var[14] = '#RCAR14#'>
<CFSET var[15] = '#RCAR15#'>
<CFSET var[16] = '#RCAR16#'>
<CFSET var[17] = '#RCAR17#'>
<CFSET var[18] = '#RCAR18#'>
<CFSET var[19] = '#RCAR19#'>
<CFSET var[20] = '#RCAR20#'>
</cfoutput>

<cfset rcount = 0>
<cfloop index="n" from="1" to="20">
	<cfif var[n] is NOT "0">
		<cfset rcount = rcount + 1>
	<cfelse>
		<cfset rcount = rcount>
	</cfif>
</cfloop>	

<cfoutput>
	<cfif rcount gt 0>
	<img src="images/red.jpg"> (#rcount#)&nbsp;
	<cfelse>
	<img src="images/green.jpg"> (#rcount#) &nbsp;
	</cfif>
</cfoutput>
</cfif>

</td>
</cfloop>
</tr>

<tr>
<td class="blog-content">
Number of CARs Generated
</td>

<cfloop from="2005" to="2007" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="NC">
SELECT (Count1+Count2+Count3+Count4+Count5+Count6+Count7+Count8+Count9+Count10+Count11+Count12+Count13+Count14+Count15+Count16+Count17+Count18+Count19+Count20+Count21+Count22+Count23+Count24+Count25+CountOther) 
as Count FROM Nonconformances
WHERE ExternalLocation = '#URL.TP#' 
AND Year_ = #i#
</cfquery>

<cfif NC.RecordCount eq 0>
N/A
<cfelse>
	<cfoutput>
	<cfif NC.Count gt 10>
	<img src="images/red.jpg"> (#NC.Count#)&nbsp;
	<cfelseif NC.Count gte 8 AND NC.Count lte 10>
	<img src="images/yellow.jpg"> (#NC.Count#)&nbsp;
	<cfelse>
	<img src="images/green.jpg"> (#NC.Count#)&nbsp;
	</cfif>
	</cfoutput>
</cfif>
	
</td>
</cfloop>
</tr>

<tr>
<td class="blog-content">
Efective Verification of Previous CARs
</td>

<cfloop from="2005" to="2007" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Effective">
SELECT * From Effective
WHERE ExternalLocation = '#URL.TP#' 
AND Year_ = #i#
</cfquery>

<cfif Effective.RecordCount eq 0>
N/A
<cfelse>

<cfset var=ArrayNew(1)>
<cfoutput query="Effective">
<CFSET var[1] = '#Effective1#'>
<CFSET var[2] = '#Effective2#'>
<CFSET var[3] = '#Effective3#'>
<CFSET var[4] = '#Effective4#'>
<CFSET var[5] = '#Effective5#'>
<CFSET var[6] = '#Effective6#'>
<CFSET var[7] = '#Effective7#'>
<CFSET var[8] = '#Effective8#'>
<CFSET var[9] = '#Effective9#'>
<CFSET var[10] = '#Effective10#'>
<CFSET var[11] = '#Effective11#'>
<CFSET var[12] = '#Effective12#'>
<CFSET var[13] = '#Effective13#'>
<CFSET var[14] = '#Effective14#'>
<CFSET var[15] = '#Effective15#'>
<CFSET var[16] = '#Effective16#'>
<CFSET var[17] = '#Effective17#'>
<CFSET var[18] = '#Effective18#'>
<CFSET var[19] = '#Effective19#'>
<CFSET var[20] = '#Effective20#'>
</cfoutput>

<cfset ecount = 0>
<cfloop index="n" from="1" to="20">
	<cfif var[n] is "No">
		<cfset ecount = ecount + 1>
	<cfelse>
		<cfset ecount = ecount>
	</cfif>
</cfloop>

<cfoutput>
<cfif ecount gt 0><img src="images/red.jpg"> (#ecount#)
<cfelse><img src="images/green.jpg"> (#ecount#)</cfif>
</cfoutput>
</cfif>

</td>
</cfloop>
</tr>

<tr>
<td class="blog-content">
CAR Responsiveness
</td>

<cfloop from="2005" to="2007" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Responsive">
SELECT * FROM OnTime
WHERE ExternalLocation = '#URL.TP#' 
AND Year_ = #i#
</cfquery>

<cfif Responsive.RecordCount eq 0>
N/A
<cfelse>

<cfif Responsive.OnTime is "Yes">
<img src="images/green.jpg">&nbsp;
<cfelseif Responsive.OnTime is "No">
<img src="images/red.jpg">&nbsp;
<cfelse>
No Data
</cfif>
</cfif>

</td>
</cfloop>
</tr>

<tr>
<td class="blog-content">
Quality System Implementation Effectiveness
</td>

<cfloop from="2005" to="2007" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Overall">
SELECT Overall From Overall
WHERE ExternalLocation = '#URL.TP#' 
AND Year_ = #i#
</cfquery>

<cfif Overall.RecordCount eq 0>
N/A
<cfelse>
<cfif Overall.Overall is "Yes">
<img src="images/green.jpg">&nbsp;
<cfelse>
<img src="images/red.jpg">&nbsp;
</cfif>
</cfif>

</td>
</cfloop>
</tr>

<tr><td colspan="4">&nbsp;</td></tr>

<cfoutput query="Responsive">
<cfif ontime is "Yes" or ontime is "">
<cfelse>
<tr><td colspan="4" class="blog-content">
<u>CAR Responsiveness Notes</u><br>
#Comments#
</td></tr>
</cfif>
</cfoutput>

<tr><td colspan="4" class="blog-content">
<u>Comments for Quarterly Report:</u><br>
<cfoutput query="Ex">
<cfif comments is "" or comments is "No Comments">
No Comments Provided.<br><br>
<cfelse>
#Comments#<br><br>
</cfif>
</cfoutput>
</td></tr>

<tr>
<td class="blog-content" valign="top" colspan="4">
Legend:<br><br>
<u>Repeat CARs</u><br>
<img src="images/green.jpg"> - 0<br>
<img src="images/red.jpg"> - greater than 0<br><br>

<u>Number of CARs Generated</u><br>
<img src="images/green.jpg"> - 0-7<br>
<img src="images/yellow.jpg"> - 8-10<br>
<img src="images/red.jpg"> - greater than 10<br><br>

<u>Effective Verification of Previous CARs</u><br>
<img src="images/green.jpg"> - All Previous CARs Verified<br>
<img src="images/red.jpg"> - Any Previous CARs Not Verified<br><br>

<u>CAR Responsiveness</u><br>
<img src="images/green.jpg"> - All Responses received within 30 days of Audit Report Date<br>
<img src="images/red.jpg"> - Any Response not received within 30 days of Audit Report Date<br><br>

<u>Quality System Implementation Effectiveness</u><br>
<img src="images/green.jpg"> - Yes<br>
<img src="images/red.jpg"> - No<br><br>

</td>
</tr>

</table>
</cfif>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->