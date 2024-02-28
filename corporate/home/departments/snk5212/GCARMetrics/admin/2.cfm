<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Administration Actions - Update GCAR Metrics Script 2">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

1. Remove History Column - Done<br />
2. Copy Data from NewImport to New table -

<cfsetting requestTimeOut="300">

<CFQUERY BLOCKFACTOR="100" NAME="checkNewTable" Datasource="UL06046_IN">
SELECT * FROM GCAR_METRICS_NEW
</CFQUERY>

<cfif checkNewTable.recordCount eq 0>
	<CFQUERY BLOCKFACTOR="100" NAME="CopyData" Datasource="UL06046_IN">
	INSERT INTO GCAR_METRICS_NEW
	SELECT * FROM GCAR_METRICS_NEWIMPORT
	</CFQUERY>
</cfif>

Done<br />

<cflocation url="3.cfm" addtoken="no">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->