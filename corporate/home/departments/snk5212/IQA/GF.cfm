<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Global Functions / Processes - List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="GF" Datasource="Corporate">
SELECT * From GlobalFunctions
WHERE Status IS NULL
Order BY Function
</CFQUERY>

<Table border="1">
<tr class="blog-title">
    <td>Function</td>
    <td>Owner</td>
</tr>
<CFOUTPUT query="GF">
<tr class="blog-content">
    <td valign="top">
    	#Function#
    </td> 
	<td valign="top">
		<cfif len(Owner)>
        	#replace(Owner, ",", "<br>", "All")#
		<cfelse>
        	None Listed
		</cfif>
    </td> 
</tr>
</CFOUTPUT>
</TABLE>
						  
<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->