<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>
		
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>
</head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<!-- Begin UL Net Header -->
<cfoutput><SCRIPT language=JavaScript src="#Request.header#"></script></cfoutput>
<!-- End UL Net Header--> 
	
		<div align="left">
			<table width="756" border="0" cellpadding="0" cellspacing="0" bgcolor="#cecece" class="table-main">
			<tr>
			<td>
			<div align="center">
			<table class="table-main" width="675" border="0" cellspacing="0" cellpadding="0" bgcolor="#cecece">
				<tr>
					<td class="table-bookend-top">&nbsp;</td>
				</tr>
				<tr>
					<td class="table-masthead" align="right" valign="middle"><div align="center">&nbsp;</div></td>

				</tr>
				<tr>
					
              <td class="table-menu" valign="top"><div align="center">&nbsp;</div></td>
				</tr>
				<tr>

					
              <td height="925" class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td height="927" valign="top" class="content-column-left"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%"></td> <td class="blog-date"><p align="center">Third Party Report Card</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  	
                          </td>
                          <td></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-title"><p align="left">&nbsp;</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left" valign="top"><p align="left">

<cfoutput>
<cfset CurYear = 2007>
<cfset LastYear = #CurYear# - 1>	
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Ex">
SELECT * FROM ExternalLocation
WHERE ExternalLocation.ExternalLocation = '#URL.TP#'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT * FROM Check
WHERE ExternalLocation.ExternalLocation = '#URL.TP#'
AND Auditschedule.Report = 'Completed'
</cfquery>

<cfif Check.recordcount is 0>
<p class="blog-content">There are no Audit Reports recorded, the Report Card is not available.</p>
<cfelse>

<table border="1">
<tr>
<td class="blog-content">
<cfoutput><b>#URL.TP#</b>
</td>
<td class="blog-content" valign="top" align="center">#LastYear#</td>
<td class="blog-content" valign="top" align="center">#CurYear#</cfoutput></td>
</tr>

<tr>
<td class="blog-content">
Repeat CARs
</td>

