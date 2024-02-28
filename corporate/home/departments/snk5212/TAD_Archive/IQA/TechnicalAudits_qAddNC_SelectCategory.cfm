<!---
<cfif isDefined("URL.Refresh") AND URL.Refresh eq "Yes">
	<cflocation url="#IQADir#TechnicalAudits_AddNC_SelectCategory.cfm?Year=#URl.Year#&ID=#URL.ID#" addtoken="no">
</cfif>
--->

<!--- Add rows if they have not already been added --->
<cfinclude template="#IQADir#TechnicalAudits_incAddNC_setZeros.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfinclude template="#IQADir#TechnicalAudit_incAuditIdentifier.cfm">

<CFQUERY DataSource="UL06046" Name="Categories" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	TechnicalAudits_Categories.ID, TechnicalAudits_Categories.CategoryName, TechnicalAudits_Categories.alphaOrder
FROM 
	TechnicalAudits_Categories
WHERE 
    TechnicalAudits_Categories.Status IS NULL
ORDER BY 
	TechnicalAudits_Categories.alphaOrder
</CFQUERY>

<b>Audit Report</b><br />
<!--- query to get details --->
<CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#" maxrows="1">
SELECT ReportFileName, DatePosted
FROM TechnicalAudits_ReportFiles
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
ORDER BY ID DESC
</cfquery>

<cfoutput>
<!--- view report file --->
<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a><br /><br />
</cfoutput>

<div align="Left" class="blog-time">
<br />
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.12 Input Non-Conformances<br /><br /><Br />
</cfoutput>

<!---
1. Select a Category below to begin adding Non-Conformances<br>
2. Enter SR/CAR Information<br />
3. Upload Audit Report<br /><Br />
--->
</div>

Note - Step 3 Confirms that all information is correct. After this step, the information will no longer be editable.<br /><br />

<!--- used to check if all categories/items/subitems are entered in the report/nc table --->
<cfset varAllDone = 0>

<table border="1">
<tr>
    <th>Category Name</th>
    <th>Status</th>
