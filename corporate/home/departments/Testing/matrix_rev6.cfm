<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Standard Categories Matrix</title>
<cfoutput>	
<link href="#REQUEST.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#REQUEST.ULNetCSS#" />
</cfoutput>
	
</head>

<body>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM Clauses_2010SEPT1
ORDER BY ID
</cfquery>

<table border="1" valign="top">
<tr>
<td class="blog-content" valign="top" align="left" colspan="7">
The matrix groups document clauses into main headings for use with the Audit Coverage section of Audit Report. The documents are ISO/IEC 17025:2005, ISO/IEC 17020:1998, ISO/IEC Guide 65:1996, ISO/IEC Guide 17021:2011, ISO 9001:2008 and Additional requirement as per CAN-P-1500M.<br><br>

<cfoutput>
(Current Revision: 6, April 4, 2011 :: <a href="#IQARootDir#matrix_revhistory.cfm">View</a> History)<br><br>
</cfoutput>

The Standard Categories Matrix usage:<Br>
1/1/2008 - IQA Audit Coverage in Audit Report<br>
10/1/2008 - IQA Audit Report Non-Conformances<Br>
1/1/2009 - CAR Database "Function" field<br>
10/19/2009 - CAR Database "Function" field name changed to "Standard Category"
</td>
</tr>
<tr>
<td class="blog-title" valign="top" align="center">Title (Standard Categories)</td>
<td class="blog-title" valign="top" align="center">ISO 17025:2005</td>
<td class="blog-title" valign="top" align="center">ISO 65:1996</td>
<td class="blog-title" valign="top" align="center">Additional Requirements<br>per CAN-P-1500M</td>
<td class="blog-title" valign="top" align="center">ISO 17020:2004</td>
<td class="blog-title" valign="top" align="center">ISO 17021:2011</td>
<td class="blog-title" valign="top" align="center">ISO 9001:2008</td>
</tr>
<cfoutput query="Clauses">
<tr>
<td class="blog-title" valign="top">#title#</td>
<td class="blog-content" valign="top">
<cfset Dump1 = #replace(ISO_17025_2005, ", Clause ", "<br>", "All")#>
<cfset Dump2 = #replace(Dump1, "Clause ", "", "All")#>
#Dump2#</td>
<td class="blog-content" valign="top">
<cfset Dump1 = #replace(ISO_65_1996, ", Clause ", "<br>", "All")#>
<cfset Dump2 = #replace(Dump1, "Clause ", "", "All")#>
#Dump2#</td>
<td class="blog-content" valign="top">
<cfset Dump1 = #replace(CAN_P_1500M, ", Clause ", "<br>", "All")#>
<cfset Dump2 = #replace(Dump1, "Clause ", "", "All")#>
#Dump2#</td>
<td class="blog-content" valign="top">
<cfset Dump1 = #replace(ISO_17020_1998, ", Clause ", "<br>", "All")#>
<cfset Dump2 = #replace(Dump1, "Clause ", "", "All")#>
#Dump2#</td>
<td class="blog-content" valign="top">
<cfset Dump1 = #replace(ISO_17021_2011, ", Clause ", "<br>", "All")#>
<cfset Dump2 = #replace(Dump1, "Clause ", "", "All")#>
#Dump2#</td>
<td class="blog-content" valign="top">
<cfset Dump1 = #replace(ISO_9001_2000, ", Clause ", "<br>", "All")#>
<cfset Dump2 = #replace(Dump1, "Clause ", "", "All")#>
#Dump2#</td>
</tr>
</cfoutput>
</table>

</body>
</html>
