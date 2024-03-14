<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<cfoutput>
	<title>#Request.SiteTitle#</title>
	<META NAME="description" CONTENT="#Request.MetaDescription#">
	<META NAME="keywords" CONTENT="#Request.MetaKeywords#">
	
    <script type="text/javascript" src="#request.serverProtocol##request.serverDomain#/header/jquery-1.2.6.js"></script>
	</cfoutput>
	<link rel="stylesheet" type="text/css" media="screen" href="cr_style.css" />
	<link rel="stylesheet" type="text/css" media="print" href="cr_style.css" />
	<link rel="stylesheet" type="text/css" href="/header/ulnetheader.css" />
    <link rel="stylesheet" type="text/css" href="about/IE8.css" />

</head>

<!-- Change header theme by changing body class [red|black]-->
<body>
<cfoutput>
<script language=JavaScript src="#request.serverProtocol##request.serverDomain#/header/header2011.js"></script>
</cfoutput>
<div id="header">
<br /><br />
  <table border="0" cellspacing="0" cellpadding="0" width="776">
    <tr>
      <td align="center" valign="middle" width="158">
        <div class="navdate">
			<cfoutput>
				#dateformat(now(), "MMMM d, yyyy")#
        	</cfoutput>
		</div>
	</td>
<td align="left" valign="top" width="618" height="23">
&nbsp;
</td>
    </tr>
  </table>
</div>