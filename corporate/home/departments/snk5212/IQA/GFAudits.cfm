<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Global Functions - 2009-2011 IQA Audits">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
	
<CFQUERY Name="GF" Datasource="Corporate">
SELECT Function From GlobalFunctions
WHERE Status IS NULL
Order BY Function
</CFQUERY>

<cfset xyz = #valueList(GF.Function, ',')#>
<cfset myArrayList = ListToArray(xyz)>

<div class="Blog-content">
<Table border="1">
<tr>
<td class="blog-title" align="center">Global Function / Process Name</td>
<td class="blog-title" align="center">2009</td>
<td class="blog-title" align="center">2010</td>
<td class="blog-title" align="center">2011</td>
</tr>
<cfloop from="1" to="#arraylen(myArrayList)#" index="i">

<tr align="left" valign="top">
<td class="blog-content" width="400">
<cfoutput>
#myArrayList[i]#<br>
</cfoutput>
</td>

    <cfloop from="2009" to="2011" index="k">
        <cfquery Name="Audits" Datasource="Corporate"> 
        SELECT YEAR_ as "Year", ID, Auditedby, Month, Status, OfficeName, AuditArea
        FROM AuditSchedule
        WHERE Area = '#myArrayList[i]#'
        AND  AuditType2 = 'Global Function/Process'
        AND YEAR_ = #k#
		ORDER BY ID
        </cfquery>

        <td class="blog-content" width="450">
        <cfif Audits.RecordCount gt 0>
			<cfoutput query="Audits">
                <cfif len(status)>
                	<cfif Status eq "Deleted">
                        <font color="red">
                            :: <a href="auditdetails.cfm?id=#id#&year=#year#">#year#-#id#-#AuditedBy#</a> <b><cfif status is "Deleted">[Cancelled]<cfelse>[#status#]</cfif></b><br>
                        </font>
					<cfelse>
                    	None<br>
                    </cfif>
                <cfelse>
                :: <a href="auditdetails.cfm?id=#id#&year=#year#">#year#-#id#-#AuditedBy#</a><Br>
                [#trim(AuditArea)#]<br>
                </cfif>
            </cfoutput>
        <cfelse>
        None
        </cfif>
        </td>
    </cfloop>

</tr>
</cfloop>
</table>
</div>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->