<CFQUERY Name="Industry" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_Industry
Order BY Status DESC, ID
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Industry List Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Add/View Industries</b><br><br>

<cfoutput>
<cfif isDefined("URL.var")>
	<font color="red"> 
	<cfif URL.var eq "Add">
		<b>#URL.Value#</b> has been added.
	<cfelseif URL.var eq "Duplicate">
		<b>#URL.Value#</b> already exists.
	<cfelseif URL.var eq "Edit">
		<b>#URL.Value#</b> has been edited. Changed Industry Name from <b>#URL.origValue#</b> to <b>#URL.Value#</b>.
    <cfelseif URL.var eq "NoEditChange">
		<b>#URL.Value#</b> - No change was made. Industry Nalue did not change.
    <cfelseif URL.var eq "EditDuplicate">
		<b>#URL.Value#</b> already exists. Attempted to edit Industry Name from <b>#URL.origValue#</b> to <b>#URL.Value#</b>. No action taken.
	<cfelseif URL.var eq "Status">
		<b>#URL.Value#</b> - Status has been changed to '#URL.Action#'.
    <cfelseif URL.var eq "Blank">
    	The form was submitted without a value. No action taken.
    <cfelseif url.var eq "Contact">
    	<b>#URL.Industry#</b> - Contact changed to <b>#URL.Contact#</b>.
	</cfif>
	</font><br><br>
</cfif>
</cfoutput>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="Industry_update.cfm">

Add Industry:<br>
<input name="Industry" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form><br>

<cfif Industry.recordCount gt 0>
<Table border="1">
<tr>
    <th width="200">Industry</th>
    <th width="50">Edit Name/Status</th>
    <th width="200">Contact</th>
    <th width="50">Edit Contact</th>
</tr>
<tr>
    <td colspan="4"><b><u>Status: Active</u></b></td>
</tr>
<cfset statusHolder = "">
<CFOUTPUT query="Industry">
	<cfif statusHolder IS NOT status> 
		<cfIf statusHolder IS NOT ""></cfif>
		<tr>
			<td colspan="4">
        	<b><u>Status: Removed</u></b>
			</td>
		</tr>
	</cfif>
        <tr>
        <td valign="top">#Industry#</td>
		<td align="center" valign="top">
        	<a href="Industry_edit.cfm?ID=#ID#"><img src="../images/ico_article.gif" border="0"></a>
        </td>
        <td valign="top"><cfif len(Contact)>#Contact#<cfelse>None Listed</cfif></td>
		<td align="center" valign="top">
        	<a href="Industry_Contact_edit.cfm?ID=#ID#"><img src="../images/ico_article.gif" border="0"></a>
        </td>
	</tr>
<cfset StatusHolder = Status>
</CFOUTPUT>
</TABLE>
<cfelse>
The Industry list is empty.
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->