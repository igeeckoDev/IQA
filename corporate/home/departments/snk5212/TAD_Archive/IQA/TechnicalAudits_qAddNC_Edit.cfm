<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM 	TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<div align="Left" class="blog-time">
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

<!---
<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>
--->

<CFQUERY DataSource="UL06046" Name="SubItems" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
   TechnicalAudits_Categories.CategoryName, TechnicalAudits_Items.ItemName, TechnicalAudits_SubItems.ID, TechnicalAudits_SubItems.SubItem, TechnicalAudits_SubItems.ID as SubItemID, TechnicalAudits_Items.CategoryID
FROM 
	TechnicalAudits_Categories, TechnicalAudits_Items, TechnicalAudits_SubItems
WHERE 
	TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
    AND TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
    AND TechnicalAudits_Items.Status IS NULL
    AND TechnicalAudits_SubItems.Status IS NULL
    AND TechnicalAudits_Items.ID = #URL.ItemID#
ORDER BY 
	TechnicalAudits_Items.CategoryID, TechnicalAudits_Items.alphaOrder, TechnicalAudits_SubItems.SubItem
</CFQUERY>

<cfoutput>
Viewing Sub Items for <b>#SubItems.CategoryName#</b>: <b>#SubItems.ItemName#</b>
</cfoutput><br /><br />

<b><Font class="warning">Note</Font></b>: If you wish to add a carriage return and start a new paragraph in the Analysis field, add the characters <b>&lt;br&gt;</b> This will add one carriage return. (Add this tag twice for two carriage returns, etc)<br /><br />

<cfform action="#IQADir#TechnicalAudits_AddNC_Edit_Action.cfm?ItemID=#URL.ItemID#&ID=#URL.ID#&Year=#URL.Year#">

<Table border="1">
<tr>
    <th>Sub Item Name</th>
	<th>Number of NCs</th>
    <th>Number of CNBDs</th>
	<th>Number of NCs After Appeal</th>
    <th>Analysis</th>
</tr>
<cfoutput query="SubItems">
	<!--- get existing data --->
    <CFQUERY DataSource="UL06046" Name="getData" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT NC_OriginalCount as NC, NC_AfterAppealCount as NC_PostAppeal, CNBD_OriginalCount as CNBD, Analysis
    FROM TechnicalAudits_NC
    WHERE AuditYear = #URL.Year#
    AND AuditID = #URL.ID#
    AND SubItemID = #ID#
    </CFQUERY>

<tr>
	<td align="center" valign="top">#SubItem#</td>
    <td align="center" valign="top">
    	<cfinput type="text" name="NC_#SubItemID#" value="#getData.NC#" validate="integer" maxlength="2" size="2" message="Sub Item #ID# - Number of NCs - Numbers Only">
    </td>
    <td align="center" valign="top">
    	<cfinput type="text" name="CNBD_#SubItemID#" value="#getData.CNBD#" validate="integer" maxlength="2" size="2" message="Sub Item #ID# - Number of CNBDs - Numbers Only">
    </td>
    <td align="center" valign="top">
    	<cfinput type="text" name="NC_PostAppeal_#SubItemID#" value="#getData.NC_PostAppeal#" validate="integer" maxlength="2" size="2" message="Sub Item #ID# - Number of NCs After Appeal - Numbers Only">
    </td>
    <td>
    	<cftextarea name="Analysis_#SubItemID#" rows="5" cols="40">#getData.Analysis#</cftextarea>
    </td>
</tr>
</cfoutput>
</table>
<br /><br />

<cfinput type="Submit" name="Submit" value="Save Report Data">

<br /><br />
<b><Font class="warning">Note</Font></b>: If you wish to add a carriage return and start a new paragraph, add the characters <b>&lt;br&gt;</b><br />
This will add one carriage return. (Add this tag twice for two carriage returns, etc)
</cfform>