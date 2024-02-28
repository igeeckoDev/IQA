<CFQUERY Name="Standard" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
From TechnicalAudits_Standard
Order BY Status DESC, StandardName
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Internal Technical Audits - Standard List Control">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Add/View Standards</b><br><br>

<cfoutput>
<cfif isDefined("URL.var")>
	<font color="red"> 
	<cfif URL.var eq "Add">
		<b>#URL.Value#</b> has been added.
	<cfelseif URL.var eq "Duplicate">
		<b>#URL.Value#</b> already exists.
	<cfelseif URL.var eq "Edit">
		<b>#URL.Value#</b> has been changed from:<Br /><b>#URL.origValue#</b>.
    <cfelseif URL.var eq "NoEditChange">
		<b>#URL.Value#</b> - No change was made. No fields were changed.
    <cfelseif URL.var eq "EditDuplicate">
		<b>#URL.Value#</b> already exists. Attempted to edit Standard Name from <b>#URL.origValue#</b> to <b>#URL.Value#</b>. No action taken.
	<cfelseif URL.var eq "Status">
		<b>#URL.Value#</b> - Status has been changed to '#URL.Action#'.
    <cfelseif URL.var eq "Blank">
    	The form was submitted without all required values. No action taken.
	</cfif>
	</font><br><br>
</cfif>
</cfoutput>

<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="Standard_update.cfm">

Standard Name:<br>
<cfinput name="StandardName" type="Text" size="70" value="" required="yes">
<br><br>

Revision/Edition Number:<br>
<cfinput name="RevisionNumber" type="Text" size="70" value="" required="yes">
<br><br>

Revision/Edition Date: (mm/dd/yyyy)<br>
<div style="position:relative; z-index:3">
<cfinput type="datefield" name="RevisionDate" validate="date" maxlength="10" required="yes">
</div>
<br><br>

<input name="submit" type="submit" value="Submit"> 
</cfform><br>

<cfif Standard.recordCount gt 0>
<Table border="1">
<tr>
    <th width="200">Standard Name</th>
    <th width="50">Revision/Edition Number</th>
    <th width="75">Revision/Edition Date</th>
    <th width="50">Edit</th>
</tr>
<tr>
    <td colspan="4"><b><u>Status: Active</u></b></td>
</tr>
<cfset statusHolder = "">
<CFOUTPUT query="Standard">
	<cfif statusHolder IS NOT status> 
		<cfIf statusHolder IS NOT ""></cfif>
		<tr>
			<td colspan="4">
        	<b><u>Status: Removed</u></b>
			</td>
		</tr>
	</cfif>
        <tr>
        <td valign="top">#StandardName#</td>
        <td valign="top">#RevisionNumber#</td>
		<td valign="top">#dateformat(RevisionDate, "mm/dd/yyyy")#</td>
		<td align="center" valign="top">
        	<a href="Standard_edit.cfm?ID=#ID#"><img src="../images/ico_article.gif" border="0"></a>
        </td>
	</tr>
<cfset StatusHolder = Status>
</CFOUTPUT>
</TABLE>
<cfelse>
The Standard list is empty.
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->