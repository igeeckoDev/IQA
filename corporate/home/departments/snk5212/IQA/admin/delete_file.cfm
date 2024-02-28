<html>

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<cfset Self = GetFileFromPath(cgi.CF_TEMPLATE_PATH)>
<cfset DirToList = GetDirectoryFromPath(ExpandPath("./" & Self))>
<cfset UpOneDir = ListDeleteAt(DirToList, ListLen(DirToList, "\"), "\") & "\" & self>
<cfdirectory action="list" directory="#DirToList#" name="DirListing">

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
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td width="3%" height="20" align="right"><p>&nbsp;</p></td>
                          <td width="94%" align="left" class="blog-title"><p align="left"><br>
                              Upload Files to ADMIN folder</p></td>
                          <td width="3%" align="right" nowrap class="blog-time">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td width="3%"></td>
                          <td class="blog-content" align="left"><p align="left">
<br><br>				  
<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU">

<cfif isDefined("Form.Delete")>
<!--- If TRUE then upload the file --->
<cffile action="Delete" file="#Form.destination##Form.Delete#">

<CFMAIL to="Christopher.J.Nicastro@ul.com" subject="IQA File Delete - Corporate Webserver" from="Christopher.J.Nicastro">
File Delete from the Corporate Server was successful! 

File: #Form.Delete#
Location: #Form.Destination#
Notes: #Form.Notes#
</CFMAIL>

<CFOUTPUT>
File Delete was Successful!<br><br>

File: #Form.Delete#<br>
Location: #Form.Destination#<br>
Notes: #Form.Notes#
<HR>
</CFOUTPUT>
<br>
Delete More? <a href="Delete_file.cfm">Do it again</a>.</p>
<cfelse>
<!--- If FALSE then show the Form --->
<form method="post" action=<cfoutput>#cgi.script_name#</cfoutput> name="Delete" enctype="multipart/form-data">
File to delete:<br>
<input name="Delete" type="text">
<br><br>
Destination folder:<br>
<cfoutput>
<input name="Destination" type="Text" size="70" value="#basedir#">
</cfoutput>
<br><br>
Notes:<br>
<textarea WRAP="PHYSICAL" ROWS="3" COLS="70" NAME="Notes" Value=""></textarea>
<br><br>
<input name="submit" type="submit" value="Delete"> 
</form>
</cfif> 

<cfelse>
<p>How did you get in here?</p>
</CFIF>
</cflock>	

<br>
<table width="98%" align="center">
	<tr>
		<th>File Name</th>
		<th>File Size</th>
		<th>Date Last Modified</th>
		<th>&nbsp;</th>
	</tr>
	<tr>
		<td>
			<cfif FileExists(UpOneDir)>
				<cfoutput>
					<a href="../#self#" title="Up One Level">../</a>
				</cfoutput>
			</cfif>
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<cfoutput query="DirListing">
		<cfset nextDirName = DirToList & name & "\" & Self>
		<cfset nextDirLink = name & "/" & self>
		<cfset useclass = "alt">
		<cfif CurrentRow mod 2>
			<cfset useclass = "main">
		</cfif>
		<tr class="#useclass#">
			<td><a href="#name#">#name#</a></td>
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
					<cfif FileExists(nextDirName)>
						&lt; <a href="#nextDirLink#">dir</a> &gt;
					<cfelse>
						&lt; dir &gt;
					</cfif>
				<cfelse>
					&nbsp;
				</cfif>
			</td>
		</tr>
		<cfset nextDirName = "">
		<cfset nextDirLink = "">
	</cfoutput>
</table>


<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->