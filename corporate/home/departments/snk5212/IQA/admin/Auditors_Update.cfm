<cfif form.Location eq "Select Site">
	<cflocation url="Auditors_Add.cfm?#Form.PreviousQueryString#&msg=Please Select a Location" addtoken="no">
</cfif>

<CFQUERY Name="Auditors" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * From Auditors
WHERE Type = '#URL.Type#'
Order BY Auditor
</CFQUERY>

<cfoutput query="Auditors">
	<cfif Form.Auditor is "#Auditor#">
        <cflocation url="Auditors.cfm?msg=duplicate&id=#ID#&Type=#URL.Type#" addtoken="no">
    </cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ID" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID) + 1 AS newid FROM Auditors
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="AddID" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO Auditors(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Add" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE Auditors
SET 
Type='#URL.Type#',
Auditor='#Form.Auditor#',
Email='#Form.Email#',
Location='#Form.Location#',
EmpNo='#Form.EmpNo#',
<cfif Type eq "TechnicalAudit">
    Dept='#Form.Department#',
</cfif>
ActiveDate=#CreateODBCDate(Form.ActiveDate)#,
<cflock scope="SESSION" timeout="6">
History='Auditor Added #curdate#<br>Auditor=#Form.Auditor#<br>Email=#Form.Email#<br>Location=#Form.Location#<br>Active Date=#Form.ActiveDate#<br>Added by: #SESSION.Auth.Name#/#Session.Auth.UserName#'
</cflock>

WHERE ID=#ID.newid#
</CFQUERY>

<cflocation url="Auditors.cfm?Auditor=#Form.Auditor#&msg=added&ID=#ID.newid#&Type=#URL.Type#" addtoken="no">