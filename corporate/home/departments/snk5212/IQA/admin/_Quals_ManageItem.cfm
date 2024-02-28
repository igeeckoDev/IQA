<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="Manage Corporate IQA Auditors Qualification List Item">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="Qualification" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, QualificationName, Notes
From Qualification
WHERE ID = #URL.ID#
ORDER BY QualificationName
</CFQUERY>

<cfif structkeyexists(form, "Submit")>

<CFQUERY Name="Edit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE Qualification
SET

<cfif len(Form.Notes)>
Notes = '#Form.Notes#',
</cfif>
QualificationName = '#Form.QualificationName#'

WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="_Quals_Manage.cfm?msg=#Form.QualificationName# successfully edited" addtoken="no">

<cfelse>

<br>
<b>Edit Qualification Item</b>
<br><br>
<cfFORM METHOD="POST" name="form" action="#CGI.scriptName#?#CGI.Query_String#">

<cfoutput query="Qualification">

Qualification Name:<br>
<cfinput name="QualificationName" type="Text" size="70" value="#QualificationName#" required="yes" message="Please Enter the Qualification Name">
<br><br>

<script>
$(function () {
	$( ".input-boxes" ).popBox();
});
</script>

Notes:<br>
<cfinput value="#Notes#" class="input-boxes" name="Notes" type="text" />
<br><br>

</cfoutput>

<cfinput name="submit" type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->