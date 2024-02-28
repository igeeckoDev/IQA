<cfsetting requestTimeOut="300">

<cfif NOT isDefined("URL.ShowAll")>
	<cfset URL.ShowAll = "No">
</cfif>

<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - View Audit Non-Conformances">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as Count
FROM TechnicalAudits_AuditSchedule
WHERE Flag_CurrentStep LIKE 'Audit Completed and Closed%'

<cfif URL.Type neq "All">
AND AuditType2 = '#URL.Type#'
</cfif>

<cfif URl.Year neq "All">
AND Year_ = #URL.Year#
</cfif>

<cfif URL.Unit neq "All">
AND Month = #URL.Unit#
</cfif>

<cfif URL.OfficeName neq "All">
AND OfficeName = '#URL.OfficeName#'
</cfif>

<cfif URL.Industry neq "All">
AND Industry = '#URL.Industry#'
</cfif>

<cfif URL.EM neq "All">
AND EngManagerEmail = '#URL.EM#'
</cfif>
</cfquery>

<cfoutput query="Audit">#Count# Audits Selected</cfoutput><br><br>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Corporate.IQAtblOffices.OfficeName, Corporate.IQAtblOffices.ID, Corporate.IQAtblOffices.Region, Corporate.IQAtblOffices.SubRegion
FROM Corporate.IQAtblOffices, Corporate.IQARegion, UL06046.TechnicalAudits_AuditSchedule
WHERE Corporate.IQARegion.TechnicalAudits_Required = 'Yes'
AND Corporate.IQAtblOffices.Region = Corporate.IQARegion.Region
AND Corporate.IQAtblOffices.Exist = 'Yes' 
AND Corporate.IQAtblOffices.SuperLocation = 'No'
AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = Corporate.IQAtblOffices.OfficeName

<cfif URL.Type neq "All">
AND UL06046.TechnicalAudits_AuditSchedule.AuditType2 = '#URL.Type#'
</cfif>

<cfif URl.Year neq "All">
AND UL06046.TechnicalAudits_AuditSchedule.Year_ = #URL.Year#
</cfif>

<cfif URL.Unit neq "All">
AND UL06046.TechnicalAudits_AuditSchedule.Month = #URL.Unit#
</cfif>

<cfif URL.OfficeName neq "All">
AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = '#URL.OfficeName#'
</cfif>

<cfif URL.Industry neq "All">
AND UL06046.TechnicalAudits_AuditSchedule.Industry = '#URL.Industry#'
</cfif>

<cfif URL.EM neq "All">
AND UL06046.TechnicalAudits_AuditSchedule.EngManagerEmail = '#URL.EM#'
</cfif>

GROUP BY Corporate.IQAtblOffices.Region, Corporate.IQAtblOffices.SubRegion, Corporate.IQAtblOffices.OfficeName, Corporate.IQAtblOffices.ID
</cfquery>

<CFQUERY Name="Industry" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_Industry

WHERE 1 = 1

<cfif URL.Type neq "All">
AND AuditType2 = '#URL.Type#'
</cfif>

<cfif URl.Year neq "All">
AND Year_ = #URL.Year#
</cfif>

<cfif URL.Unit neq "All">
AND Month = #URL.Unit#
</cfif>

<cfif URL.OfficeName neq "All">
AND OfficeName = '#URL.OfficeName#'
</cfif>

<cfif URL.EM neq "All">
AND EngManagerEmail = '#URL.EM#'
</cfif>

Order BY Status DESC, ID
</CFQUERY>

<CFQUERY Name="EM" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DISTINCT EngManagerEmail as EM 
From TechnicalAudits_AuditSchedule
WHERE Flag_CurrentStep LIKE 'Audit Completed and Closed%'

<cfif URL.Type neq "All">
AND AuditType2 = '#URL.Type#'
</cfif>

<cfif URl.Year neq "All">
AND Year_ = #URL.Year#
</cfif>

<cfif URL.Unit neq "All">
AND Month = #URL.Unit#
</cfif>

