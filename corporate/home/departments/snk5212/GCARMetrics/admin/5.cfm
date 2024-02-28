<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Administration Actions - Update GCAR Metrics Script 5">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

1. Remove History Column - Done<br />
2. Copy Data from NewImport to New table - Done<br />
3. Drop NewImport Table - Done<br />
3a. Remove Duplicate CARs - Done<br />
4. Field Updates - Done<br />
5. More Field Updates - <br /><br />

Health Canada - MMS Fix -
<cfinclude template="dbaMMS.cfm">
Done<br />

DAP - Internal Only Fix -
<cfinclude template="dbaDAP.cfm">
Done<br />

Global Labs / labs Fix -
<cfinclude template="dbaGlobalLabs.cfm">
Done<br />

Technical Competency Ampersand Removal -
<cfinclude template="dbaTechnicalCompetency.cfm">
Done<br />

Radio and Telecommunications Ampersand Removal -
<cfinclude template="dbaRadioAmpersand.cfm">
Done<br />

Building Analysis Ampersand Removal -
<cfinclude template="dbaBuildingAnalysis.cfm">
Done<br />

Sales and Marketing Fix -
<cfinclude template="dbaSM.cfm">
Done<br />

SCC Fix -
<cfinclude template="dbaSCC.cfm">
Done<br />

SCC IB Fix -
<cfinclude template="dbaSCCIB.cfm">
Done<br />

SCC ULC Mark Fix -
<cfinclude template="dbaSCCULCMark.cfm">
Done<br />

Ministry of Health, Labor and Welfare (MHLW) - PAL Fix (The dash appears to be em dash, and it should be en dash. whatever it actually is, it is not being imported correctly from Excel 2 Oracle) -
<cfinclude template="dbaEMDashFix.cfm">
Done<br />

Ottawa Fix (CARSiteAudited and CAROwnerReportingLocation) -
<cfinclude template="dbaOttawa.cfm">
Done<br />

ISO Guide 65 Fix (two similar entries) -
<cfinclude template="dbaISO65.cfm">
Done<br />

Italy (Agrate, Carugate) Fix -
<cfinclude template="dbaItaly.cfm">
Done<br />

Change All, N/A, and None to 'Process Concern' in the Program Affected field  -
<CFQUERY BLOCKFACTOR="100" NAME="AllNoneFix" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, CARProgramAffected
FROM GCAR_Metrics_New
WHERE
CARProgramAffected LIKE 'All%'
OR CARProgramAffected LIKE 'N/A%'
OR CARProgramAffected LIKE 'None%'
</cfquery>

<cfoutput query="AllNoneFix">
#CARNumber#<br>

	<CFQUERY BLOCKFACTOR="100" NAME="Update" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	Update GCAR_Metrics_New
	SET
	CARProgramAffected = 'Process Concern'

	WHERE
	CARNumber = '#CARNumber#'
	</cfquery>
</cfoutput>
<br />Done<br />

<a href="6.cfm">Advance</a>

<cflocation url="6.cfm" addtoken="no">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->