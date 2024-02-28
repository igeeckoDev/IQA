<CFQUERY Name="CCN" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_CCN
Order BY Status DESC, CCN
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - CCN List Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Add/View CCNs</b><br><br>

<cfoutput>
<cfif isDefined("URL.var")>
	<font color="red"> 
	<cfif URL.var eq "Add">
		<b>#URL.Value#</b> has been added.
	<cfelseif URL.var eq "Duplicate">
		<b>#URL.Value#</b> already exists.
	<cfelseif URL.var eq "Edit">
		<b>#URL.Value#</b> has been edited. Changed CCN name from <b>#URL.origValue#</b> to <b>#URL.Value#</b>.
    <cfelseif URL.var eq "NoEditChange">
		<b>#URL.Value#</b> - No change was made. CCN value did not change.
    <cfelseif URL.var eq "EditDuplicate">
		<b>#URL.Value#</b> already exists. Attempted to edit CCN name from <b>#URL.origValue#</b> to <b>#URL.Value#</b>. No action taken.
	<cfelseif URL.var eq "Status">
		<b>#URL.Value#</b> - Status has been changed to '#URL.Action#'.
    <cfelseif URL.var eq "Blank">
    	The form was submitted without a value. No action taken.
	</cfif>
	</font><br><br>
</cfif>
</cfoutput>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="CCN_update.cfm">

Add CCN:<br>
<input name="CCN" type="Text" size="70" value="" maxlength="5">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form><br>

<cfif CCN.recordCount gt 0>
<Table border="1">
<tr>
    <th width="200">CCN</th>
    <th width="50">Edit</th>
</tr>
<tr>
    <td colspan="2"><b><u>Status: Active</u></b></td>
</tr>
<cfset statusHolder = "">
<CFOUTPUT query="CCN">
	<cfif statusHolder IS NOT status> 
		<cfIf statusHolder IS NOT ""></cfif>
		<tr>
			<td colspan="2">
        	<b><u>Status: Removed</u></b>
			</td>
		</tr>
	</cfif>
        <tr>
        <td valign="top">#CCN#</td>
		<td align="center" valign="top">
        	<a href="CCN_edit.cfm?ID=#ID#"><img src="../images/ico_article.gif" border="0"></a>
        </td>
	</tr>
<cfset StatusHolder = Status>
</CFOUTPUT>
</TABLE>
<cfelse>
The CCN list is empty.
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->