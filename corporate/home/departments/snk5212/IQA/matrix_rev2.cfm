<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
<cfoutput>
<link href="#REQUEST.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#REQUEST.ULNetCSS#" />
</cfoutput>

</head>

<body>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM Clauses
ORDER BY ID
</cfquery>

<table border="1" valign="top">
<tr>
<td class="blog-content" valign="top" align="left" colspan="6">
The matrix groups document clauses into main headings for use with the Audit Coverage section of Audit Report, as well as an office-specific yearly audit coverage matrix. The documents are ISO/IEC 17025:2005, ISO/IEC 17020:1998, ISO/IEC Guide 65:1996, ISO/IEC Guide 62:1996, ISO 9001:2000.<br><br>

<b><font color="red">THIS IS NOT THE CURRENT VERSION</font></b><br><br>

</td>
</tr>
<tr>
<td class="blog-title" valign="top" align="center">Title (Standard Categories)</td>
<td class="blog-title" valign="top" align="center">ISO 17025 2005</td>
<td class="blog-title" valign="top" align="center">ISO 65 1996</td>
<td class="blog-title" valign="top" align="center">ISO 17020 1998</td>
<td class="blog-title" valign="top" align="center">ISO 62 1996</td>
<td class="blog-title" valign="top" align="center">ISO 9001 2000</td>
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
<cfset Dump1 = #replace(ISO_17020_1998, ", Clause ", "<br>", "All")#>
<cfset Dump2 = #replace(Dump1, "Clause ", "", "All")#>
#Dump2#</td>
<td class="blog-content" valign="top">
<cfset Dump1 = #replace(ISO_62_1996, ", Clause ", "<br>", "All")#>
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

