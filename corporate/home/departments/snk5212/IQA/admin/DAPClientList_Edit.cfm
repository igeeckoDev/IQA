<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href=DAPClientList_Details.cfm?rowID=#URL.rowID#>DAP Client Details</a> - Edit Client Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<CFQUERY BLOCKFACTOR="100" name="output" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM DAPClient
WHERE ID = #URL.rowID#
</cfquery>

<cfif structKeyExists(form,'submit')>
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

	WHERE ID = #URL.rowID#
	</cfquery>

	<cflocation url="DAPClientList_Details.cfm?rowID=#URL.rowID#" addtoken="no">
<cfelse>
	<script>
	$(function() {
		$( "#AnniversaryDate" ).datepicker({
		changeMonth: true,
		changeYear: true
		});
	});
	</script>

	<cfoutput query="output">
		<FORM METHOD="POST" method ="post" id="myform" name="myform" ENCTYPE="multipart/form-data" action="#CGI.Script_Name#?#CGI.Query_String#">

		<b>Client Name</b><br>
		<input type="text" value="#ClientName#" Name="ClientName" size="80"><br><br>

		<b>DA File Number</b><br>
		<input type="text" value="#DAFileNumber#" Name="DAFileNumber" size="10"><br><br>

		<cfif len(status)>
			<cfset curStatus = Status>
		<cfelse>
			<cfset curStatus = "None Listed">
		</cfif>

		<b>Address</b><Br>
		<input type="text" value="#Address1#" Name="Address1" size="80"><br><br>

		<b>State</b><br>
		<input type="text" value="#State#" Name="State" size="20"><br><br>

		<b>Country</b><Br>
		<input type="text" value="#Country#" Name="Country" size="20"><br><br>

		<b>Region</b><br>
		<input type="text" value="#Region#" Name="Region" size="20"><br><br>

		<b>Status</b><br>
		<SELECT NAME="Status">
			<OPTION Value="#Status#" selected>#curStatus#
			<OPTION value="Active">Active
			<OPTION value="Inactive">Inactive
		</SELECT><br><br>

		<b>Audit Cycle</b><br>
		<SELECT NAME="AuditCycle">
			<OPTION Value="#AuditCycle#" selected>#AuditCycle#
			<OPTION value="1">1
			<OPTION value="2">2
			<OPTION value="3">3
		</SELECT><br><br>

		<Cfset curAnniversaryDate = dateformat(AnniversaryDate, "mm/dd/yyyy")>

		<div id="datepicker">
		<b>Anniversary Date</b><br>
		<INPUT ID="AnniversaryDate" TYPE="Text" NAME="AnniversaryDate" Value="#curAnniversaryDate#"><br><br>
		</div>

		<b>DAP Participant Programs</b><br>
		<cfif len(ACTL)>ACTL: #ACTL#<br></cfif>
		<cfif len(CBTL)>CBTL: #CBTL#<br></cfif>
		<cfif len(CTDP)>CTDP: #CTDP#<br></cfif>
		<cfif len(CTF)>CTF Stage 3/4: #CTF#<br></cfif>
		<cfif len(TCP)>TCP: #TCP#<br></cfif>
		<cfif len(TPTDP)>TPTDP: #TPTDP#<br></cfif>
		<cfif len(CAP)>CAP: #CAP#<br></cfif>
		<cfif len(PPP)>PPP: #PPP#<br></cfif>
		<br>

		<Table border="1">
			<tr>
				<th width="100">Program</th>
				<th width="100">Value</th>
			</tr>
			<tr>
				<td>ACTL</td>
				<td><input type="text" value="#ACTL#" Name="ACTL" size="20"></td>
			</tr>
			<tr>
				<Td>CBTL</Td>
				<td><input type="text" value="#CBTL#" Name="CBTL" size="20"></td>
			</tr>
			<tr>
				<Td>CTDP</Td>
				<td><input type="text" value="#CTDP#" Name="CTDP" size="20"></td>
			</tr>
			<tr>
				<Td>CTF Stage 3/4</Td>
				<td><input type="text" value="#CTF#" Name="CTF" size="20"></td>
			</tr>
			<tr>
				<Td>TCP</Td>
				<td><input type="text" value="#TCP#" Name="TCP" size="20"></td>
			</tr>
			<tr>
				<Td>TPTDP</Td>
				<td><input type="text" value="#TPTDP#" Name="TPTDP" size="20"></td>
			</tr>
			<tr>
				<Td>CAP</Td>
				<td><input type="text" value="#CAP#" Name="CAP" size="20"></td>
			</tr>
			<tr>
				<Td>PPP</Td>
				<td><input type="text" value="#PPP#" Name="PPP" size="20"></td>
			</tr>
		</table><br><br>

		<input name="Submit" type="Submit" value="Save Changes">
		</form>
	</cfoutput>
</cfif>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->