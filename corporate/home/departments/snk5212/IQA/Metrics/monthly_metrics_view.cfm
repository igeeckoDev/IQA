<!--- DV_CORP_002 02-APR-09 --->

<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Internal Quality Audits</title>
		<link href="../css.css" rel="stylesheet" media="screen">

<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style></head>

	<body leftmargin="0" marginheight="0" marginwidth="0" topmargin="0">
	<img border=0 height=53 src="/pagetempheader.gif" usemap=#FPMap0 width=756 align="top"> 
      <map name=FPMap0><area coords=0,41,89,52 
        href="http://#CGI.Server_Name#/" shape=RECT><area coords=94,40,226,52 
        href="http://#CGI.Server_Name#/deprtserv.htm" shape=RECT><area 
        coords=229,42,288,52 href="http://#CGI.Server_Name#/library.htm" 
        shape=RECT><area coords=290,40,353,52 
        href="http://#CGI.Server_Name#/toolkit/" shape=RECT><area 
        coords=451,41,560,52 href="http://#CGI.Server_Name#/employinfo.htm" 
        shape=RECT><area coords=564,37,664,52 
        href="http://#CGI.Server_Name#/cnsmrcrnr/" shape=RECT><area 
        coords=669,40,755,52 href="http://#CGI.Server_Name#/globalsites.htm" 
        shape=RECT><area coords=630,2,755,36 href="http://www.ul.com/" 
        shape=RECT><area coords=0,2,327,41 href="http://#CGI.Server_Name#/" 
        shape=RECT><area coords=396,6,442,14,431,30,396,33,358,25,360,14 
        href="http://#CGI.Server_Name#/help.htm" shape=POLY><area 
        coords=508,6,554,15,540,31,490,33,469,21,481,9 
        href="http://#CGI.Server_Name#/sitemap.htm" shape=POLY><area 
        coords=356,39,447,52 href="http://#CGI.Server_Name#/ee/" 
      shape=RECT></map> 
	
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
					<td class="table-masthead" align="right" valign="middle"><div align="center"><img src="../images/IQA2.jpg" width="317" height="34"></div></td>

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
                          <td width="3%"></td>
                          <td class="blog-date"><p align="center">Internal Quality 
                              Audits</p></td>
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
                          <td width="94%" align="left" class="blog-title"><p align="left"><br>
                              Audit Details</p><br></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>

<cfif CurMonth is 01>
	<cfset LastMonth = 12>
	<cfset Yr = #Curyear# - 1>
<cfelse>
	<cfset LastMonth = #CurMonth# - 1>
	<cfset Yr = #Curyear#>
</cfif>

<cfoutput>

<p><cfif LastMonth is 1>January's<cfelseif LastMonth is 2>February's<cfelseif LastMonth is 3>March's<cfelseif LastMonth is 4>April's<cfelseif LastMonth is 5>May's<cfelseif LastMonth is 6>June's<cfelseif LastMonth is 7>July's<cfelseif LastMonth is 8>August's<cfelseif LastMonth is 9>September's<cfelseif LastMonth is 10>October's<cfelseif LastMonth is 11>November's<cfelseif LastMonth is 12>December's<cfelse></cfif> Metrics</p>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" NAME="TotalTALastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start_2--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE (AuditType = 'Quality System,Technical Assessment' OR
AuditType = 'Quality System, Technical Assessment' OR
AuditType = 'Technical Assessment')
 AND  Month = #LastMonth#
 AND YEAR_='#Yr#' AND  approved = 'yes'
<!--- DV_CORP_002 02-APR-09 Change End_2 --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalQSLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start_2--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType LIKE '%Quality System%' AND  Month = #LastMonth#
 AND YEAR_='#Yr#' AND  approved = 'yes'
<!--- DV_CORP_002 02-APR-09 Change End_2 --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalTPTDPLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start_2--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType = 'TPTDP' 
 AND  Month = #LastMonth#
 AND YEAR_='#Yr#' AND  approved = 'yes'
<!--- DV_CORP_002 02-APR-09 Change End_2 --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CompletedQSLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start_2--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType LIKE '%Quality System%' AND  Month = #LastMonth#
 AND YEAR_='#Yr#' AND  Report IS NOT NULL
 AND  approved = 'yes'
<!--- DV_CORP_002 02-APR-09 Change End_2 --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CompletedTPTDPLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start_2--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType = 'TPTDP' 
 AND  Month = #LastMonth#
 AND YEAR_='#Yr#' AND  Report IS NOT NULL
 AND  approved = 'yes'
<!--- DV_CORP_002 02-APR-09 Change End_2 --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledTALastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start_2--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE (AuditType = 'Quality System,Technical Assessment' OR
AuditType = 'Quality System, Technical Assessment' OR
AuditType = 'Technical Assessment')
 AND  Month = #LastMonth#
 AND YEAR_='#Yr#' AND  Status = 'Deleted'
 AND  approved = 'yes'
<!--- DV_CORP_002 02-APR-09 Change End_2 --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledQSLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start_2--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType LIKE '%Quality System%' AND  Month = #LastMonth#
 AND YEAR_='#Yr#' AND  Status = 'Deleted'
 AND  approved = 'yes'
