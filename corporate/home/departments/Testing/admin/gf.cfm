<CFQUERY Name="GF" Datasource="Corporate">
SELECT * From GlobalFunctions
Order BY Status DESC, Function
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Global Functions / Processes">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Add/View Global Functions / Processes</b><br><br>

<cfoutput>
<cfif isDefined("URL.var")>
	<font color="red">Global Function / Process
	<cfif URL.var eq "Add">
		[#URL.Value#] has been added
	<cfelseif URL.var eq "Duplicate">
		[#URL.Value#] already exists
	<cfelseif URL.var eq "Edit">
		[#URL.Value#] has been edited
	<cfelseif URL.var eq "Remove">
		[#URL.Value#] - Status has been changed to '#URL.Action#'
	</cfif>
	</font><br><br>
</cfif>
</cfoutput>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="AddGF_update.cfm">

Add Global Function/Process:<br>
<input name="GF" type="Text" size="70" value="">
<br><br>

Owner Email: (external UL email address)<br>
<input name="Owner" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>

<br>
<Table border="1">
<tr class="blog-title">
    <td class="blog-title">Function</td>
    <td class="blog-title">Owner</td>
    <td class="blog-title">Edit</td>
</tr>
<tr >
    <td colspan="3" class="blog-content"><b><u>Active</u></b></td>
</tr>
<cfset statusHolder = "">
<CFOUTPUT query="GF">
	<cfif statusHolder IS NOT status> 
		<cfIf statusHolder IS NOT ""></cfif>
		<tr class="blog-content">
			<td colspan="3" class="blog-content">
        	<b><u>Removed</u></b>
			</td>
		</tr>
	</cfif>
        <tr class="blog-content">
        <cfif status eq "removed">
            <td valign="top" class="blog-content">#Function# <font color="red">Removed</font></td>
            <td valign="top" class="blog-content">#replace(Owner, ",", "<br />", "All")#</td>
        <cfelse>
            <td valign="top" class="blog-content">#Function#</td> 
            <td valign="top" class="blog-content">#replace(Owner, ",", "<br />", "All")#</td> 
        </cfif>
		<td align="center" valign="top" class="blog-content">
        	<a href="gf_edit.cfm?ID=#ID#"><img src="../images/ico_article.gif" border="0"></a>
        </td>
	</tr>
<cfset StatusHolder = Status>
</CFOUTPUT>
</TABLE>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->