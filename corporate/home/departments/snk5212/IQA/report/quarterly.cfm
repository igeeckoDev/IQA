<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
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
                          <td width="3%"></td> <td class="blog-date" align="center">
						 Third Party Report Card<br><br>
						  <cfoutput>#URL.year# Quarter #url.quarter#</cfoutput>
						 </td>
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

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurMonth = #Dateformat(now(), 'mm')#>

<cfset var=ArrayNew(2)>
<cfset var[1][1] = 3>
<cfset var[2][1] = 6>
<cfset var[3][1] = 9>
<cfset var[4][1] = 12>
<cfset var[1][2] = "Q1">
<cfset var[2][2] = "Q2">
<cfset var[3][2] = "Q3">
<cfset var[4][2] = "Q4">

<cfloop from="1" to="4" index="i">
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Q#i#">
SELECT * FROM Check
<cfif url.quarter is 1>
WHERE month <= #var[i][1]#
<cfelseif url.quarter is 2>
WHERE month BETWEEN 4 and #var[i][1]#
<cfelseif url.quarter is 3>
WHERE month BETWEEN 7 and #var[i][1]#
<cfelseif url.quarter is 4>
WHERE month BETWEEN 10 and #var[i][1]#
</cfif>
and year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
ORDER BY Month, ID
</cfquery>
</cfloop>

<table><tr><td class="blog-content">
<CFQUERY Datasource="Corporate" Name="RC"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM RC_Comments
 WHERE YEAR_=#url.year# AND  Quarter = #url.quarter#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfoutput query="RC">
<cfif Comments is "">
<cfelse>
<b>Comments</b><br>
#Comments#<br><br>
</cfif>
</cfoutput>

<cfset holder = "">
<cfoutput query="Q#url.quarter#" group="ID">
<cfif status is "deleted">
<cfelse>
	<cfif Holder IS NOT Month> 
	<cfIf Holder is NOT ""><br></cfif>
	<b>#MonthAsString(Month)#</b><br>
	</cfif>
	<cfif report is NOT "Completed">
	<cfif Watch is 1>
	<font color="red">
	- #year#-#id# #externallocation# (No Report Filed)</font><br>
	<cfelse>
	- #year#-#id# #externallocation# (No Report Filed)<br>
	</cfif>
	<cfelse>
	<cfif Watch is 1>
	<font color="red">- #year#-#id# #externallocation# <a href="reportcard.cfm?TP=#ExternalLocation#">(View Report Card)</a></font><br>	
	<cfelse>
	- #year#-#id# #externallocation# <font color="blue"><a href="reportcard.cfm?TP=#ExternalLocation#">(View Report Card)</a></font><br>	
	</cfif>
	</cfif>
<cfset Holder = Month>
</cfif>
</cfoutput>
<br><br>

* As a result of findings generated, IQA will provide more focus on clients listed in red in next years audit.
</td></tr></table>

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