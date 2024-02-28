<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Corporate Functions - 2009-2011 IQA Audits">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="CF" Datasource="Corporate">
SELECT Function From CorporateFunctions
WHERE Status IS NULL
Order BY Function
</CFQUERY>

<cfset xyz = #valueList(CF.Function, ',')#>
<cfset myArrayList = ListToArray(xyz)>

<Table border="1" widht="800">
<tr>
<td class="blog-title" align="center">Corporate Function Name</td>
<td class="blog-title" align="center">2009 Audits Conducted</td>
<td class="blog-title" align="center">2010 Audits Conducted</td>
<td class="blog-title" align="center">2011 Audits Conducted</td>
</tr>

<cfloop from="1" to="#arraylen(myArrayList)#" index="i">

<tr align="left" valign="top">
<td class="blog-content" width="300">
<cfoutput>
#myArrayList[i]#<br>
</cfoutput>
</td>

<cfloop from="2009" to="2011" index="k">
	<cfquery Name="Audits" Datasource="Corporate"> 
	SELECT YEAR_ as "Year", ID, Auditedby, Month, Status, OfficeName, AuditArea
	FROM AuditSchedule
	WHERE Area = '#myArrayList[i]#'
	AND YEAR_ = #k#
    AND AuditType2 = 'Corporate'
	</cfquery>

        <td class="blog-content" width="250">
        <cfif Audits.RecordCount gt 0>
			<cfoutput query="Audits">
                <cfif len(status)>
                    <font color="red">
                        :: <a href="auditdetails.cfm?id=#id#&year=#year#">#year#-#id#-#AuditedBy#</a> <b><cfif status is "Deleted">[Cancelled]<cfelse>[#status#]</cfif></b><br>
                    </font>
                <cfelse>
                :: <a href="auditdetails.cfm?id=#id#&year=#year#">#year#-#id#-#AuditedBy#</a> [#trim(AuditArea)#]<br>
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

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->