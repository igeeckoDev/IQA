<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Office Contacts for Audit Notifications">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Offices" Datasource="Corporate">
SELECT * FROM IQAtbloffices
WHERE OfficeName <> '- None -'
AND Exist = 'Yes'
AND (SuperLocation = 'No' OR SuperLocation IS NULL OR SuperLocation <> 'Yes')
ORDER BY Region, SubRegion, OfficeName
</cfquery>

<cfset SubRegHolder="">

<table border="1">
<tr align="center" valign="top" class="sched-title">
	<td>Office Name</td>
    <td>Contact 1</td>
    <td>Contact 2</td>
    <td>Contact 3</td>
    <td>Contact 4</td>
    <td>Contact 5 (list)</td>
    <td>Contact 6 (list)</td>
    <td>Regional Contact 1</td>
    <td>Regional Contact 2</td>
    <td>Regional Contacts 3 (list)</td>
</tr>
<CFOUTPUT Query="Offices">
    <cfif SubRegHolder IS NOT SubRegion>
    <cfIf SubRegHolder is NOT ""><tr><td colspan="10">&nbsp;</td></tr></cfif>
    	<tr align="left" valign="top" class="blog-title">
			<td colspan="10"><b>#Region# - #SubRegion#</b></td>
        </tr>
	</cfif>

	<tr align="left" valign="top" class="sched-content">
    	<td nowrap>#OfficeName# <a href="editcontacts.cfm?ID=#ID#">edit</a></td>
   	    <td><cfif len(RQM)>#replace(RQM, ",", "<br>", "All")#<cfelse>--</cfif></td>
	    <td><cfif len(QM)>#replace(QM, ",", "<br>", "All")#<cfelse>--</cfif></td>
    	<td><cfif len(GM)>#replace(GM, ",", "<br>", "All")#<cfelse>--</cfif></td>
    	<td><cfif len(LES)>#replace(LES, ",", "<br>", "All")#<cfelse>--</cfif></td>
        <td><cfif len(Other)>#replace(Other, ",", "<br>", "All")#<cfelse>--</cfif></td>
        <td><cfif len(Other2)>#replace(Other2, ",", "<br>", "All")#<cfelse>--</cfif></td>
        <td><cfif len(Regional1)>#replace(Regional1, ",", "<br>", "All")#<cfelse>--</cfif></td>
        <td><cfif len(Regional2)>#replace(Regional2, ",", "<br>", "All")#<cfelse>--</cfif></td>
        <td><cfif len(Regional3)>#replace(Regional3, ",", "<br>", "All")#<cfelse>--</cfif></td>
    </tr>

    <cfset SubRegHolder = SubRegion>
</CFOUTPUT>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->