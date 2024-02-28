<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
SELECT * FROM KP_Report
ORDER BY Alpha
</cfquery>			

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

<table width="756" border="0" cellspacing="0" 
<tr>
<td width="3%"></td>
<td class="blog-content" align="left"><p align="left">
						  
<b><u>General Information and New CARs</u></b><br>
<b>Audit Report Number</b><br>
Year-ID<br><br>

<b>Location</b><br>
Location<br>
Audit Area: Audit Area<br><br>

<b>Audit Date(s)</b><br>
Audit Dates(s)<br><br>

<b>Report Date</b><br>
<input type="text"><br><br>

<b>Auditors</b><br>
Lead Auditor<br>
Auditor<br><br>

<b>Audit Type</b><br>
Type of Audit<br><br>

<b>Key Contact</b><br>
<input type="text"><br><br>

<b>Key Contact Email</b><br>
<input type="text"><br><br>

<b>Summary</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="" Value=""></textarea>
<br><br>
					  
						  
<cfset var=ArrayNew(1)>

<CFSET var[1] = 'Contracts'>
<CFSET var[2] = 'Control of Customer Property and Samples'>
<CFSET var[3] = 'Corrective and Preventive Action'>
<CFSET var[4] = 'Document Control'>
<CFSET var[5] = 'HR and Personnel'>
<CFSET var[6] = 'Inspection Program'>
<CFSET var[7] = 'Internal Quality Audits'>
<CFSET var[8] = 'Laboratory'>
<CFSET var[9] = 'Management Review'>
<CFSET var[10] = 'Nonconforming Test or Product'>
<CFSET var[11] = 'Program Specific'>
<CFSET var[12] = 'Purchasing'>
<CFSET var[13] = 'Quality System'>
<CFSET var[14] = 'Records'>
<CFSET var[15] = 'Subcontracting'>
<CFSET var[16] = 'Training and Competency'> 
<CFSET var[17] = 'Other'> 

<b>Nonconformances</b><br>
Include the number of nonconformances and associated CAR numbers below.<br>
* Separate CAR numbers with a comma<br><br>
<table border="1">
<tr>
<td class="blog-title">Key Processes</td>
<td class="blog-title">Number</td>
<td class="blog-title" align="Center">CAR Number(s)*</td>
</tr>
<CFloop index="i" from="1" to="17">
<cfoutput>
<tr>
<td class="blog-content" valign="top">#var[i]#</td>
<td class="blog-content"  valign="top" align="center">&nbsp;</td>
<Td class="blog-content" align="center">&nbsp;</td>
</tr>
</cfoutput>
</CFloop>
</table><br>		
		
<b>Positive Observations or Best Practices</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="" Value=""></textarea>
<br><br>

</p></td>
</tr>
			</table>
			</div>
	</body>
</html>

