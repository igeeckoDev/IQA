<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_AuditSchedule
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

<Cfoutput>
<b>SR / CAR Information</b><br>

<!---
Is Testing or Construction Review required as a result of the Audit Non-Conformances?<Br>
:: <a href="#IQADir#TechnicalAudits_SRCAR_Add2.cfm?#CGI.QUERY_STRING#&CAR=Yes">Yes</a><br>
:: <a href="#IQADir#TechnicalAudits_SRCAR_Add2.cfm?#CGI.QUERY_STRING#&CAR=No">No</a><br><br>
--->
</Cfoutput>

<CFQUERY DataSource="UL06046" Name="Reporting" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	TechnicalAudits_Categories.ID as CatID, TechnicalAudits_Categories.CategoryName,
    TechnicalAudits_Items.ID as ItemID, TechnicalAudits_Items.ItemName,
    TechnicalAudits_SubItems.ID as SubItemID, TechnicalAudits_SubItems.SubItem,
    TechnicalAudits_NC.ID as NCID, TechnicalAudits_NC.NC_AfterAppealCount as NC
FROM 
	TechnicalAudits_Categories, TechnicalAudits_Items, TechnicalAudits_SubItems, TechnicalAudits_NC
WHERE 
    TechnicalAudits_Categories.ID = TechnicalAudits_Items.CategoryID
    AND TechnicalAudits_Items.ID = TechnicalAudits_SubItems.ItemID
    AND TechnicalAudits_NC.SubItemID = TechnicalAudits_SubItems.ID
    AND TechnicalAudits_NC.NC_AfterAppealCount > 0
    AND TechnicalAudits_NC.AuditYear = #URL.Year#
    AND TechnicalAudits_NC.AuditID = #URL.ID#
ORDER BY 
	TechnicalAudits_Categories.alphaOrder, TechnicalAudits_Items.alphaOrder, TechnicalAudits_SubItems.SubItem
</CFQUERY>

<cfset CatHolder = "">
<cfset ItemHolder = "">

<Table border="1">
<tr valign="top">
    <th align="center">Category</th>
    <th align="center">Item</th>
    <th align="center">Sub Item</th>
    <th align="center">NCs After Appeal</th>
</tr>
<tr valign="top">
<cfoutput query="Reporting">
	<cfif NOT len(CatHolder)>
    	<td>#CategoryName#</td>
    <cfelseif CatHolder NEQ CategoryName>
   		<td colspan="4">&nbsp;</td>
	</tr>
        <cfset ItemHolder = "">
    <tr valign="top">
        <td>#CategoryName#</td>
    </cfif>
    
   	<cfif NOT len(ItemHolder)>
        <td>#ItemName#</td>
        <td align="center">#SubItem#</td>
        <td align="center"><b>#NC#</b></td>
    <cfelseif ItemHolder NEQ ItemName>
        <td>&nbsp;</td>
        <td>#ItemName#</td>
        <td align="center">#SubItem#</td>
        <td align="center"><b>#NC#</b></td>
    <cfelseif ItemHolder EQ ItemName>
    	<td colspan="2">&nbsp;</td>
        <td align="center">#SubItem#</td>
        <td align="center"><b>#NC#</b></td>
	</cfif>
	</tr>
    
<cfset CatHolder = CategoryName>
<Cfset ItemHolder = ItemName>
</cfoutput>
</table>
<br /><Br />

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfoutput>
<form action="TechnicalAudits_SRCAR_Add2.cfm?#CGI.Query_String#" enctype="multipart/form-data" method="post" name="myform" id="myform">

Is Testing or Construction Review required as a result of the Audit Non-Conformances?<Br /><br />

YES - Testing or Construction Review is required <input type="radio" name="Type" value="CAR" /><br />
NO - Testing or Construction Review is <b><font color="red">NOT</font></b> required  <input type="radio" name="Type" value="SR" /><br /><br />

<input type="submit" name="upload" value="Submit Form and Continue">
<input type="reset" name="upload" value="Reset Form"><br /><br />
</form>
</cfoutput>
    
<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">