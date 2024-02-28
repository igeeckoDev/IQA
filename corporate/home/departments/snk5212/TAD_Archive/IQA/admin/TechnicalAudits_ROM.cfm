<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Regional Operations Manager Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("URL.var")>
    <CFQUERY BLOCKFACTOR="100" NAME="Region" Datasource="Corporate">
    SELECT Region
    FROM IQARegion
    WHERE ID = #URL.RegionID#
    </cfquery>

    <cfoutput query="Region">
    <font class="warning">Message:</font> #URL.ROM# added as Regional Operations Manager for #Region#
    </cfoutput>
    <br /><br />
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="ROM" Datasource="Corporate">
SELECT * 
FROM IQARegion
WHERE TechnicalAudits_Required = 'Yes'
ORDER BY Region
</cfquery>

<cfset SubRegHolder=""> 

<table border="1">
<tr>
	<th>Region Name</th>
	<th>Regional Operations Manager</th>
    <th>Manage</th>
</tr>
<CFOUTPUT Query="ROM"> 
	<tr align="left" valign="top">
    	<td nowrap>#Region#</td>
   	    <td align="center">
			<cfif len(TechnicalAudits_ROM)>#replace(TechnicalAudits_ROM, ",", "<br>", "All")#<cfelse>--</cfif>
        </td>
        <td align="center">
        	<a href="TechnicalAudits_ROM_Edit.cfm?RegionID=#ID#">
        		<img src="#SiteDir#SiteImages/ico_article.gif" border="0" />
            </a>
        </td>
    </tr>
</CFOUTPUT>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->