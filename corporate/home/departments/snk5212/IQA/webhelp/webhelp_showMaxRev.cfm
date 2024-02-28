<cfset subTitle = "Web Help Index">
<cfinclude template="webhelp_StartOfPage.cfm">

<CFQUERY DataSource="Corporate" Name="WebHelpItems">
SELECT ID, Category, Status
FROM webHelp
WHERE (Status IS NULL OR Status <> 'removed')
ORDER BY Category, ID
</CFQUERY>

<table border="1" style="border-collapse: collapse;">
<tr>
    <th align="center">Help Topic</th>
    <th align="center">View Item</th>
    <th align="center">Revision Number</th>
    <th align="center">Revision Date</th>
	<th align="center">webHelp ID</th>
</tr>

<cfset CatHolder = "Start">

<cfoutput query="WebHelpItems">
	<CFQUERY DataSource="Corporate" Name="MaxRevNo">
    SELECT MAX(RevNumber) as maxRevNo
    FROM webHelp_Rev
    WHERE webHelpID = #ID#
    </CFQUERY>

    <CFQUERY DataSource="Corporate" Name="Details">
    SELECT webHelp.fileName, webHelp_Rev.RevNumber, webHelp_Rev.RevDate, webHelp.Title
    FROM webHelp, webHelp_Rev
    WHERE webHelp.ID = #ID#
    AND webHelp.ID = webHelp_Rev.webHelpID
    AND webHelp_Rev.RevNumber = #MaxRevNo.MaxRevNo#
    </CFQUERY>

    <cfif Len(CatHolder)>
    	<cfif CatHolder IS NOT Category>
        	<tr>
                <th colspan="5">
                    <b>#Category#</b>
                </th>
            </tr>
		</cfif>
    </cfif>

    <tr>
    	<td>#Details.Title#</td>
        <td align="center"><cfif status is "dev">N/A<cfelse><a href="#Details.fileName#?Type=#URL.Type#">View</a></cfif></td>
        <td align="center">#Details.RevNumber#</td>
        <td align="center">#dateformat(Details.RevDate, "mm/dd/yyyy")#</td>
		<td align="center">#ID#</td>
	</tr>

<cfset CatHolder = Category>
</cfoutput>
</table>

<cfinclude template="webhelp_EndOfPage.cfm">