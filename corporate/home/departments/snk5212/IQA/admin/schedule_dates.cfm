<cfoutput>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset NextYear = #CurYear# + 1>
<cfset LastYear = #CurYear# - 1>				
</cfoutput>			
						  
<CFQUERY NAME="Month" Datasource="Corporate">
SELECT * From Month
ORDER By alphaID
</CFQUERY>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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

					
              <td class="table-content"> <table width="100%" height="" border="0" cellpadding="0" cellspacing="0">
                  <tr> 
                    <td valign="top" class="content-column-left"> 
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-date"><p align="center">Audit Database</p></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="table-menu" valign="top">
						  
							<cfinclude template="adminmenu.cfm">
							
							</td>
                          <td></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                          <td width="4%" height="20" align="right"> <p>&nbsp;</p></td>
                          <td colspan="2" align="left" class="blog-title">

<table border="0" width="100%">
<Tr>
<td align="left" class="blog-title" valign="top" width="60%">						  
<cfoutput>

<cflock scope="SESSION" timeout="60">
<cfif URL.Year is LastYear>
<p align="left">#URL.AuditedBy#<cfif SESSION.Auth.accesslevel is "IQAAuditor">/#SESSION.AUTH.Name#</cfif> Audit Schedule <br> #LastYear# <a href="schedule.cfm?Year=#CurYear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #CurYear# ]</a> <a href="schedule.cfm?Year=#NextYear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is CurYear>
<p align="left">#URL.AuditedBy#<cfif SESSION.Auth.accesslevel is "IQAAuditor">/#SESSION.AUTH.Name#</cfif> Audit Schedule <br> <a href="schedule.cfm?Year=#LastYear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #LastYear# ]</a> #CurYear# <a href="schedule.cfm?Year=#NextYear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #NextYear# ]</a><br><br>
<cfelseif URL.Year is NextYear>
<p align="left">#URL.AuditedBy#<cfif SESSION.Auth.accesslevel is "IQAAuditor">/#SESSION.AUTH.Name#</cfif> Audit Schedule <br> <a href="schedule.cfm?Year=#LastYear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #LastYear# ]</a> <a href="schedule.cfm?Year=#CurYear#&AuditedBy=#URL.AuditedBy#&Auditor=All">[ #CurYear# ]</a> #NextYear# <br><br>
<cfelse>
</cfif>
</cflock>

<a href="schedule.cfm?Year=#CurYear#&AuditedBy=IQA&Auditor=All">View</a> IQA Audit Schedule<br>
<a href="schedule_view.cfm">View</a> Regional Audit Schedules<br>
<a href="schedule.cfm?Year=#CurYear#&AuditedBy=AS&Auditor=All">View</a> Accreditation Audit Schedule<br>
<a href="schedule.cfm?Year=#CurYear#&AuditedBy=QRS&Auditor=All">View</a> QRS Schedule<br><br>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "Admin" or SESSION.Auth.accesslevel is "SU">
<a href="addaudit.cfm?AuditedBy=IQA">Add an IQA audit</a><br>
<a href="select_region.cfm">Add a Regional Audit</a><br>
<a href="AS_AddAudit.cfm">Add an Accreditation Audit</a><br>
<a href="QRS_AddAudit.cfm">Add a QRS Audit</a>
<cfelseif SESSION.Auth.accesslevel is "IQAAuditor">
<a href="addaudit.cfm?AuditedBy=IQA">Add an IQA audit</a><br>
<cfelseif SESSION.Auth.accesslevel is "RQM" or SESSION.Auth.accesslevel is "OQM">
<a href="addaudit.cfm?AuditedBy=#SESSION.Auth.SubRegion#">Add an audit for your Region</a>
<cfelseif SESSION.Auth.accesslevel is "Europe" or SESSION.Auth.accesslevel is "Asia Pacific">
<a href="select_region.cfm">Add a Regional Audit</a>
<cfelseif SESSION.Auth.accesslevel is "AS">
<a href="AS_AddAudit.cfm">Add an Accreditation Audit</a>
<cfelseif SESSION.Auth.accesslevel is "QRS">
<a href="QRS_AddAudit.cfm">Add a QRS Audit</a>
<cfelse>
</cfif>
</cflock><br><br>

