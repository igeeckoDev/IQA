<CFQUERY BLOCKFACTOR="100" NAME="RootCause" DataSource="Corporate">
SELECT * FROM CAR_RootCause
ORDER BY Category
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="MaxID" DataSource="Corporate">
SELECT MAX(ID) as MaxID FROM CAR_RootCause
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "CAR Root Cause Category - Configuration">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
    <script
        language="javascript"
        type="text/javascript"
        src="#CARDir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>

    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<cfif isDefined("Form.Category")>

	<CFQUERY BLOCKFACTOR="100" NAME="RootCause" DataSource="Corporate">
	SELECT * FROM CAR_RootCause
	WHERE Category = '#trim(Form.Category)#'
	</cfquery>

	<cfif RootCause.recordcount eq 0>

	<CFQUERY BLOCKFACTOR="100" NAME="Add" DataSource="Corporate">
	INSERT INTO CAR_RootCause(ID, Category, Description, Status)
	Values(#Form.ID#, '#Form.Category#', '#Form.Description#', 1)
	</cfquery>

		<cflocation url="RootCause_Add.cfm?duplicate=no&value=#form.Category#" addtoken="No">

	<cfelseif RootCause.recordcount neq 0>
		<cflocation url="RootCause_add.cfm?duplicate=yes&value=#form.Category#" addtoken="No">
	</cfif>

<cfelse>

<cfoutput>
<cfif isDefined("URL.Duplicate") AND isDefined("URL.Value")>
	<font color="red">Root Cause
	<cfif URL.Duplicate eq "No">
		[#URL.Value#] has been added to the Root Cause Category List
	<cfelseif URL.Duplicate eq "Yes">
		[#URL.Value#] already exists in the Root Cause Category List
	<cfelseif URL.Duplicate eq "Edit">
		[#URL.OldValue#] has been changed to <b>#URL.Value#</b>
	<cfelseif URL.Duplicate eq "Remove">
		[#URL.Value#] - Status has been changed to '#URL.Action#'
	<cfelseif URL.Duplicate eq "Cancel">
		[#URL.Value#] - Status change has been cancelled. Current status is '#URL.Action#'
	</cfif>
	</font><br><br>
</cfif>
</cfoutput>

<cfform name = "CarAdmin" action = "#CGI.SCRIPT_NAME#" method = "post">

<cfoutput>
	<cfset NewID = #MaxID.MaxID# + 1>
	<input name="ID" type="Hidden" Value="#NewID#">
</cfoutput>

Note - This page also serves as the Edit FAQ page for FAQ #26.<br /><br />

Add Root Cause<br>
<cfinput name="Category" type="Text" size="75" value="" required="Yes" message="Root Cause is a required field">
<br><br>

Root Cause Description<br>
<textarea WRAP="PHYSICAL" ROWS="10" COLS="60" NAME="Description">Please add comments to describe the Root Cause Category</textarea>
<br><br>

<input name="submit" type="submit" value="Submit"><br><br>

<Table border="1">
<tr>
<td align="center">Root Cause Category</td>
<td align="center">Description</td>
<td>View/Edit</td>
</tr>
<CFOUTPUT query="RootCause">
<tr valign="top">
<td>#Category# <cfif status eq 0><font color="red"><b>(removed)</b></font></cfif></td>
<td valign="top">#Description#</td>
<td align="center"><a href="RootCause_edit.cfm?ID=#ID#">edit</a></td>
</tr>

</CFOUTPUT>
</TABLE>

</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->