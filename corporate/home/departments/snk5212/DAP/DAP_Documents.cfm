<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Documents and Tools">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

This information is available on the <a href="https://ul.sharepoint.com/sites/DAP/SitePages/DAP-Documents-%26-Tools.aspx">DAP Sharepoint - Documents and Tools</a> page.<br><br>

<!---
Link to DAP Scope Report in datahub:<br>
<a href="http://datahub-reports.ul.com/Reports/report/Ops/DAP/Test Facility Scope Export to Excel" target="_blank">DataHub Report Test Facility Scope Export to Excel</a><br><br>

Link to DAP Scope Config Form:<Br>
<a href="http://dap.us.ul.com:8300/DAPAuditorForm/faces/xxul_dap/projectAssoc/AuditorMainPage.jspx?userId=13527" target="_blank">DAP Scope Config Form</a><br><br>

DAP CAS project Search Tool:<br>
<a href="http://datahub-reports.ul.com/Reports/report/Ops/DAP/DAP%20Program" target="_blank">View DAP CAS project search tool</a><br><br>

<cflock scope="session" timeout="6">
	<cfif isDefined("SESSION.Auth.isLoggedIn")>
		<cfif SESSION.Auth.IsLoggedInApp eq "IQA">
			Test by Standard Configuration: (The Tool to Approve/ Delete Test methods for a standards)<br>
			<a href="http://dap.us.ul.com:8300/DAPAdminForms/faces/xxul_dap/projectAssoc/jspx/TestByStandards.jspx?userId=13527" target="_blank">Test by Standard Configuration</a><br><Br>
		</cfif>
	</cfif>
</cflock>

DAP Assesment Project - Flex Dashboard (<b>DAPA</b>)<br>
<a href="https://portal.ul.com/Dashboard?EntityType=Dashboard&query=DAPA&Filters.DashboardPhase=InProgress&Filters.DashboardPhase=OnHold&Sorts%5b0%5d.FieldName=ariaUpdatedOn&Sorts%5b0%5d.Order=Descending" target="_blank">View DAPA Dashboard</a><br><br>

DAP Assesment Project - Flex Dashboard (<b>DAPE</b>)<br>
<a href="https://portal.ul.com/Dashboard?Query=DAPE&viewType=0&EntityType=Dashboard&Sorts%5B0%5D.FieldName=ariaUpdatedOn&Sorts%5B0%5D.Order=Descending&Filters.DashboardPhase=InProgress&Filters.DashboardPhase=OnHold&location=%2FDashboard" target="_blank">View DAPE Dashboard</a><br><br>

<cfset dcsLink = "http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/">

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
		ORDER BY Title
		</CFQUERY>

	<tr>
		<td valign="top" height="75">
		<cfloop query="DAP_Documents">
			<a href="#dcsLink##DocumentNumber#/#DocumentNumber#.docx">#DocumentNumber#</a><br>
			#Title#<cfif DAP_Documents.currentRow LT DAP_Documents.recordcount><br><br></cfif>
		</cfloop>
		</td>
	</tr>
	</cfoutput>
</table>
</td>
</cfloop>

</tr>
</table><br><Br>

<!---
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
<table border="1" cellspacing="0" cellpadding="0" width="225">
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
		WHERE CategoryID = #ID#
		ORDER BY DocumentID
		</CFQUERY>

		<cfloop query="DAP_Documents">
			<tr>
				<td valign="top" height="75">
					<p align="left">
						<a href="#dcsLink##DocumentNumber#/#DocumentNumber#.docx">#DocumentNumber#</a><br>
						#Title#
					</p>
				</td>
			</tr>
		</cfloop>
	</cfoutput>
</table>
</td>
</cfloop>

</tr>
</table>
--->
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->