<cfif URL.OfficeName neq "All">
AND OfficeName = '#URL.OfficeName#'
</cfif>

<cfif URL.Industry neq "All">
AND Industry = '#URL.Industry#'
</cfif>

ORDER BY EM
</CFQUERY>

<CFQUERY DataSource="UL06046" Name="Reporting" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	<!--- TechnicalAudits_Categories.ID as CatID, --->
    TechnicalAudits_Categories.CategoryName,
    <!--- TechnicalAudits_Items.ID as ItemID, --->
    TechnicalAudits_Items.ItemName,
    <!--- TechnicalAudits_SubItems.ID as SubItemID, --->
    TechnicalAudits_SubItems.SubItem,
    <!--- TechnicalAudits_NC.ID as NCID, --->
    SUM(TechnicalAudits_NC.NC_OriginalCount) as NC_Orig,
    SUM(TechnicalAudits_NC.CNBD_OriginalCount) as CNBD_Orig,
    SUM(TechnicalAudits_NC.NC_AFTERAPPEALCOUNT) as NC_PostAppeal
    <!---
    <cfif url.ShowAll eq "Analysis">
    , TechnicalAudits_NC.Analysis
    </cfif>
    --->
FROM 
	TechnicalAudits_Categories, TechnicalAudits_Items, TechnicalAudits_SubItems, TechnicalAudits_NC, TechnicalAudits_AuditSchedule
WHERE 
    TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
    AND TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
    AND TechnicalAudits_NC.SubItemID = TechnicalAudits_SubItems.ID
    AND TechnicalAudits_NC.AuditYear = TechnicalAudits_AuditSchedule.Year_
    AND Flag_CurrentStep LIKE 'Audit Completed and Closed%'
    
    <cfif URL.ShowAll eq "No"> <!--- OR URL.ShowAll eq "Analysis" --->
    AND (TechnicalAudits_NC.NC_OriginalCount > 0 OR TechnicalAudits_NC.CNBD_OriginalCount > 0) 
    </cfif>
	
    <cfif URL.Type neq "All">
    AND TechnicalAudits_AuditSchedule.AuditType2 = '#URL.Type#'
	</cfif>
    
    <cfif URL.Year neq "All">
    AND TechnicalAudits_NC.AuditYear = #URL.Year#
	</cfif>
    
    <cfif URL.Unit neq "All">
        AND 
        <cfif URL.Type eq "Full">
            <cfif URL.Unit eq 1>
                TechnicalAudits_AuditSchedule.MONTH BETWEEN 1 AND 3
                <cfset Quarter = 1>
            <cfelseif URL.Unit eq 2>
                TechnicalAudits_AuditSchedule.MONTH BETWEEN 4 AND 6
                <cfset Quarter = 2>
            <cfelseif URL.Unit eq 3>
                TechnicalAudits_AuditSchedule.MONTH BETWEEN 7 AND 9
                <cfset Quarter = 3>
            <cfelseif URL.Unit eq 4>
                TechnicalAudits_AuditSchedule.MONTH BETWEEN 10 AND 12
                <cfset Quarter = 4>
            </cfif>
        <Cfelse>
            TechnicalAudits_AuditSchedule.Month = #URL.Unit#
        </cfif>
	</cfif>
    
    <cfif URL.OfficeName neq "All">
    AND TechnicalAudits_AuditSchedule.OfficeName = '#URL.OfficeName#'
	</cfif>
    
    <cfif URL.Industry neq "All">
    AND TechnicalAudits_AuditSchedule.Industry = '#URL.Industry#'
    </cfif>

	<cfif URL.EM neq "All">
    AND EngManagerEmail = '#URL.EM#'
    </cfif>

GROUP BY 
	CategoryName, ItemName, SubItem
ORDER BY
	CategoryName, ItemName, SubItem
</CFQUERY>

<cfoutput>
<cfset CatHolder = "">
<cfset ItemHolder = "">

