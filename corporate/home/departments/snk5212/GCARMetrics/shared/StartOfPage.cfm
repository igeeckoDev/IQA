<cfinclude template="header.cfm">
<!--- left side navigation include --->
<div id="wrapper">
<cfinclude template="leftnav.cfm">
	<!--- body of page --->
	<div id="middle">
	  <div class="content-pad">
	  	<cfoutput>
		<p align="center" class="SiteTitle">#Request.SiteTitle#</p>
		<cfif isDefined("subTitle")><span class="SubTitle">Current Action:</span><Br>#subTitle#</cfif>
		<cfif isDefined("subTitle2")> / #subTitle2#</cfif>
		<!--- for NON IE browsers --->
        <!--[if !(IE)]><!--><hr width="50%" align="center"><br><!--><![endif]-->

		<!--- for IE browser --->
		<!--[if (IE)]><hr class='dash'><![endif]-->
		</cfoutput>