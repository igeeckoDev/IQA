<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Program Audits by IQA - #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Prog" Datasource="Corporate">
SELECT Program 
From ProgDev
WHERE IQA = 1
Order BY Program
</CFQUERY>

<cfset xyz = #valueList(Prog.Program, ',')#>
<cfset myArrayList = ListToArray(xyz)>

<Table border="1">
<tr>
<td class="blog-title">Program Namee</td>
<td class="blog-title">Audits Conducted</td>
</tr>
<cfloop from="1" to="#arraylen(myArrayList)#" index="i">
    <cfquery Name="Audits" Datasource="Corporate"> 
    SELECT YEAR_ as Year, ID, Auditedby, Month, Status, OfficeName, AuditType2
    FROM AuditSchedule
    WHERE Area = '#myArrayList[i]#'
    AND Year_ = #url.year#
    </cfquery>
    
    <tr align="left" valign="top">
    <td class="blog-content" width="400">
    <cfoutput>
	    #myArrayList[i]#<br>
    </cfoutput>
    </td>
    
    <td class="blog-content" width="250">
    <cfif Audits.RecordCount eq 0>
        None<br>
    </cfif>
    
    <cfoutput query="Audits">
        <cfif len(status)>
            <cfif status eq "Deleted">
                <cfset statusName = "Cancelled">
                :: 
                <font color="red">
                    <a href="auditdetails.cfm?id=#id#&year=#year#">#year#-#id#-#AuditedBy#</a> [#statusName#]<br>
                </font>
            </cfif>
        <cfelse>
    	    :: <a href="auditdetails.cfm?id=#id#&year=#year#">#year#-#id#-#AuditedBy#</a><br>
        </cfif>
    </cfoutput>
    </td>
    </tr>
</cfloop>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->