<!--- DV_CORP_002 02-APR-09 Change End_2 --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CancelledTPTDPLastMonth" Datasource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start_2--->


SELECT COUNT(*) as Count
 FROM AuditSchedule
 WHERE AuditType = 'TPTDP'
 AND  Month = #LastMonth#
 AND YEAR_='#Yr#' AND  Status = 'Deleted'
 AND  approved = 'yes'
<!--- DV_CORP_002 02-APR-09 Change End_2 --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="CompletedTALastMonth" Datasource="Corporate">
Select (#TotalTALastMonth.Count#-#CancelledTALastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalAuditsScheduled" Datasource="Corporate">
Select (#TotalTALastMonth.Count#+#TotalQSLastMonth.Count#+#TotalTPTDPLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalAuditsCompleted" Datasource="Corporate">
Select (#CompletedTALastMonth.Count#+#CompletedQSLastMonth.Count#+#CompletedTPTDPLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalAuditsCancelled" Datasource="Corporate">
Select (#CancelledTALastMonth.Count#+#CancelledQSLastMonth.Count#+#CancelledTPTDPLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="TotalOutstanding" Datasource="Corporate">
Select (#TotalAuditsScheduled.Count#-#TotalAuditsCompleted.Count#-#TotalAuditsCancelled.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OutstandingTPTDPLastMonth" Datasource="Corporate">
Select (#TotalTPTDPLastMonth.Count#-#CompletedTPTDPLastMonth.Count#-#CancelledTPTDPLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OutstandingQSLastMonth" Datasource="Corporate">
Select (#TotalQSLastMonth.Count#-#CompletedQSLastMonth.Count#-#CancelledQSLastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="OutstandingTALastMonth" Datasource="Corporate">
Select (#TotalTALastMonth.Count#-#CompletedTALastMonth.Count#-#CancelledTALastMonth.Count#) as Count From AuditSchedule
</cfquery>

<CFOUTPUT>
<u>Total Audits Scheduled: <B>#TotalAuditsScheduled.Count#</B></u>
</CFOUTPUT>
<br>
<CFOUTPUT>
Third Party Audits: <B>#TotalTPTDPLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Quality System Audits: <B>#TotalQSLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Technical Assessment Audits: <B>#TotalTALastMonth.Count#</B>
</CFOUTPUT>
<br><br><br>

<CFOUTPUT>
<u>Total Audits Completed: <B>#TotalAuditsCompleted.Count#</B></u>
</CFOUTPUT>
<br>
<CFOUTPUT>
Third Party Audits: <B>#CompletedTPTDPLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Quality System Audits: <B>#CompletedQSLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Technical Assessment Audits: <B>#CompletedTALastMonth.Count#</B>
</CFOUTPUT>
<br><br>
<CFOUTPUT>
<u>Cancelled Audits</u>: <B>#TotalAuditsCancelled.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Third Party Audits: <B>#CancelledTPTDPLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Quality System Audits: <B>#CancelledQSLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Technical Assessment Audits: <B>#CancelledTALastMonth.Count#</B>
</CFOUTPUT>
<br><br>
<CFOUTPUT>
<u>Outstanding Audits</u>: <B>#TotalOutstanding.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Third Party Audits: <B>#OutstandingTPTDPLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Quality System Audits: <B>#OutstandingQSLastMonth.Count#</B>
</CFOUTPUT>
<br>
<CFOUTPUT>
Technical Assessment Audits: <B>#OutstandingTALastMonth.Count#</B>
</CFOUTPUT>						  
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
				  <p align="center"><font color=#808080 face=Arial size=1><a 
            href="http://#CGI.Server_Name#/"><font face="Arial, Helvetica, sans-serif"><br>
			      UL Net Home</font></a><font face="Arial, Helvetica, sans-serif"> - <a 
            href="http://#CGI.Server_Name#/deprtserv.htm">Departments &amp; Services</a> - <a 
            href="http://#CGI.Server_Name#/library.htm">Library</a> - <a 
            href="http://#CGI.Server_Name#/toolkit/">GBS</a> - <a 
            href="http://#CGI.Server_Name#/ee/">Electronic Eye</a> - <a 
            href="http://#CGI.Server_Name#/employinfo.htm">Employee Info Center</a> - <a href="http://#CGI.Server_Name#/cnsmrcrnr/">Consumer Corner</a> -&nbsp; <a 
            href="http://#CGI.Server_Name#/globalsites.htm">Global UL Sites</a></font></font> </p>
		          <p align=center><font face="Arial, Helvetica, sans-serif" size="1">The UL Net is a resource designed to assist you and other UL employees worldwide. We welcome and encourage your feedback. For questions or updates regarding IQA web content, please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Christopher J. Nicastro</a>. Please direct any questions, comments, suggestions or problems with this site&nbsp; to the <a href="http://#CGI.Server_Name#/help.htm">UL NET TEAM</a>. Copyright &copy; 2004 Underwriters Laboratories Inc.&reg; All rights reserved.</font>                   
		          <p align=center><br>			      
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

