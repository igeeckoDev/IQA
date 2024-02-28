<cfset Self = GetFileFromPath(cgi.CF_TEMPLATE_PATH)>
<cfset DirToList = "#request.applicationFolder#\corporate\home\departments\snk5212\IQA\Auditors\#Profile.ID#\">
<cfset UpOneDir = ListDeleteAt(DirToList, ListLen(DirToList, "\"), "\") & "\" & self>
<cfdirectory action="list" directory="#DirToList#" name="DirListing">
<html>
<head>
<cfoutput>
<title>Directory Listing #DirToList#</title>
<link href="#Request.CSS#" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="#Request.ULNetCSS#" />
</cfoutput>

	<style type="text/css">
		body		{ font-family: verdana; font-size: 9pt; }
		td			{ font-size: 9pt; color: #999999; border-bottom: #EEEEEE; }
		th			{ font-size: 9pt; background-color: #EEEEEE; }
		tr.alt		{ background-color: #EEEEEE; }
		tr.main		{ background-color: #FFFFFF; }
		table		{ border: #EEEEEE; padding: 0px; margin: 0px; }
	</style>
</head>

<body>
<table width="98%" align="center">
	<tr>
		<th>File Name</th>
		<th>File Size</th>
		<th>Date Last Modified</th>
		<th>&nbsp;</th>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<cfoutput query="DirListing">
		<cfset useclass = "alt">
		<cfif CurrentRow mod 2>
			<cfset useclass = "main">
		</cfif>
		<cfif name NEQ "directory_listing.cfm" AND name NEQ "thumbs.db">
		<tr class="#useclass#">
			<td><a href="../Auditors/#Profile.ID#/#name#">#name#</a></td>
			<td align="right">
				<cfif size neq 0>
					<cfset SizeKb = size / 1024>
					<cfif SizeKb gt 1024>
						<cfset SizeMb = SizeKb / 1024>
						#NumberFormat(SizeMb, "99.99")# <strong>MB</strong>
					<cfelse>
						#NumberFormat(SizeKb, "99.99")# KB
					</cfif>
				<cfelse>
					0.00 KB
				</cfif>
			</td>
			<td align="right">
				<cfif isDate(datelastmodified)>
					#DateFormat(datelastmodified, "mm/dd/yyyy")# #TimeFormat(datelastmodified, "hh:mm:ss TT")#
				<cfelse>
					Unknown
				</cfif>
			</td>
			<td align="center">
				<cfif type eq "dir">
					&lt; dir &gt;
				<cfelse>
					&nbsp;
				</cfif>
			</td>
		</tr>
		</cfif>
	</cfoutput>
</table>
</body>
</html>
