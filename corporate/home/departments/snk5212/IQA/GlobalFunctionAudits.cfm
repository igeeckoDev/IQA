<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Global Functions - #url.year# IQA Audits">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->
	
<CFQUERY Name="GF" Datasource="Corporate">
SELECT Function 
FROM GlobalFunctions
WHERE Status IS NULL
Order BY Function
</CFQUERY>

<cfset xyz = #valueList(GF.Function, ',')#>
<cfset myArrayList = ListToArray(xyz)>

<div class="Blog-content">
<Table border="1">
<tr>
<td class="blog-title" align="center">Global Function / Process Name</td>
<td class="blog-title" align="center">Audits Conducted</td>
</tr>
<cfloop from="1" to="#arraylen(myArrayList)#" index="i">

<tr align="left" valign="top">
<td class="blog-content" width="400">
<cfoutput>
#myArrayList[i]#<br>
</cfoutput>
</td>

    <cfquery Name="Audits" Datasource="Corporate"> 
    SELECT YEAR_ as "Year", ID, Auditedby, Month, Status, OfficeName, AuditArea
    FROM AuditSchedule
    WHERE Area = '#myArrayList[i]#'
    AND  AuditType2 = 'Global Function/Process'
    AND YEAR_ = 2011
    ORDER BY ID
    </cfquery>

    <td class="blog-content" width="450">
    <cfif Audits.RecordCount eq 0>
        None<br>
    <cfelse>
        <cfoutput query="Audits">
            <cfif len(status)>
            	<cfif status eq "Deleted">
	                <cfset statusName = "Cancelled">
                    :: <a href="auditdetails.cfm?id=#id#&year=#year#">#year#-#id#-#AuditedBy#</a><br>
                    <font color="red">[#statusName#]</font><br>
                    [#trim(AuditArea)#]<br><br>
				<cfelse>
                	None<br>
                </cfif>
            <cfelse>
	            :: <a href="auditdetails.cfm?id=#id#&year=#year#">#year#-#id#-#AuditedBy#</a><br>
                [#trim(AuditArea)#]<br><br>
            </cfif>
        </cfoutput>
	</cfif>
    </td>

</tr>
</cfloop>
</table>
</div>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->