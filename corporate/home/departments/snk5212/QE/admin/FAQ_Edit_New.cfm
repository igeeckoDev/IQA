<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Edit FAQ Item #URL.ID#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfquery name="EditFaq" datasource="Corporate" blockfactor="100">
SELECT *
FROM CAR_FAQ
WHERE ID = #url.id#
</cfquery>

<cfif isDefined("Form.Submit")>
<!---
	<cfquery name="UpdateFAQ" datasource="Corporate" blockfactor="100">
	UPDATE CAR_FAQ
    SET
	Content=<CFQUERYPARAM VALUE="#Form.Content#" CFSQLTYPE="CF_SQL_CLOB">
    WHERE ID = #url.id#
	</cfquery>
--->
	<cfset format = #replace(Form.Content, "<ul>", "<ul class=arrow3>", "All")#>
	<cfset format = #replace(Format, "<li>", "<li class=arrow3>", "All")#>
	<cfset format = #replace(Format, "<p>&nbsp;</p>", "<br>", "All")#>
	<cfset format = #replace(Format, "<p>", "", "All")#>
	<cfset format = #replace(Format, "</p>", "<br>", "All")#>
	<cfset format = #replace(Format, "&nbsp;", "", "All")#>

<table border=1 width=800>
<tr width="400">
	<td>
		Form Data:<Br>
		<cfdump var="#Form.content#"><bR><br>
	</td>
	<td>
		Formatted data:<Br>
		<cfdump var="#format#"><br><br>
	</td>
</tr>
<tr width="400" valign=top>
	<td>
		output of form data<br>
		<Cfoutput query="EditFaq">#content#</cfoutput><br><bR>
	</td>
	<td>
		output of new text<br>
		<cfoutput>#Format#</cfoutput>
	</td>
</tr>
</table>

<cfelse>

<Cfoutput query="EditFaq">
	<cfform name="editFaq" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post" enctype="multipart/form-data">

	<cfset format = #replace(Content, "<ul>", "<ul class=arrow3>", "All")#>
	<cfset format = #replace(Format, "<li>", "<li class=arrow3>", "All")#>
	<cfset format = #replace(Format, "<p>&nbsp;</p>", "<br>", "All")#>
	<cfset format = #replace(Format, "<p>", "", "All")#>
	<cfset format = #replace(Format, "</p>", "<br>", "All")#>
	<cfset format = #replace(Format, "&nbsp;", "", "All")#>

		<b>Answer</B><br>
		#Format#<br><br>

		<cftextarea richtext="yes" toolbar="Default" name="Content" width="700" height="500">#Format#</cftextarea>

		<input type="submit" name="submit" value="Save Changes">
	</cfform>
</cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->