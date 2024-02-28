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

<CFQUERY DataSource="UL06046" Name="SubItems" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
   TechnicalAudits_Items.ItemName, TechnicalAudits_SubItems.ID, TechnicalAudits_SubItems.SubItem, TechnicalAudits_SubItems.ID as SubItemID, TechnicalAudits_Items.CategoryID
FROM 
	TechnicalAudits_Items, TechnicalAudits_SubItems
WHERE 
    TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
    AND TechnicalAudits_Items.Status IS NULL
    AND TechnicalAudits_SubItems.Status IS NULL
    AND TechnicalAudits_Items.ID = #URL.ItemID#
ORDER BY 
	TechnicalAudits_Items.CategoryID, TechnicalAudits_Items.alphaOrder, TechnicalAudits_SubItems.SubItem
</CFQUERY>

<cfoutput>
Viewing Sub Items for Item: <b>#SubItems.ItemName#</b>
</cfoutput><br /><br />

<cfform action="#IQADir#TechnicalAudits_AddNC_Action.cfm?ItemID=#URL.ItemID#&ID=#URL.ID#&Year=#URL.Year#">

<Table border="1">
<tr>
    <th>Sub Item Name</th>
	<th>Number of NCs</th>
    <th>Number of CNBDs</th>
    <th>Number of NCs After Appeal</th>
    <th>Analysis</th>
</tr>
<cfoutput query="SubItems">
<tr>
	<td align="center" valign="top">#SubItem#</td>
    <td align="center" valign="top">
    	<cfinput type="text" name="NC_#SubItemID#" value="0" validate="integer" maxlength="2" size="2" message="Sub Item #ID# - Number of NCs - Numbers Only">
    </td>
    <td align="center" valign="top">
    	<cfinput type="text" name="CNBD_#SubItemID#" value="0" validate="integer" maxlength="2" size="2" message="Sub Item #ID# - Number of CNBDs - Numbers Only">
    </td>
    <td align="center" valign="top">
    	<cfinput type="text" name="NC_PostAppeal_#SubItemID#" value="0" validate="integer" maxlength="2" size="2" message="Sub Item #ID# - Number of NCs After Appeal - Numbers Only">
    </td>
    <td>
    	<cftextarea name="Analysis_#SubItemID#" rows="5" cols="40">N/A</cftextarea>
    </td>
</tr>
</cfoutput>
</table>
<br /><br />

<cfinput type="Submit" name="Submit" value="Save Report Data">
</cfform>
