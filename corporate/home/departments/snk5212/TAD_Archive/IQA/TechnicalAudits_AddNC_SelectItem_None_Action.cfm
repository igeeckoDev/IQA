<CFQUERY DataSource="UL06046" Name="Name" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	CategoryName
FROM 
	TechnicalAudits_Categories
WHERE 
    Status IS NULL
    AND ID = #URL.CategoryID#
</CFQUERY>

<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Add Non-Conformances - Select None for #Name.CategoryName#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

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

<!--- get max ID --->
<CFQUERY Name="ID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(ID)+1 as maxID
FROM TechnicalAudits_NC
</CFQUERY>

<cfif NOT len(ID.MaxID)>
	<cfset ID.maxID = 1>
</cfif>

<!--- get item IDs for looping through query --->
<CFQUERY DataSource="UL06046" Name="Items" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
   TechnicalAudits_Items.ID
FROM 
	TechnicalAudits_Items
WHERE 
    TechnicalAudits_Items.Status IS NULL
    AND TechnicalAudits_Items.CategoryID = #URL.CategoryID#
ORDER BY 
	TechnicalAudits_Items.ID
</CFQUERY>

<!--- set max ID to newID --->
<cfset newID = ID.maxID>

<!--- loop through Items query to add data --->
<cfoutput query="Items"> 
    <!--- get subitem ID for looping through query --->
    <CFQUERY DataSource="UL06046" Name="SubItems" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT 
       TechnicalAudits_SubItems.ID
    FROM 
        TechnicalAudits_SubItems
    WHERE 
        TechnicalAudits_SubItems.Status IS NULL
        AND TechnicalAudits_SubItems.ItemID = #ID#
    ORDER BY 
        TechnicalAudits_SubItems.ID
    </CFQUERY>
    
	<cfloop index="ListElement" list="#ValueList(SubItems.ID)#">
		<!--- check if row exists --->
        <CFQUERY DataSource="UL06046" Name="checkRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT *
        FROM TechnicalAudits_NC
		WHERE AuditYear = #URL.Year#
        AND AuditID = #URL.ID#
        AND SubItemID = #ListElement#
        </CFQUERY>

		<cfif checkRow.recordcount eq 0>
			<!--- Add New Row --->
            <CFQUERY DataSource="UL06046" Name="EnterNCaddRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
            INSERT INTO TechnicalAudits_NC(ID, AuditYear, AuditID)
            VALUES(#newID#, #URL.Year#, #URL.ID#)
            </CFQUERY>
        
            <!--- add data to new row --->
            <CFQUERY DataSource="UL06046" Name="EnterNCaddDetails" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_NC
            SET 
            
            SubItemID = #ListElement#,
            NC_OriginalCount = 0,
            NC_AfterAppealCount = 0,
            CNBD_OriginalCount = 0,
            Analysis = 'N/A'
            
            WHERE ID = #newID#
            </CFQUERY>
            
            <!--- +1 to NewID --->
            <cfset newID = newID + 1>
		</cfif>
	</cfloop>
</cfoutput>

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
	AND TechnicalAudits_NC.AuditYear = #URL.Year#
	AND TechnicalAudits_NC.AuditID = #URL.ID#
	AND TechnicalAudits_Categories.ID = #URL.CategoryID#
ORDER BY 
	TechnicalAudits_Categories.alphaOrder, TechnicalAudits_Items.alphaOrder, TechnicalAudits_SubItems.SubItem
</CFQUERY>
    
Non-Conformances Updated - None<Br /><br />

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

<Cfoutput>
<a href="#IQADir#TechnicalAudits_AddNC_SelectCategory.cfm?Year=#URl.Year#&ID=#URL.ID#">Confirm Selections</a><br /><br />
</Cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->