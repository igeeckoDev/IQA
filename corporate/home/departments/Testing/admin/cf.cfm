<CFQUERY Name="CF" Datasource="Corporate">
SELECT * From CorporateFunctions
Order BY Function
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Corporate Functions">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<br>
<Table border="1">
<tr class="blog-title">
<td width="300">Function</td>
<td width="250">Owner</td>
<td width="50">Edit</td>
</tr>
<CFOUTPUT query="CF">
<tr class="blog-content">
<td>#Function# <cfif Status is "Removed">- <font color="red"><strong>Removed</strong></font></cfif></td>
<td>#Owner#</td> 
<td align="center"><a href="cf_edit.cfm?ID=#ID#"><img src="../images/ico_article.gif" border="0"></a></td>
</tr>
</CFOUTPUT>
</TABLE>
<br>
<b>Add Corporate Function</b>
<br><br>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="AddCF_update.cfm">

Add Corporate Function:<br>
<input name="CF" type="Text" size="70" value="">
<br><br>

Owner Email: (external UL email address)<br>
<input name="Owner" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->