<cfif URL.Type neq "All">
    <cfif URL.Type eq "Full">
        <cfset Unit = "Quarter">
        <cfset UnitMax = "4">
        <cfset showQuarter = URL.Unit>
    <cfelseif URL.Type eq "In-Process">
        <cfset Unit = "Month">
        <cfset UnitMax = "12">
        <cfset showQuarter = URL.Unit>
    </cfif>
</cfif>

<b>Filter Non-Conformances</b><br><Br>

<u>Currently Viewing</u>: 
<cfif URL.ShowAll eq "Yes"><b>All Categories</b><cfelse><a href="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=Yes&unit=#url.unit#&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#">All Categories</a></cfif> / 
<cfif URL.ShowAll eq "No"><b>Categories with NCs</b><cfelse><a href="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=No&unit=#url.unit#&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#">Categories with Ncs</a></cfif><br>

<u>Year</u>: #URL.Year# 
<cfif URL.Year NEQ "All">
[<a href="#CGI.Script_Name#?type=#URL.TYPE#&year=All&showAll=No&unit=#url.unit#&OfficeName=All&Industry=#URL.Industry#&EM=#URL.EM#">Clear</a>]
</cfif>
<br />

<u>Audit Type</u>: #URL.Type# 
<cfif URL.Type NEQ "All">
[<a href="#CGI.Script_Name#?type=All&year=#URL.Year#&showAll=No&unit=#url.unit#&OfficeName=All&Industry=#URL.Industry#&EM=#URL.EM#">Clear</a>]
</cfif>
<br />

<cfif URL.Type neq "All">
<u>#Unit#</u>: <cfif Unit eq 'Month'>#monthasstring(URL.Unit)#<cfelse>#URL.Unit#</cfif> 
[<a href="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=No&unit=All&OfficeName=All&Industry=#URL.Industry#&EM=#URL.EM#">Clear</a>]
</cfif>
<br>

<cfif isDefined("URL.OfficeName")>
<u>Office</u>: #URL.OfficeName# 
<cfif URL.OfficeName NEQ "All">
[<a href="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=No&unit=#url.unit#&OfficeName=All&Industry=#URL.Industry#&EM=#URL.EM#">Clear</a>]
</cfif>
</cfif>
<br>

<cfif isDefined("URL.Industry")>
<u>Industry</u>: #URL.Industry# 
<cfif URL.Industry NEQ "All">
[<a href="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=No&unit=#url.unit#&OfficeName=All&Industry=All&EM=#URL.EM#">Clear</a>]
</cfif>
</cfif>
<br>

<cfif isDefined("URL.EM")>
<u>Engineering Manager</u>: #URL.EM# 
<cfif URL.EM NEQ "All">
[<a href="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=No&unit=#url.unit#&OfficeName=All&Industry=#URL.Industry#&EM=All">Clear</a>]
</cfif>
</cfif>
<br><br />

Type of Audit (Full / In-Process):<br>
<SELECT NAME="YearJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Year Below
	<option value="javascript:document.location.reload();">
    <OPTION VALUE="#CGI.Script_Name#?type=All&year=All&showAll=#URL.ShowAll#&unit=#url.unit#&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#">All Types
	<OPTION VALUE="#CGI.Script_Name#?type=Full&year=#URL.Year#&showAll=#URL.ShowAll#&unit=#url.unit#&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#">Full
	<OPTION VALUE="#CGI.Script_Name#?type=Full&year=#URL.Year#&showAll=#URL.ShowAll#&unit=#url.unit#&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#">In-Process
</SELECT>
<br><br>

Year:<br>
<SELECT NAME="YearJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Year Below
		<option value="javascript:document.location.reload();">
    <OPTION VALUE="#CGI.Script_Name#?type=#URL.TYPE#&year=All&showAll=#URL.ShowAll#&unit=#url.unit#&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#">All Years
<cfloop index="i" to="2017" from="2012">
		<OPTION VALUE="#CGI.Script_Name#?type=#URL.TYPE#&year=#i#&showAll=#URL.ShowAll#&unit=#url.unit#&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#">#i#
