<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Site Quality Manager Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("URL.var")>
    <CFQUERY BLOCKFACTOR="100" NAME="Office" Datasource="Corporate">
    SELECT OfficeName
    FROM IQAtbloffices
    WHERE ID = #URL.OfficeID#
    </cfquery>

    <cfoutput query="Office">
    <font class="warning">Message:</font> #URL.SQM# added as Site Quality Manager for #OfficeName#
    </cfoutput>
    <br /><br />
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="Offices" Datasource="Corporate">
SELECT * 
FROM IQAtbloffices
WHERE OfficeName <> '- None -'
AND Exist = 'Yes' 
AND SuperLocation = 'No'
AND OfficeName <> 'test location'
ORDER BY Region, SubRegion, OfficeName
</cfquery>

<cfset SubRegHolder=""> 

<table border="1">
<tr>
	<th>Office Name</th>
	<th>Site Quality Manager</th>
    <th>Manage</th>
</tr>
<CFOUTPUT Query="Offices"> 
    <cfif SubRegHolder IS NOT SubRegion> 
    <cfIf SubRegHolder is NOT ""><tr><td colspan="10">&nbsp;</td></tr></cfif>
    	<tr align="left" valign="top">
			<td colspan="10"><b>#Region# - #SubRegion#</b></td>
        </tr>
	</cfif>

	<tr align="left" valign="top">
    	<td nowrap>#OfficeName#</td>
   	    <td align="center">
			<cfif len(TechnicalAudits_SQM)>#replace(TechnicalAudits_SQM, ",", "<br>", "All")#<cfelse>--</cfif>
        </td>
        <td align="center">
        	<a href="TechnicalAudits_SQM_Edit.cfm?OfficeID=#ID#">
        		<img src="#SiteDir#SiteImages/ico_article.gif" border="0" />
            </a>
        </td>
    </tr>

    <cfset SubRegHolder = SubRegion>
</CFOUTPUT>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->