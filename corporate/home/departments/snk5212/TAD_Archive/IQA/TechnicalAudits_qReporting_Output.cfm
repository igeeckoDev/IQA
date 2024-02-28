<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM 	TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<cfoutput>
<B>Audit Details</B><br>
<a href="TechnicalAudits_AuditDetails.cfm?ID=#ID#&Year=#Year#">View</a><br><br>
</cfoutput>

<CFQUERY DataSource="UL06046" Name="Reporting" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	TechnicalAudits_Categories.ID as CatID, 
    TechnicalAudits_Categories.CategoryName,
    TechnicalAudits_Items.ID as ItemID, 
    TechnicalAudits_Items.ItemName,
    TechnicalAudits_SubItems.ID as SubItemID, 
    TechnicalAudits_SubItems.SubItem,
    TechnicalAudits_NC.ID as NCID, 
    TechnicalAudits_NC.NC_OriginalCount as NC_Orig,
    TechnicalAudits_NC.CNBD_OriginalCount as CNBD_Orig,
    TechnicalAudits_NC.NC_AFTERAPPEALCOUNT as NC_PostAppeal
    <cfif url.ShowAll eq "Analysis">
    , TechnicalAudits_NC.Analysis
    </cfif>
FROM 
	TechnicalAudits_Categories, TechnicalAudits_Items, TechnicalAudits_SubItems, TechnicalAudits_NC
WHERE 
    TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
    AND TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
    AND TechnicalAudits_NC.SubItemID = TechnicalAudits_SubItems.ID
    <cfif URL.ShowAll eq "No" OR URL.ShowAll eq "Analysis">
    AND (TechnicalAudits_NC.NC_OriginalCount > 0 OR TechnicalAudits_NC.CNBD_OriginalCount > 0) 
    </cfif>
    AND TechnicalAudits_NC.AuditYear = #URL.Year#
    AND TechnicalAudits_NC.AuditID = #URL.ID#
ORDER BY 
	TechnicalAudits_Categories.alphaOrder, TechnicalAudits_Items.alphaOrder, TechnicalAudits_SubItems.SubItem
</CFQUERY>

<b>Audit Report</b><br />
<!--- query to get details --->
<CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ReportFileName, DatePosted
FROM TechnicalAudits_ReportFiles
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND Flag_CurrentStep = 'Non-Conformance Input Completed'
</cfquery>

<cfoutput>
<!--- view report file --->
<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a><br /><br />

<cfset CatHolder = "">
<cfset ItemHolder = "">

<b>Filter Non-Conformances</b>
<Br><u>Currently Viewing</u>: <font class="warning"><b><cfif url.ShowAll eq "Yes">All<cfelseif url.showAll eq "Analysis">Show Analysis<cfelse>Issues Only</cfif></b></font><br>
:: <a href="#CGI.Script_Name#?ID=#URL.ID#&Year=#URL.Year#&showAll=Yes">Show All</a><br>
:: <a href="#CGI.Script_Name#?ID=#URL.ID#&Year=#URL.Year#&showAll=No">Condense</a> (Issues Only)<br />
:: <a href="#CGI.Script_Name#?ID=#URL.ID#&Year=#URL.Year#&showAll=Analysis">Show Analysis</a><br />
<!--- :: View All / Export to Excel--->

<cfif url.ShowAll eq "Analysis">
	<cfset colspan = 7>
<cfelse>
	<cfset colspan = 6>
</cfif>
</cfoutput><br />

<b>Non-Conformances</b><br />
<Table border="1">
<tr valign="top">
    <th>Category</th>
    <th>Item</th>
    <th>Sub Item</th>
    <th align="center">NCs</th>
    <th align="center">CNBDs</th>
    <th align="center">NCs After Appeal</th>
	<cfif url.ShowAll eq "Analysis">
   		<th align="center">Analysis</th>
	</cfif>
