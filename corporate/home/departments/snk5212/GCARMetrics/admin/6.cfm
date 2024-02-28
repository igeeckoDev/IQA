<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Administration Actions - Update GCAR Metrics Script 6">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

1. Remove History Column - Done<br />
2. Copy Data from NewImport to New table - Done<br />
3. Drop NewImport Table - Done<br />
3a. Remove Duplicate CARs - Done<br />
4. Field Updates - Done<br />
5. More Field Updates - Done<br />
6. Trim Fields

<cfsetting requestTimeOut="300">

<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARTypeNew, CARSubType, CARRootCauseCategory, CARType, docID, CARNumber
FROM GCAR_Metrics_New
ORDER BY CARNumber
</cfquery>

<cfset i = 0>
<cfoutput query="InsertData">
<!---
A) GCAR_Metrics: #CARNumber# #docID# #len(CARSubType)# #len(CARTypeNEW)# #len(CARRootCauseCategory)#<br>
--->

	<CFQUERY BLOCKFACTOR="100" NAME="InsertData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE GCAR_Metrics_New
	SET
	CARSubType = '#trim(CARSubType)#',
	CARTypeNEW = '#trim(CARTypeNew)#',
	CARRootCauseCategory = '#trim(CARRootCauseCategory)#',
	CARType = '#trim(CARType)#'

	WHERE CARNumber = '#CARNumber#'
	AND docID = '#docID#'
	</cfquery>

	<!---
	<CFQUERY BLOCKFACTOR="100" NAME="OutputData" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * FROM GCAR_Metrics
	WHERE CARNumber = '#CARNumber#'
	AND docID = '#docID#'
	</cfquery>

B) GCAR_Metrics: #outputData.CARNumber# #outputData.docID# #len(outputData.CARSubType)# #len(outputData.CARTypeNEW)# #len(outputData.CARRootCauseCategory)#<br><br>
	--->
<cfset i = i+1>
</cfoutput>

<cfoutput>
Trim Fields - #i# records reviewed.
</cfoutput><br /><br />

<cflocation url="7.cfm" addtoken="no">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->