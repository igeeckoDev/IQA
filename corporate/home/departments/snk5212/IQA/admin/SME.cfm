<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Subject Matter Expert - List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY Name="SME" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM SME
ORDER BY Status DESC, SME
</cfquery>

<cfoutput>
<cfif isDefined("URL.var")>
	<font color="red">Subject Matter Expert
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

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKP" action="SME_update.cfm">

<b>Add Subject Matter Expert</b> (external email address):<br>
<input name="SME" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit">
</form><br><br>

<B>Subject Matter Expert (SME) List</B><br>
<cfif SME.RecordCount GT 0>
	<CFOUTPUT query="SME">
	- #SME#<cfif len(Status)> <font class="warning">(#Status#)</font></cfif> (<a href="SME_Edit.cfm?ID=#ID#">Edit</a>)<br>
	</CFOUTPUT>
<cfelse>
	None Listed<br>
</cfif><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->