</tr>
<tr valign="top">
<cfoutput query="Reporting">
	<cfif NOT len(CatHolder)>
    	<td valign="top">#CategoryName#</td>
    <cfelseif CatHolder NEQ CategoryName>
   		<td colspan="#colspan#">&nbsp;</td>
	</tr>
        <cfset ItemHolder = "">
    <tr valign="top">
        <td valign="top">#CategoryName#</td>
    </cfif>
    
   	<cfif NOT len(ItemHolder)>
        <td align="center" valign="top">#ItemName#</td>
        <td align="center" valign="top">#SubItem#</td>
        <td align="center" valign="top"><cfif NC_Orig GT 0><b>#NC_Orig#</b><cfelse>--</cfif></td>
        <td align="center" valign="top"><cfif CNBD_Orig GT 0><b>#CNBD_Orig#</b><cfelse>--</cfif></td>
		<td align="center" valign="top"><cfif NC_PostAppeal GT 0><b>#NC_PostAppeal#</b><cfelse>--</cfif></td>
        <cfif url.ShowAll eq "Analysis">
        	<td align="center" valign="top">#replace(Analysis, "!", "'", "All")#</td>
		</cfif>
    <cfelseif ItemHolder NEQ ItemName>
        <td>&nbsp;</td>
        <td align="center" valign="top">#ItemName#</td>
        <td align="center" valign="top">#SubItem#</td>
        <td align="center" valign="top"><cfif NC_Orig GT 0><b>#NC_Orig#</b><cfelse>--</cfif></td>
        <td align="center" valign="top"><cfif CNBD_Orig GT 0><b>#CNBD_Orig#</b><cfelse>--</cfif></td>
        <td align="center" valign="top"><cfif NC_PostAppeal GT 0><b>#NC_PostAppeal#</b><cfelse>--</cfif></td>
        <cfif url.ShowAll eq "Analysis">
        	<td align="center" valign="top">#replace(Analysis, "!", "'", "All")#</td>
		</cfif>
    <cfelseif ItemHolder EQ ItemName>
    	<td colspan="2">&nbsp;</td>
        <td align="center" valign="top">#SubItem#</td>
        <td align="center" valign="top"><cfif NC_Orig GT 0><b>#NC_Orig#</b><cfelse>--</cfif></td>
        <td align="center" valign="top"><cfif CNBD_Orig GT 0><b>#CNBD_Orig#</b><cfelse>--</cfif></td>
        <td align="center" valign="top"><cfif NC_PostAppeal GT 0><b>#NC_PostAppeal#</b><cfelse>--</cfif></td>
        <cfif url.ShowAll eq "Analysis">
        	<td align="center" valign="top">#replace(Analysis, "!", "'", "All")#</td>
		</cfif>
	</cfif>
	</tr>
    
<cfset CatHolder = CategoryName>
<Cfset ItemHolder = ItemName>
</cfoutput>
</table><Br />

<cfif Audit.AuditType2 eq "Full" AND Audit.NCExistPostAppeal eq "Yes">
    <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * FROM TechnicalAudits_SRCAR
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    </CFQUERY>
    
    <b>SR / CAR Information Entered</b><br />
    
    <table border="1">
    <tr>
        <th align="center">Issue Type</th>
        <th align="center">Number</th>
        <th align="center">Due Date</th>
        <th align="center">Additional SR/CAR Numbers</th>
    </tr>
    <cfoutput query="SRCAR">
    <tr>
        <td valign="top">#IssueType#</td>
        <td valign="top">#SRCARNumber#</td>
        <td valign="top">#Dateformat(SRCARClosedDueDate, "mm/dd/yyyy")#</td>
        <td valign="top"><cfif len(SRCAR_AdditionalNumbers)>#replace(SRCAR_AdditionalNumbers, ",", "<br />", "All")#<cfelse>N/A</cfif></td>
    </tr>
    </cfoutput>
    </table>
</cfif>