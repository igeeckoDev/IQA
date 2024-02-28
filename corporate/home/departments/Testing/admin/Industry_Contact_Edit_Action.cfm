<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Edit" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_Industry
SET 
Contact = '#Form.Contact#'
WHERE ID = #FORM.ID#
</CFQUERY>

<CFQUERY Name="Industry" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Industry, Contact
From TechnicalAudits_Industry
WHERE ID = #FORM.ID#
</CFQUERY>

<cflocation url="Industry.cfm?var=Contact&Industry=#Industry.Industry#&Contact=#Industry.Contact#" addtoken="no">