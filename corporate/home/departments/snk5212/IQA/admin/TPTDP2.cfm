<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDPList">
SELECT * FROM ExternalLocation
WHERE ExternalLocation <> '- None -'
ORDER BY Status DESC, ExternalLocation
</CFQUERY>

<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPType">
SELECT * FROM ThirdPartyTypes
ORDER BY TPType
</CFQUERY>

<cfoutput>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
</cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<title>Audit Database</title>
<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>
		
		

<script language="JavaScript">
function validateForm()
{
	// check name
     if (document.Form.ExternalLocation.value == '') {
          alert("Please provide the TPTDP name.");
          return false;
     }
	 
     if (document.Form.TPType.value == '') {
          alert("Please provide the Third Party Participant type.");
          return false;
     }
	 
	 if (document.Form.Certificate.value == '' & document.Form.Cert.value !== '') {
          alert("Please enter a Certificate Number.");
          return false;
     } 	
	 
	 if (document.Form.Certificate.value !== '' & document.Form.Cert.value == '') {
          alert("Please attach a Certificate file.");
          return false;
     }	 

    return true;
}		
</script>
		
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
						  
							<cfinclude template="adminMenu.cfm">
							
							</td>
                          <td></td>
                          <td></td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right">&nbsp;</td>
                        </tr>
                      </table>
                      <br>
                      <table width="100%" height="400" border="0" cellpadding="0" cellspacing="0">
                        <tr> 
                          <td width="4%" height="20" align="right"> <p>&nbsp;</p></td>
                          <td colspan="2" align="left" class="blog-title"><p align="left">TPTDP Locations</p></td>
                        </tr>
	  
                        <tr> 
                          <td></td>
                          <td width="92%" align="left" class="blog-content">
						  <br><br>
						  <b>Current list of TPTDP locations:</b><br>
						  - <a href="TPTDP_add.cfm">Add Location</a>
						  <br><br>
						  <B>Third Party Report Card View</B><br>
						  <cfoutput>
- <a href="../report/report.cfm?Year=#CurYear#">View Report Card</a> (NACPO View)<br>
- <a href="rc_main.cfm">Add Third Party Report Card Quarterly Comments</a><br><br>
- Please add commments for each individual Third Party's Report Card by selected 'Report Card' below in the client's profile.<br>
						  </cfoutput>
						  <br><br>
						  <table border="1">
						  <tr>
						  <td class="blog-title">Third Party Name</td>
						  <td class="blog-title">Location</td>
						  <td class="blog-title">Participant Type</td>
						  </tr>
						  <CFOUTPUT query="TPTDPList">
						  <tr>
						  <td class="blog-content">
<b>#ExternalLocation#</b> <cfif Status is 0><font color="red">(Inactive)</font></cfif><br>

<CFSET Key = "#cjn_key#">
<CFSET QS = "#ExternalLocation#">
<cfset enc = encrypt(QS, key)>

 - <a href="TP_Audit_Coverage2.cfm?ExternalLocation=#enc#">(Audit Coverage)</a><br>

<cfif Type is "CAP-EA/AA" or Type is "CAP-AA">
 - <a href="TP_AA_Audit_Coverage.cfm?ExternalLocation=#enc#">(CAP AA Coverage)</a><br>
</cfif>

 - <a href="reportcard.cfm?TP=#enc#">(Report Card)</a><br>

 - <a href="TPTDP_View.cfm?ID=#ID#">(View)</a><br>

 - <a href="TPTDP_Edit.cfm?ID=#ID#">(Edit)</a><br>

<cfif Cert is "Yes">
 - <a href="../certs/#Certificate#.pdf">(Certificate)</a>
</cfif> 



						  </td>
						  <td class="blog-content" valign="top">
						  #Location#<br>
						  </td>
						  <td class="blog-content" valign="top">
						  <cfif Trim(Type) is ""><Cfelse>#Type#</cfif>
						  </td>
						  </tr>
						  </CFOUTPUT>
						  </table>				  
						  </td>
                          <td width="4%"></td>
                        </tr>

						
                        <tr> 
                          <td height="123">&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr> 
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr> 
                          <td class="article-end" colspan="3" align="right"><a href="#"><img src="../images/top.gif" alt="" height="7" width="5" border="0"></a></td>
                        </tr>
                      </table> 
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
                      <p>&nbsp;</p>
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

