<cfinclude template="OracleDBSchemaCredentials.cfm">

<cfinclude template="header.cfm">

<!--- left side navigation include --->

<div id="wrapper">
<cfinclude template="leftnav.cfm">
	<!--- body of page --->
	<div id="middle">
	  <div class="content-pad">
	  	<cfoutput>
        <link type="text/css" href="#SiteDir#Siteshared/css/dark-hive/jquery-ui-1.8.9.custom.css" rel="Stylesheet" />
        <link type="text/css" href="#SiteDir#Siteshared/js/popBox/popBox1.2.1.css" rel="stylesheet" />
        <link type="text/css" href="#SiteDir#Siteshared/js/jqModal.css" rel="stylesheet" />

		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>

		<!---<script type="text/javascript" src="#SiteDir#Siteshared/js/jquery-1.4.4.min.js"></script>--->
		<script type="text/javascript" src="#SiteDir#Siteshared/js/jquery-ui-1.8.9.custom.min.js"></script>
		<script type="text/javascript" src="#SiteDir#Siteshared/js/popBox/popBox1.2.1.js"></script>
		<script type="text/javascript" src="#SiteDir#Siteshared/js/jqModal.js"></script>

		<!---
			<script src="#SiteDir#Siteshared/js/ui/ui.core.js"></script>
			<script src="#SiteDir#Siteshared/js/ui/ui.dialog.js"></script>
		--->
		
		<p align="center" class="SiteTitle">#Request.SiteTitle#</p>

		<cfif isDefined("subTitle")><span class="SubTitle">Current Action:</span><Br>#subTitle#<!--[if !(IE)]><!--><Br><Br><!--><![endif]--></cfif>
		<cfif isDefined("subTitle2")> / #subTitle2#</cfif>

        <!---
		<cfif left(cgi.script_name, 30) EQ "/departments/snk5212/IQA/_prog"
			OR left(cgi.script_name, 36) EQ "/departments/snk5212/IQA/admin/_prog">

			<br /><br />
			<cfinclude template="#IQADir#incProgMenu.cfm">
		</cfif>
		--->

		<!--- for NON IE browsers --->
        <!--[if !(IE)]><!--><hr width="50%" align="center"><br><!--><![endif]-->

		<!--- for IE browser --->
		<!--[if (IE)]><hr class='dash'><![endif]-->
		<cfif isDefined("subTitleHeading")><h4>#subTitleHeading#</h4></cfif>
		</cfoutput>