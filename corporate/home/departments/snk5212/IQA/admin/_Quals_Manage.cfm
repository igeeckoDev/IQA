<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Manage Corporate IQA Auditors Qualification List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Qualification" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, QualificationName, Notes, Status
From Qualification
ORDER BY Status DESC, QualificationName
</CFQUERY>

<cfif structkeyexists(form, "Submit")>

<CFQUERY Name="MaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID) + 1 as NewID From Qualification
</CFQUERY>

<CFQUERY Name="AddRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO Qualification(ID, QualificationName, Notes)
VALUES(#MaxID.NewID#, '#Form.QualificationName#', '#Form.Notes#')
</CFQUERY>

<cflocation url="_Quals_Manage.cfm?msg=#Form.QualificationName# added to Qualification List" addtoken="no">

<cfelse>

<cfif isDefined("URL.msg")>
	<Cfoutput>
    	<font color="red">#url.msg#</font><br /><br />
    </Cfoutput>
</cfif>

View <a href="_Quals.cfm">Auditor Qualification Table</a><br /><br />

<Table border="1">
<tr class="blog-title">
<td width="200">Qualification Name</td>
<td width="350">Notes</td>
<td width="50">Status</td>
<td width="50">Edit</td>
</tr>
<CFOUTPUT query="Qualification">
<tr class="blog-content">
<td valign="top">#QualificationName#</td>
<td><cfif len(Notes)>#Notes#<cfelse>No Notes Added</cfif></td>
<td valign="top"><cfif NOT len(Status)>Active<cfelse><font class="warning">#Status#</font></cfif></td>
<td valign="top" align="center"><a href="_Quals_ManageItem.cfm?ID=#ID#"><img src="../images/ico_article.gif" border="0"></a></td>
</tr>
</CFOUTPUT>
</TABLE>

<br>
<b>Add Qualification</b>
<br><br>
<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="_Quals_Manage.cfm">

Qualification Name:<br>
<cfinput name="QualificationName" type="Text" size="70" value="" required="yes" message="Please Enter the Qualification Name">
<br><br>

<script>
$(function () {
	$( ".input-boxes" ).popBox();
});
</script>

Notes:<br>
<cfinput class="input-boxes" name="Notes" type="text" size="75" />
<br><br>

<cfinput name="Submit" type="Submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->