</cfoutput>

Scroll to a specific month:<br>
<SELECT NAME="Month" ONCHANGE="location = this.options[this.selectedIndex].value;">
<CFOUTPUT QUERY="Month">
		<OPTION VALUE="###ID#">#Month#
</CFOUTPUT>
</SELECT><br><br>

</td>
<td align="left" class="blog-content" valign="top" width="40%">
<p><b>Legend:</b><br>
<img src="../images/red.jpg" border="0"> - Audit Rescheduled<br>
<img src="../images/yellow.jpg" border="0"> - Audit Scheduled<br>
<cfif url.auditedby is "QRS" or url.auditedby is "AS">
<img src="../images/green.jpg" border="0"> - Audit Completed<br>
<cfelse>
<img src="../images/green.jpg" border="0"> - Audit Completed, Report Submitted<br>
<img src="../images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
</cfif>
<img src="../images/black.jpg" border="0"> - Audit Cancelled Without Reschedule<br>
</p>
</td>  
</TR>
</table>				
		</td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="sched-content">	  
						
<CFQUERY BLOCKFACTOR="100" NAME="Total" Datasource="Corporate">
SELECT * from AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Approved = 'Yes'
AND AuditedBy = '#URL.AuditedBy#'
ORDER BY ID
</cfquery>	

<cfif Total.Recordcount eq 0>
<cfoutput>
<table border="1" width="650" valign="Top">
<tr>
<td class="blog-content">
There are no audits currently scheduled by #URL.AuditedBy# for #URL.Year#.</cfoutput>
</td>
</tr></table>
<cfelse>

<cfloop index="i" From="1" To="12">
<table border="1" width="650">
<tr>

<cflock scope="SESSION" timeout="60">
<CFQUERY BLOCKFACTOR="100" NAME="Blah" Datasource="Corporate">
SELECT * from AuditSchedule
WHERE Month = #i#
AND Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Approved = 'Yes'
<CFIF SESSION.Auth.accesslevel is "IQAAuditor">
<cfoutput>
<cfif url.auditor is "All">
<cfelse>
AND (Auditor LIKE '%#URL.Auditor#%'
OR LeadAuditor LIKE '%#URL.Auditor#%')
</cfif>
</cfoutput>
<cfelse>
AND AuditedBy = '#URL.AuditedBy#'
</cfif>
ORDER BY StartDate
</cfquery>
</cflock>

<CFPROCESSINGDIRECTIVE SUPPRESSWHITESPACE="Yes">

<cfif Blah.Recordcount eq 0>
<cfoutput>
There are no audits currently scheduled by #URL.AuditedBy# for #i#/#URL.Year#.
</cfoutput>

<cfelse>

<cfif url.auditedby is "AS" or url.auditedby is "QRS">

<cfinclude template="OutputQuery_AS.cfm">

<cfelse>

<cfinclude template="OutputQuery.cfm">

</cfif>

</cfif>

</CFPROCESSINGDIRECTIVE>

</tr>
<tr> 
	<td class="article-end" colspan="4" align="right"><br><p class="blog-content"><a href="#">Top <img src="images/top.gif" alt="" height="7" width="5" border="0"></a></p></td>
</tr>
</table><br><br>
</cfloop> 
</cfif>						
						</td></tr>
					  
						  </td>
                          <td width="4%"></td>
                        </tr>
				<tr> 
                  <td width="4%" height="20" align="right"> <p>&nbsp;</p></td>
                  <td colspan="2" align="left" class="sched-content">
							  <p><b>Legend:</b><br>
<img src="../images/red.jpg" border="0"> - Audit Rescheduled<br>
<img src="../images/yellow.jpg" border="0"> - Audit Scheduled<br>
<img src="../images/green.jpg" border="0"> - Audit Completed, Report Submitted<br>
<img src="../images/blue.jpg" border="0"> - Audit Completed, Awaiting Report<br>
<img src="../images/black.jpg" border="0"> - Audit Cancelled Without Reschedule<br>
							  </p>
					</td>
            </tr>	
						
                      </table> 

                      
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

