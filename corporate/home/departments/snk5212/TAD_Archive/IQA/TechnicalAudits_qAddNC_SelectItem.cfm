<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM 	TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfinclude template="#IQADir#TechnicalAudit_incAuditIdentifier.cfm">

<div align="Left" class="blog-time">
<br />
<b>Instructions</b><br />
<CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
</cfquery>
<cfoutput query="DocumentLinks">
See <a href="#HTTPLINK#">#HTTPLINKNAME#</a><br />
Section 9.12 Input Non-Conformances<br /><br />
</cfoutput>
</div>

<CFQUERY DataSource="UL06046" Name="Items" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	TechnicalAudits_Categories.CategoryName, TechnicalAudits_Items.ItemName, TechnicalAudits_Items.ID
FROM 
	TechnicalAudits_Categories, TechnicalAudits_Items
WHERE 
    TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
    AND TechnicalAudits_Categories.Status IS NULL
    AND TechnicalAudits_Items.Status IS NULL
	AND TechnicalAudits_Categories.ID = #URL.CategoryID#
ORDER BY 
	TechnicalAudits_Categories.alphaOrder, TechnicalAudits_Items.alphaOrder
</CFQUERY>

<cfoutput>
Viewing Items for Category: <b>#Items.CategoryName#</b><Br /><br />

Please enter NCs for each Item. If there are no NCs for any of the Items listed below, select the "None" link in the "If No NCs" column.<br /><Br />

Once you have entered NCs for each Item/Sub Item (or indicated "None"), a confirmation message/link will appear below the table.<Br /><Br />

If you want to select None for the all Items and SubItems, use the link on the bottom of the page listed as "Select None for all Items". (Only applicable if no Items have been entered)<Br /><br />
</cfoutput>

<cfset varAllDone = 0>

<Table border="1">
<tr>
    <th>Item Names</th>
    <th>Status - Add/Edit NCs</th>
    <th>If No NCs</th>
</tr>
<cfoutput query="Items">
	<td>#ItemName#</td>
    <td align="center">
    	<cfset Count = 0>
    
    	<CFQUERY DataSource="UL06046" Name="SubItems" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT ID as SubItemID
        FROM TechnicalAudits_SubItems
        WHERE ItemID = #ID#
        ORDER BY ID
        </CFQUERY>
        
	   	<cfloop query="SubItems">
            <CFQUERY DataSource="UL06046" Name="check" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT *
            FROM TechnicalAudits_NC
            WHERE AuditYear = #URL.Year#
            AND AuditID = #URL.ID#
            AND SubItemID = #SubItemID#
            </CFQUERY>
                      
            <Cfif check.recordcount eq 1>
            	<cfset Count = Count + 1>
			<cfelse>
            	<cfset Count = Count>
			</Cfif>
        </cfloop>
        
		<cfif Count eq SubItems.RecordCount>
        	Entered - 
            <A href="#IQADir#TechnicalAudits_AddNC_Edit.cfm?ItemID=#ID#&ID=#URL.ID#&Year=#URL.Year#">
    			Edit
        	</A>
            
            <cfset varAllDone = varAllDone + 1>
        <cfelse>
        	Not Entered - 
            <A href="#IQADir#TechnicalAudits_AddNC_Add.cfm?ItemID=#ID#&ID=#URL.ID#&Year=#URL.Year#">
    			Add
        	</A>
        </cfif>
	</td>
    <td align="center">
    	<cfif Count eq SubItems.RecordCount>
        	--
        <cfelse>
    		<a href="#IQADir#TechnicalAudits_AddNC_None_Action.cfm?ItemID=#ID#&ID=#URL.ID#&Year=#URL.Year#">None</a>
    	</cfif>
    </td>
</tr>
</cfoutput>
</table>
<br />

<cfoutput>
	<cfif Items.recordCount eq varAllDone>
        <a href="#IQADir#TechnicalAudits_AddNC_SelectCategory.cfm?ID=#URL.ID#&Year=#URL.Year#">
            Confirm NCs
        </a> for #Items.CategoryName#
    <cfelseif varAllDone eq 0>
        <a href="TechnicalAudits_AddNC_None_Category_Action.cfm?CategoryID=#URL.CategoryID#&#ID#&ID=#URL.ID#&Year=#URL.Year#">
        	Select None for all Items
         </a>
    </cfif><br /><br />
</cfoutput>

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
        AND TechnicalAudits_Categories.ID = #URL.CategoryID#
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
				<td colspan="5">&nbsp;</td>
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