</tr>
<cfoutput query="Categories">
<tr>
	<td>#CategoryName#</td>
    <td align="center">
    	<!--- Count the Sub Items for this Category (CategoryName) --->
        <CFQUERY DataSource="UL06046" Name="SubItemCount" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT 
            COUNT(*) as SubItemCount
        FROM 
            TechnicalAudits_Categories, TechnicalAudits_Items, TechnicalAudits_SubItems
        WHERE 
            TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
            AND TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
			AND TechnicalAudits_Categories.ID = #ID#
        </CFQUERY>
        
        <!--- get the SubItemID row in order of the Items in this Category. --->
		<CFQUERY DataSource="UL06046" Name="getNCs" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT 
            TechnicalAudits_SubItems.ID as SubItemID
        FROM 
            TechnicalAudits_Categories, TechnicalAudits_Items, TechnicalAudits_SubItems
        WHERE 
            TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
            AND TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
			AND TechnicalAudits_Categories.ID = #ID#
        ORDER BY
        	TechnicalAudits_Items.alphaOrder
        </CFQUERY>
        
        <!--- set the number of subItems Report/NC Rows to zero --->
        <!--- this is evaluated against "SubItemCount.SubItemCount" later --->
        <cfset subItemReportCount = 0>
        
        <!--- loop through getNCs --->
        <!---
        <cfloop query="getNCs">
        	<!--- check for subItem rows in the Report/NC table --->
            <CFQUERY DataSource="UL06046" Name="ReportCount" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT Count(*) as ReportCount
            FROM TechnicalAudits_NC
            WHERE AuditYear = #URL.Year#
            AND AuditID = #URL.ID#
            AND SubItemID = #SubItemID#
            </CFQUERY>
            
            <!--- check if the count is 1 (exists) or 0 (does not exist) --->
            <Cfif reportCount.reportCount eq 1>
            	<!--- add 1 to subItemReportCount --->
            	<cfset subItemReportCount = subItemReportCount + 1>
			<cfelse>
            	<!--- unchanged --->
            	<cfset subItemReportCount = subItemReportCount>
			</Cfif>
        </cfloop>
		--->
        
        <A href="#IQADir#TechnicalAudits_AddNC_SelectItem.cfm?CategoryID=#ID#&#CGI.QUERY_STRING#">
        	Edit
		</A>
        
        <!--- if All are entered --->
        <!---
		<cfif subItemCount.subItemCount eq subItemReportCount>
        	<!--- allow edit --->
            <A href="#IQADir#TechnicalAudits_AddNC_SelectItem.cfm?CategoryID=#ID#&#CGI.QUERY_STRING#">
            	Edit
            </A>
            
            <!--- add 1 to varAllDone (to check entire report/NC for all Categories/Items/SubItems --->
            <cfset varAllDone = varAllDone + 1>
        <!--- if All are not entered --->
        <cfelse>
        	<!--- Allow Add --->
            <A href="#IQADir#TechnicalAudits_AddNC_SelectItem.cfm?CategoryID=#ID#&#CGI.QUERY_STRING#">
	        	Add
        	</A> :: 
            <a href="#IQADir#TechnicalAudits_AddNC_SelectItem_None_Action.cfm?CategoryID=#ID#&#CGI.QUERY_STRING#">
            	None
            </a>
		</cfif>
        --->
    </td>
</tr>
</cfoutput>
</table><Br />

<!--- if any NCs have been entered, show them --->
<CFQUERY DataSource="UL06046" Name="ReportItems" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Count(*) as ReportCount
FROM TechnicalAudits_NC
WHERE AuditYear = #URL.Year#
AND AuditID = #URL.ID#
</CFQUERY>

<cfif ReportItems.ReportCount GT 0>
	<!--- get report info --->
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
	FROM 
		TechnicalAudits_Categories, TechnicalAudits_Items, TechnicalAudits_SubItems, TechnicalAudits_NC
	WHERE 
		TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
		AND TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
		AND TechnicalAudits_NC.SubItemID = TechnicalAudits_SubItems.ID
		AND (TechnicalAudits_NC.NC_OriginalCount > 0 OR TechnicalAudits_NC.CNBD_OriginalCount > 0)
        AND TechnicalAudits_NC.AuditYear = #URL.Year#
		AND TechnicalAudits_NC.AuditID = #URL.ID#
	ORDER BY 
		TechnicalAudits_Categories.alphaOrder, TechnicalAudits_Items.alphaOrder, TechnicalAudits_SubItems.SubItem
	</CFQUERY>

	<cfif Reporting.RecordCount GT 0>
	Non-Conformances Added:<Br />
	
	<cfset CatHolder = "">
	<cfset ItemHolder = "">

		<Table border="1">
		<tr valign="top">
			<th>Category</th>
			<th>Item</th>
			<th>Sub Item</th>
			<th align="center">NCs</th>
			<th align="center">CNBDs</th>
			<th align="center">NCs After Appeal</th>
		</tr>
		<tr valign="top">
		<cfoutput query="Reporting">
			<cfif NOT len(CatHolder)>
				<td>#CategoryName#</td>
			<cfelseif CatHolder NEQ CategoryName>
				<td colspan="6">&nbsp;</td>
			</tr>
				<cfset ItemHolder = "">
			<tr valign="top">
				<td>#CategoryName#</td>
			</cfif>
			
			<cfif NOT len(ItemHolder)>
				<td align="center">#ItemName#</td>
				<td align="center">#SubItem#</td>
				<td align="center"><cfif NC_Orig GT 0><b>#NC_Orig#</b><cfelse>--</cfif></td>
				<td align="center"><cfif CNBD_Orig GT 0><b>#CNBD_Orig#</b><cfelse>--</cfif></td>
				<td align="center"><cfif NC_PostAppeal GT 0><b>#NC_PostAppeal#</b><cfelse>--</cfif></td>
			<cfelseif ItemHolder NEQ ItemName>
				<td>&nbsp;</td>
				<td align="center">#ItemName#</td>
				<td align="center">#SubItem#</td>
				<td align="center"><cfif NC_Orig GT 0><b>#NC_Orig#</b><cfelse>--</cfif></td>
				<td align="center"><cfif CNBD_Orig GT 0><b>#CNBD_Orig#</b><cfelse>--</cfif></td>
				<td align="center"><cfif NC_PostAppeal GT 0><b>#NC_PostAppeal#</b><cfelse>--</cfif></td>
			<cfelseif ItemHolder EQ ItemName>
				<td colspan="2">&nbsp;</td>
				<td align="center">#SubItem#</td>
				<td align="center"><cfif NC_Orig GT 0><b>#NC_Orig#</b><cfelse>--</cfif></td>
				<td align="center"><cfif CNBD_Orig GT 0><b>#CNBD_Orig#</b><cfelse>--</cfif></td>
				<td align="center"><cfif NC_PostAppeal GT 0><b>#NC_PostAppeal#</b><cfelse>--</cfif></td>
			</cfif>
			</tr>
			
		<cfset CatHolder = CategoryName>
		<Cfset ItemHolder = ItemName>
		</cfoutput>
		</tr>
		</table><Br />
	</cfif>
</cfif>

<!--- check if there are NC/CNBD and/or NCs After Appeal - in order to proceed --->
<CFQUERY DataSource="UL06046" Name="Validate" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_NC
WHERE 
<!--- there must be at least one NC or CNBD before appeal, and there must be at least one NC AFTER Appeal --->
<Cfif Audit.NCExistPostAppeal eq "Yes" AND Audit.AppealExist eq "Yes">
	(
		(NC_OriginalCount > 0 OR CNBD_OriginalCount > 0)
		AND NC_AFTERAPPEALCOUNT > 0
	)
<cfelseif Audit.NCExistPostAppeal eq "Yes" AND Audit.AppealExist eq "No" 
	OR Audit.NCExistPostAppeal eq "No" AND Audit.NCExist eq "Yes">
	<!--- there must be at least one NC or CNBD before appeal --->
	(NC_OriginalCount > 0 OR CNBD_OriginalCount > 0)
</Cfif>
	AND AuditYear = #URL.Year#
	AND AuditID = #URL.ID#
</CFQUERY>

<cfif Audit.NCExist eq "Yes" AND Audit.NCExistPostAppeal eq "Yes">
	<!--- check if all categories have report/nc rows --->
    <cfif Validate.RecordCount GT 0>
        <!---<a href="TechnicalAudits_getEmpNo_Report_Output.cfm?page=TechnicalAudits_AddNC_ConfirmAll.cfm&ID=#URL.ID#&Year=#URL.Year#">
            Confirm NCs
        </a> for this Audit--->
        
        <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_SRCAR
        WHERE AuditID = #URL.ID#
        AND AuditYear = #URL.Year#
        </CFQUERY>
    
        <cfif isDefined("URL.SRCARStatus") AND URL.SRCARStatus eq "Completed" OR SRCAR.recordCount gt 0>
            <b>SR / CAR Information Entered</b><br />
        
            <table border="1">
            <tr>
                <th align="center">Issue Type</th>
                <th align="center">Number</th>
                <th align="center">Due Date</th>
                <th align="center">Additional SR/CAR Numbers</th>
                <th align="center">Edit</th>
            </tr>
            <cfoutput query="SRCAR">
            <tr>
                <td valign="top">#IssueType#</td>
                <td valign="top">#SRCARNumber#</td>
                <td valign="top">#Dateformat(SRCARClosedDueDate, "mm/dd/yyyy")#</td>
                <td valign="top"><cfif len(SRCAR_AdditionalNumbers)>#replace(SRCAR_AdditionalNumbers, ",", "<br />", "All")#<cfelse>N/A</cfif></td>
                <td valign="top"><a href="#IQADir#TechnicalAudits_SRCAR_Edit.cfm?SRCAR_ID=#ID#&ID=#URL.ID#&Year=#URL.Year#">Edit</a></td>
            </tr>
            </cfoutput>
            </table><br />
    
            <cfoutput>
                <B><font class="warning">Required Action</font></B> 
                :: 
                <A href="#IQADir#TechnicalAudits_getEmpNo_ReportUpload.cfm?page=TechnicalAudits_ReportUpload.cfm&ID=#URL.ID#&Year=#URL.Year#&Action=Non-Conformance Input Completed">
                    Upload Audit Report
                </A><br /><Br />
                Note - Taking this action confirms that the Non-Conformances above are entered correctly
            </cfoutput>
        <cfelse>
			<cfoutput>
        		<cfif len(Audit.SRCARType)>
					<cfif Audit.SRCARType eq "CAR">
                        <cfset vCAR = "Yes">
                    <cfelseif Audit.SRCARType eq "SR">
                        <cfset vCAR = "No">
                    </cfif>
                
                    <B><font class="warning">Required Action</font></B> 
                    :: 
                    <A href="#IQADir#TechnicalAudits_SRCAR_Add2.cfm?ID=#URL.ID#&Year=#URL.Year#&CAR=#vCAR#">
                        Enter SR / CAR Information
                    </A><br /><br />
				<cfelse>
                    <B><font class="warning">Required Action</font></B> 
                    :: 
                    <A href="#IQADir#TechnicalAudits_SRCAR_Add.cfm?ID=#URL.ID#&Year=#URL.Year#">
                        Enter SR / CAR Information
                    </A><br /><br />
				</cfif>
            </cfoutput>
        </cfif>
    <cfelse>
		<font class="warning"><b>Note</b></font>: In order to continue, a Non-Conformance (NC) or Could Not Be Determined (CNBD) Item must be added to the table above, as well as an NC After Appeal.
	</cfif>
<cfelseif Audit.NCExistPostAppeal eq "No">
	<!--- check if all categories have report/nc rows --->
    <cfif Validate.RecordCount GT 0>
		<cfoutput>
            <B><font class="warning">Required Action</font></B> 
            :: 
            <A href="#IQADir#TechnicalAudits_getEmpNo_ReportUpload.cfm?page=TechnicalAudits_ReportUpload.cfm&ID=#URL.ID#&Year=#URL.Year#&Action=Non-Conformance Input Completed">
                Upload Audit Report
            </A><br /><Br />
            Note - Taking this action confirms that the Non-Conformances above are entered correctly
        </cfoutput>
    <cfelse>
		<font class="warning"><b>Note</b></font>: In order to continue, a Non-Conformance (NC) or Could Not Be Determined (CNBD) Item must be added to the table above.
	</cfif>
</cfif>
<br /><br />