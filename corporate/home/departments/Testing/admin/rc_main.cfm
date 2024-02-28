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
                          <td width="3%"></td> <td class="blog-date"><p align="center">Audit Database</p></td>
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
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-title"><p align="left"><br>
                              Third Party Report Card</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left" valign="top"><p align="left">					  
						  
<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="rc_main_comments.cfm">

<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset LastYear = #CurYear# - 1>
<cfset CurMonth = #Dateformat(now(), 'mm')#>

<cfif curmonth LESS THAN OR EQUAL TO 4 AND curmonth GREATER THAN OR EQUAL TO 2>
		<cfset n = 1>
<cfelseif curmonth LESS THAN OR EQUAL TO 7 AND curmonth GREATER THAN OR EQUAL TO 5>
		<cfset n = 2>
<cfelseif curmonth LESS THAN OR EQUAL TO 10 AND curmonth GREATER THAN OR EQUAL TO 8>
		<cfset n = 3>
<cfelseif curmonth eq 1>
		<cfset n = 4>
<cfelseif curmonth gte 11>
		<cfset n = 4>
</cfif>

<br>
<cfif curmonth eq 1>
<cfset yr = #lastyear#>
Year - #yr#
<cfelse>
<cfset yr = #curyear#>
Year - #yr#
</cfif><br>

<input type="hidden" name="year" value="#yr#">
<input type="hidden" name="quarter" value="#n#">
Quarter - #n#<br><br>

<CFQUERY Datasource="Corporate" Name="RC"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM RC_Comments
 WHERE YEAR_=#yr# AND  Quarter = #n#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>	

Add Comments to be sent to NACPO in Quarterly Third Party Report Card:<br>
<textarea WRAP="PHYSICAL" ROWS="6" COLS="60" NAME="Comments"><cfif rc.comments is ""><cfelse><cfset S1 = #ReplaceNoCase(rc.Comments,"<br>",chr(13), "ALL")#><cfset S2 = #ReplaceNoCase(S1,"&rsquo;", chr(39), "ALL")#><cfset S3 = #ReplaceNoCase(S2,"&quot;", chr(34), "ALL")#>#S3#</cfif></textarea><br><br>

<input name="submit" type="submit" value="Submit">
</form>
</cfoutput>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->