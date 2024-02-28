<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=DAPClientList.cfm?Order=DA&Status=Active>DAP Client List</a> - Add DAP Client">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif structKeyExists(form,'submit')>
	<CFQUERY BLOCKFACTOR="100" name="check" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT ClientName, DAFileNumber
	FROM DAPClient
	WHERE ClientName = '#Form.ClientName#'
	OR DAFileNumber = #DAFileNumber#
	</cfquery>

	<cfif check.recordCount eq 0>
		<CFQUERY BLOCKFACTOR="100" name="newID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT MAX(ID)+1 as newID FROM DAPClient
		</cfquery>

		<CFQUERY BLOCKFACTOR="100" name="insertRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		INSERT INTO DAPClient(ID)
		VALUES(#newID.newID#)
		</cfquery>

		<CFQUERY BLOCKFACTOR="100" name="output" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		UPDATE DAPClient
		SET
		ACTL = <cfif len(Form.ACTL)>'#Form.ACTL#'<cfelse>null</cfif>,
		CBTL = <cfif len(Form.CBTL)>'#Form.CBTL#'<cfelse>null</cfif>,
		CTDP = <cfif len(Form.CTDP)>'#Form.CTDP#'<cfelse>null</cfif>,
		CTF = <cfif len(Form.CTF)>'#Form.CTF#'<cfelse>null</cfif>,
		TCP = <cfif len(Form.TCP)>'#Form.TCP#'<cfelse>null</cfif>,
		TPTDP = <cfif len(Form.TPTDP)>'#Form.TPTDP#'<cfelse>null</cfif>,
		CAP = <cfif len(Form.CAP)>'#Form.CAP#'<cfelse>null</cfif>,
		PPP = <cfif len(Form.PPP)>'#Form.PPP#'<cfelse>null</cfif>,
		Address1 = '#Form.Address1#',
		State = '#Form.State#',
		Country = '#Form.Country#',
		Region = '#Form.Region#',
		Status = '#Form.Status#',
		AuditCycle = #Form.AuditCycle#,
		AnniversaryDate = #CreateODBCDate(form.AnniversaryDate)#,
		ClientName = '#Form.ClientName#',
		DAFileNumber = #Form.DAFileNumber#

		WHERE ID = #newID.newID#
		</cfquery>

		<cflocation url="DAPClientList_Details.cfm?rowID=#newID.newID#" addtoken="no">
	<cfelse>
		<cfif check.ClientName eq Form.ClientName AND check.DAFileNumber eq Form.DAFileNumber>
			<!--- both fields found in other records --->
			<cflocation url="DAPClientList_Add.cfm?duplicate=yes&Field=ClientName&Value=#Form.ClientName#&Field2=DAFileNumber&Value2=#Form.DAFileNumber#" addtoken="no">
		<cfelseif check.DAFileNumber neq Form.DAFileNumber AND check.DAFileNumber eq Form.DAFileNumber>
			<!--- da file number found elsewhere --->
			<cflocation url="DAPClientList_Add.cfm?duplicate=yes&Field=DAFileNumber&Value=#Form.DAFileNumber#" addtoken="no">
		<cfelseif check.DAFileNumber eq Form.DAFileNumber AND check.DAFileNumber neq Form.DAFileNumber>
			<!--- client name found elsewhere --->
			<cflocation url="DAPClientList_Add.cfm?duplicate=yes&Field=ClientName&Value=#Form.ClientName#" addtoken="no">
		</cfif>
	</cfif>
<cfelse>
	<!---
	<script>
	$(function() {
		$( "#AnniversaryDate" ).datepicker({
		changeMonth: true,
		changeYear: true
		});
	});
	</script>
	--->

	<cfif isDefined("URL.duplicate") AND URL.duplicate eq "Yes">
		<cfoutput>
			<font class="warning"><b>Duplicate Record</b></font> DAP Client not added to database<br>
			#URL.Field# (#URL.Value#) exists in another record:

			<CFQUERY BLOCKFACTOR="100" name="findRecord" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT ID
			FROM DAPClient
			WHERE #URL.Field# = '#URL.Value#'
			</cfquery>

			<a href="DAPClientList_Details.cfm?rowID=#findRecord.ID#" target="_blank">View Record</a><br>

			<cfif isDefined("URL.Field2") AND isDefined("URL.Value2")>
				#URL.Field2# (#URL.Value2#) exists in another record:

				<CFQUERY BLOCKFACTOR="100" name="findRecord" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
				SELECT ID
				FROM DAPClient
				WHERE #URL.Field2# = '#URL.Value2#'
				</cfquery>

				<a href="DAPClientList_Details.cfm?rowID=#findRecord.ID#" target="_blank">View Record</a><br>
			</cfif><br>
		</cfoutput>
	</cfif>

	<CFQUERY BLOCKFACTOR="100" name="Regions" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT DISTINCT REGION
	FROM DAPClient
	WHERE 1 = 1
	AND (Status = 'Active')
	AND Length(Region) > 0
	ORDER BY Region
	</cfquery>

	<!--- included for Form Validation and Formatted Form Textarea boxes --->
	<!--- form name and id must be "myform" --->
	<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

	<cfFORM METHOD="POST" id="myform" name="myform" ENCTYPE="multipart/form-data" action="DAPClientList_Add.cfm">

	<b>Client Name</b><br>
	<cfinput type="text" Name="ClientName" size="80" data-bvalidator="required" data-bvalidator-msg="Client Name"><br><br>

	<b>DA File Number</b> (Numbers Only)<br>
	<cfinput type="text" Name="DAFileNumber" size="10" data-bvalidator="required" data-bvalidator-msg="DA File Number"><br><br>

	<b>Address</b><Br>
	<cfinput type="text" Name="Address1" size="80"><br><br>

	<b>State</b><br>
	<cfinput type="text" Name="State" size="20"><br><br>

	<b>Country</b><Br>
	<input type="text" Name="Country" size="20"><br><br>

	<cfoutput>
		<B>Region</B><br>
		<cfSELECT NAME="Region" data-bvalidator="required" data-bvalidator-msg="Region">
			<option value="">Select Region Below
			<cfloop query="Regions">
				<OPTION VALUE="#Region#">#Region#</OPTION>
			</cfloop>
		</cfSELECT><br><br>
	</cfoutput>

	<b>Status</b><br>
	<cfSELECT NAME="Status" data-bvalidator="required" data-bvalidator-msg="Status">
		<option value="">Select Status Below
		<OPTION value="Active">Active
		<OPTION value="Inactive">Inactive
	</cfSELECT><br><br>

	<b>Audit Cycle</b> (Years)<br>
	<cfSELECT NAME="AuditCycle" data-bvalidator="required" data-bvalidator-msg="Audit Cycle">
		<option value="">Select Audit Cycle Below
		<OPTION value="1">1
		<OPTION value="2">2
		<OPTION value="3">3
	</cfSELECT><br><br>

	<b>Anniversary Date</b><br>
	<cfINPUT TYPE="datefield" NAME="AnniversaryDate" validate="date" data-bvalidator="required" data-bvalidator-msg="Anniversary Date"><br><br>

	<b>DAP Participant Programs</b><br><br>

	<Table border="1">
		<tr>
			<th width="100">Program</th>
			<th width="100">Value</th>
		</tr>
		<tr>
			<td>ACTL</td>
			<td><cfinput type="text" Name="ACTL" size="20"></td>
		</tr>
		<tr>
			<Td>CBTL</Td>
			<td><cfinput type="text" Name="CBTL" size="20"></td>
		</tr>
		<tr>
			<Td>CTDP</Td>
			<td><cfinput type="text" Name="CTDP" size="20"></td>
		</tr>
		<tr>
			<Td>CTF Stage 3/4</Td>
			<td><cfinput type="text" Name="CTF" size="20"></td>
		</tr>
		<tr>
			<Td>TCP</Td>
			<td><cfinput type="text" Name="TCP" size="20"></td>
		</tr>
		<tr>
			<Td>TPTDP</Td>
			<td><cfinput type="text" Name="TPTDP" size="20"></td>
		</tr>
		<tr>
			<Td>CAP</Td>
			<td><cfinput type="text" Name="CAP" size="20"></td>
		</tr>
		<tr>
			<Td>PPP</Td>
			<td><cfinput type="text" Name="PPP" size="20"></td>
		</tr>
	</table><br><br>

	<input name="submit" type="submit" value="Add DAP Client">
	<input type="reset" value="Reset Form"><br /><br />
	</cfform>
</cfif>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->