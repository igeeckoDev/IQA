<cfif isDefined("URL.Type")>
	<cfif URL.Type eq "inLine">
        <!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
        <cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
        <!--- / --->
	<cfelseif URL.Type eq "popUp">
    	<link href="../cr_style.css" rel="stylesheet" media="screen">
    </cfif>
<cfelse>
	<link href="../cr_style.css" rel="stylesheet" media="screen">
</cfif>

<table border="0" width="100%">
<cfif isDefined("URL.Type") AND URL.Type eq "popUp" OR NOT isDefined("URL.Type")>
<tr>
<th>
<cfoutput>#subTitle#</cfoutput>
</td>
</tr>
</cfif>
<tr>
<td class="blog-content">