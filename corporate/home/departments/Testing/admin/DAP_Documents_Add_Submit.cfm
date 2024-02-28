<CFQUERY Name="MaxID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as newID FROM DAP_Documents
</cfquery>

<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO DAP_Documents(ID, DocumentNumber, Title, CategoryID)
VALUES(#maxID.newID#, '#trim(Form.DocumentNumber)#', '#trim(Form.Title)#', #Form.CategoryID#)
</cfquery>

<cfmail to="06046@global.ul.com"
from="Internal.Quality_Audits@ul.com"
Subject="DAP Documents - Document Added"
type="html">
	<cfdump var="#Form#">
</cfmail>

<cflocation url="DAP_Documents.cfm" addtoken="No">