<cfloop from="#LastYear#" to="#CurYear#" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check2">
SELECT * FROM RepeatCARs
WHERE ExternalLocation = '#URL.TP#'
AND Year = #i#
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
	<img src="../images/red.jpg"> (#rcount#)&nbsp;
	<cfelse>
	<img src="../images/green.jpg"> (#rcount#) &nbsp;
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

<cfloop from="#LastYear#" to="#CurYear#" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="NC">
SELECT (TPReport.Count1+TPReport.Count2+TPReport.Count3+TPReport.Count4+TPReport.Count5+TPReport.Count6+TPReport.Count7+TPReport.Count8+TPReport.Count9+TPReport.Count10+TPReport.Count11+TPReport.Count12+TPReport.Count13+TPReport.Count14+TPReport.Count15+TPReport.Count16+TPReport.Count17+TPReport.Count18+TPReport.Count19+TPReport.Count20+TPReport.Count21+TPReport.Count22+TPReport.Count23+TPReport.Count24+TPReport.Count25+TPReport.CountOther+TPReport.OCount1+TPReport.OCount2+TPReport.OCount3+TPReport.OCount4+TPReport.OCount5+TPReport.OCount6+TPReport.OCount7+TPReport.OCount8+TPReport.OCount9+TPReport.OCount10+TPReport.OCount11+TPReport.OCount12+TPReport.OCount13+TPReport.OCount14+TPReport.OCount15+TPReport.OCount16+TPReport.OCount17+TPReport.OCount18+TPReport.OCount19+TPReport.OCount20+TPReport.OCount21+TPReport.OCount22+TPReport.OCount23+TPReport.OCount24+TPReport.OCount25+TPReport.OCountOther) 
as Count FROM Nonconformances
WHERE ExternalLocation = '#URL.TP#' 
AND TPReport.Year = #i#
</cfquery>

<cfif NC.RecordCount eq 0>
N/A
<cfelse>
	<cfoutput>
	<cfif NC.Count gt 10>
	<img src="../images/red.jpg"> (#NC.Count#)&nbsp;
	<cfelseif NC.Count gte 8 AND NC.Count lte 10>
	<img src="../images/yellow.jpg"> (#NC.Count#)&nbsp;
	<cfelse>
	<img src="../images/green.jpg"> (#NC.Count#)&nbsp;
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

<cfloop from="#LastYear#" to="#CurYear#" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Effective">
SELECT * From Effective
WHERE ExternalLocation = '#URL.TP#' 
AND Year = #i#
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
<cfif ecount gt 0><img src="../images/red.jpg"> (#ecount#)
<cfelse><img src="../images/green.jpg"> (#ecount#)</cfif>
</cfoutput>
</cfif>

</td>
</cfloop>
</tr>

<tr>
<td class="blog-content">
CAR Responsiveness
</td>

<cfloop from="#LastYear#" to="#CurYear#" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Responsive">
SELECT * FROM OnTime
WHERE ExternalLocation = '#URL.TP#' AND Year = #i#
</cfquery>

<cfif Responsive.RecordCount eq 0>
N/A
<cfelse>

<cfif Responsive.OnTime is "Yes">
<img src="../images/green.jpg">&nbsp;
<cfelseif Responsive.OnTime is "No">
<img src="../images/red.jpg">&nbsp;
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

<cfloop from="#LastYear#" to="#CurYear#" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Overall">
SELECT Overall From Overall
WHERE ExternalLocation = '#URL.TP#' AND Year = #i#
</cfquery>

<cfif Overall.RecordCount eq 0>
N/A
<cfelse>
<cfif Overall.Overall is "Yes">
<img src="../images/green.jpg">&nbsp;
<cfelse>
<img src="../images/red.jpg">&nbsp;
</cfif>
</cfif>

</td>
</cfloop>
</tr>

<script language="JavaScript">
<!-- Begin
function popUp2(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=450,height=175,left = 200,top = 200');");
}
-->
</script>

<tr>
<td class="blog-content">
Projects Submitted (Since Previous GALO)<br>
<A HREF="javascript:popUp2('tpreport_note.cfm')">[Criteria]</A>
</td>

<cfloop from="#LastYear#" to="#CurYear#" index="i">
<td class="blog-content" valign="top" align="center">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Projects">
SELECT * From Projects
WHERE ExternalLocation = '#URL.TP#' AND Year = #i#
</cfquery>

<cfif Projects.RecordCount eq 0>
N/A
<cfelseif i is "2005" or i is "2006">
N/A
<cfelse>
<cfif Projects.ProjectsCompleted is 0>
<img src="../images/red.jpg"> <cfoutput>(#Projects.ProjectsCompleted#)</cfoutput>&nbsp;
<cfelse>
<img src="../images/green.jpg"> <cfoutput>(#Projects.ProjectsCompleted#)</cfoutput>&nbsp;
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
<img src="../images/green.jpg"> - 0<br>
<img src="../images/red.jpg"> - greater than 0<br><br>

<u>Number of CARs Generated</u><br>
<img src="../images/green.jpg"> - 0-7<br>
<img src="../images/yellow.jpg"> - 8-10<br>
<img src="../images/red.jpg"> - greater than 10<br><br>

<u>Effective Verification of Previous CARs</u><br>
<img src="../images/green.jpg"> - All Previous CARs Verified<br>
<img src="../images/red.jpg"> - Any Previous CARs Not Verified<br><br>

<u>CAR Responsiveness</u><br>
<img src="../images/green.jpg"> - All Responses received within 30 days of Audit Report Date<br>
<img src="../images/red.jpg"> - Any Response not received within 30 days of Audit Report Date<br><br>

<u>Quality System Implementation Effectiveness</u><br>
<img src="../images/green.jpg"> - Yes<br>
<img src="../images/red.jpg"> - No<br><br>

<u>Number of Projects Completed Since Previous GALO</u><br>
<img src="../images/green.jpg"> - greater than 0<br>
<img src="../images/red.jpg"> - 0<br><br>

</td>
</tr>

</table>
</cfif>
						  
 <br>
                            </p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%">&nbsp;</td>
                          <td>&nbsp;</td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right"><a href="#"><img src="../images/top.gif" alt="" height="7" width="5" border="0"></a></td>
                        </tr>
                      </table>
                      <br> 
                      
                      
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      
					  <table width="100%">
                        <tr><td width="70%">&nbsp;</td>
					  <td width="30%" align="left">

						</td>
						</tr></table>
                      
                    </td>
                    <td class="horizontalbar">&nbsp;</td>
                    <td class="content-column-right" valign="top">&nbsp;</td>
                  </tr>
                </table></td>
				</tr>
				<tr>
				  <td class="table-bookend-bottom-footer" valign="top">
				  <div class="box-header">&nbsp;</div>
				</td>
				  </tr>
				  <tr>				  
<td class="table-bookend-bottom-footer">
<cfinclude template="../footer.cfm">            
</td>
			  </tr>
				<tr>
				  <td class="table-bookend-bottom">&nbsp;</td>
			  </tr>
				<tr>
					<td></td>

				</tr>
			</table>
			</div>
			</td></tr></table>
		
</div>
	</body>

</html>