</cfloop>
</SELECT>
<br><br>

<cfif URL.Type neq "All">
Select #Unit#:<br />
<SELECT NAME="UnitJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select #Unit# Below
	<option value="javascript:document.location.reload();">
    <OPTION VALUE="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=#URL.ShowAll#&unit=All&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#">All #Unit#s
	<cfloop index="i" to="#UnitMax#" from="1">
		<OPTION VALUE="#CGI.SCRIPT_NAME#?type=#URL.TYPE#&year=#url.year#&unit=#i#&showall=#URL.showAll#&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#"><cfif Unit eq 'Month'>#monthasstring(i)#<cfelse>Quarter #i#</cfif>
	</cfloop>
</SELECT><br /><br />
</cfif>

<cfset SubRegionHolder = "">

Select OfficeName:<br>
<SELECT NAME="UnitJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select OfficeName Below
	<option value="javascript:document.location.reload();">
    <OPTION VALUE="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=#URL.ShowAll#&unit=#URL.Unit#&OfficeName=All&Industry=#URL.Industry#&EM=#URL.EM#">All Offices
    <CFLoop QUERY="OfficeName">
	    <cfif NOT len(SubRegionHolder) OR SubRegionHolder NEQ SubRegion>
        	<OPTION value="">---</OPTION>
    	    <OPTION>#Region# / #SubRegion#</OPTION>
        </cfif>
                    
        <OPTION VALUE="#CGI.SCRIPT_NAME#?type=#URL.TYPE#&year=#url.year#&unit=#URl.Unit#&showall=#URL.showAll#&OfficeName=#OfficeName#&Industry=#URL.Industry#&EM=#URL.EM#"> &nbsp; #OfficeName#</OPTION>
    
    <cfset SubRegionHolder = SubRegion>
    </CFLoop>
</SELECT><Br /><br />

Select Industry:<br>
<SELECT NAME="UnitJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Industry Below
	<option value="javascript:document.location.reload();">
    <OPTION VALUE="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=#URL.ShowAll#&unit=#URL.Unit#&OfficeName=All&Industry=All&EM=#URL.EM#">All Industries
    <CFLoop QUERY="Industry">
        <OPTION VALUE="#CGI.SCRIPT_NAME#?type=#URL.TYPE#&year=#url.year#&unit=#URl.Unit#&showall=#URL.showAll#&OfficeName=#URL.OfficeName#&Industry=#Industry#&EM=#URL.EM#">#Industry#</OPTION>
    </CFLoop>
</SELECT><Br /><br />

Select Engineering Manager:<br>
<SELECT NAME="UnitJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Engineering Manager Below
	<option value="javascript:document.location.reload();">
    <OPTION VALUE="#CGI.Script_Name#?type=#URL.TYPE#&year=#URL.Year#&showAll=#URL.ShowAll#&unit=#URL.Unit#&OfficeName=All&Industry=All&EM=All">All Engineering Managers
    <CFLoop QUERY="EM">
        <OPTION VALUE="#CGI.SCRIPT_NAME#?type=#URL.TYPE#&year=#url.year#&unit=#URl.Unit#&showall=#URL.showAll#&OfficeName=#URL.OfficeName#&Industry=#URL.Industry#&EM=#EM#">#EM#</OPTION>
    </CFLoop>
</SELECT><Br /><br />

<cfif url.ShowAll eq "Analysis">
    <cfset colspan = 7>
<cfelse>
    <cfset colspan = 6>
</cfif><br>
</cfoutput>

<b>Non-Conformances</b><br />
<Table border="1">
<tr valign="top">
    <th>Category</th>
    <th>Item</th>
    <th>Sub Item</th>
    <th align="center">Non-Conformances Identified in the Report</th>
    <th align="center">CNBDs Identified in the Report</th>
    <th align="center">Non-Conformances After Appeals</th>
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
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->