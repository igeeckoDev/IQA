<CFQUERY Name="Auditors" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM Auditors_VS
WHERE Type = 'VS'
Order BY Auditor
</CFQUERY>

<cfoutput query="Auditors">
    <cfif Form.Auditor is "#Auditor#">
        <cflocation url="VS_Auditors.cfm?msg=duplicate&id=#ID#" addtoken="no">
    </cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ID">
SELECT MAX(ID) + 1 AS newid FROM Auditors
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="AddID">
INSERT INTO Auditors_VS(ID)
VALUES (#ID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Add">
UPDATE Auditors_VS
SET 
Type='VS',
Auditor='#Form.Auditor#',
Email='#Form.Email#',
Location='#Form.Location#',
ActiveDate=#CreateODBCDate(Form.ActiveDate)#,
<cflock scope="SESSION" timeout="6">
History='Auditor Added #curdate#<br>Auditor=#Form.Auditor#<br>Email=#Form.Email#<br>Location=#Form.Location#<br>Active Date=#Form.ActiveDate#<br>Added by: #SESSION.Auth.Name#/#Session.Auth.UserName#'
</cflock>

WHERE ID=#ID.newid#
</CFQUERY>

<cflocation url="VS_Auditors.cfm?Auditor=#Form.Auditor#&msg=added&ID=#ID.newid#" addtoken="no">