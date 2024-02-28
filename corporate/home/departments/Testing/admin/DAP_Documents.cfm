<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP - Documents - Manage">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<b>Available Actions</b>:<br>
 :: <a href="DAP_Documents.cfm">DAP Documents - Public Page</a><br>
 :: <a href="DAP_Documents_Add.cfm">Add Document</a><br><br>

<cfset dcsLink = "http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/">

<b>Table 1: Active Documents - shown on the DAP Documents Public Page</b><br>
<table border=0>
<tr valign=top>

<cfloop index=i from=1 to=4>
<CFQUERY BLOCKFACTOR="100" NAME="DAP_Documents_List" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CategoryName, ID
FROM DAP_Documents_Category
WHERE Status IS NULL
AND ID = #i#
ORDER BY ID
</CFQUERY>

<td>
<table border="1" cellspacing="1" cellpadding="1" width="255">
    <tr>
		<cfoutput query="DAP_Documents_List" group="CategoryName">
	    	<th width="225" valign="top" height="50">
	        	<p align="center">
	            	#CategoryName#
	            </p>
	        </th>
		</cfoutput>
	</tr>

	<cfoutput query="DAP_Documents_List">
		<CFQUERY BLOCKFACTOR="100" NAME="DAP_Documents" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT ID as DocumentID, DocumentNumber, Title
		FROM DAP_Documents
		WHERE Status IS NULL
		AND CategoryID = #ID#
		ORDER BY DocumentID
		</CFQUERY>

	<tr>
		<td valign="top" height="75">
		<cfloop query="DAP_Documents">
			<a href="#dcsLink##DocumentNumber#/#DocumentNumber#.docx">#DocumentNumber#</a><br>
			#Title#<br>
			<cflock scope="Session" timeout="5">
				<cfif isDefined("SESSION.Auth")>
        			<cfif SESSION.Auth.AccessLevel eq "SU"
						OR SESSION.Auth.Username eq "Ziemnick"
						OR SESSION.Auth.Username eq "Aoyagi">
					[<a href="DAP_Documents_Edit.cfm?ID=#DocumentID#">Edit</a>]
					</cfif>
				</cfif>
			</cflock>
			<cfif DAP_Documents.currentRow LT DAP_Documents.recordcount><br><br></cfif>
		</cfloop>
		</td>
	</tr>
	</cfoutput>
</table>
</td>
</cfloop>

</tr>
</table><br><Br>

<b>Table 2: Removed Documents - not shown on the DAP Documents Public Page</b><br>
<table border=0>
<tr valign=top>

<cfloop index=i from=1 to=4>
<CFQUERY BLOCKFACTOR="100" NAME="DAP_Documents_List" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CategoryName, ID
FROM DAP_Documents_Category
WHERE Status IS NULL
AND ID = #i#
ORDER BY ID
</CFQUERY>

<td>
<table border="1" cellspacing="1" cellpadding="1" width="255">
    <tr>
		<cfoutput query="DAP_Documents_List" group="CategoryName">
	    	<th width="225" valign="top" height="50">
	        	<p align="center">
	            	#CategoryName#
	            </p>
	        </th>
		</cfoutput>
	</tr>

	<cfoutput query="DAP_Documents_List">
		<CFQUERY BLOCKFACTOR="100" NAME="DAP_Documents" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT ID as DocumentID, DocumentNumber, Title
		FROM DAP_Documents
		WHERE Status = 'removed'
		AND CategoryID = #ID#
		ORDER BY DocumentID
		</CFQUERY>

	<tr>
		<td valign="top" height="75">
		<cfloop query="DAP_Documents">
			<a href="#dcsLink##DocumentNumber#/#DocumentNumber#.docx">#DocumentNumber#</a><br>
			#Title#<br>
			<cflock scope="Session" timeout="5">
				<cfif isDefined("SESSION.Auth")>
        			<cfif SESSION.Auth.AccessLevel eq "SU"
						OR SESSION.Auth.Username eq "Ziemnick"
						OR SESSION.Auth.Username eq "Aoyagi">
					[<a href="DAP_Documents_Edit.cfm?ID=#DocumentID#">Edit</a>]
					</cfif>
				</cfif>
			</cflock>
			<cfif DAP_Documents.currentRow LT DAP_Documents.recordcount><br><br></cfif>
		</cfloop>
		</td>
	</tr>
	</cfoutput>
</table>
</td>
</cfloop>

</tr>
</table><br><Br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->