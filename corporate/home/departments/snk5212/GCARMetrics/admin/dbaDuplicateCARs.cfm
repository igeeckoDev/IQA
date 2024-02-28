<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle = "Administration Actions - Find Duplicate CARs">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="KnownDuplicates" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, docID
FROM GCAR_Metrics_Duplicate_CARS
ORDER BY CARNumber
</cfquery>

Known Duplicates Deleted:<br />
<cfoutput query="KnownDuplicates">
CAR Number: #CARNumber# / docID: #docID#<br />
	<CFQUERY BLOCKFACTOR="100" NAME="DeletedDuplicates" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    DELETE FROM GCAR_Metrics_New
    WHERE
	docID = '#docID#'
    AND CARNumber = '#CARNumber#'
    </CFQUERY>
</cfoutput><br />

<cfif isDefined("URL.docID") AND isDefined("URL.CARNumber")>
	<cfoutput>
    	<span class="warning">
            Deleted the following row from the GCAR Metrics Table:<br />
        </span>
            <u>docID:</u> #URL.docID#<Br />
            <u>CAR Number:</u> #URL.CARNumber#
        <br /><br />
    </cfoutput>
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="Duplicates" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, COUNT(CARNumber) AS NumOccurrences
FROM GCAR_Metrics_New
WHERE CARNumber <> '09396253'
GROUP BY CARNumber
HAVING ( COUNT(CARNumber) > 1 )
ORDER BY CARNumber
</cfquery>

<cfif Duplicates.RecordCount gt 0>
	<b>Duplicate CARs Found</b><Br />
    <cfoutput query="Duplicates">
    #CARNumber# - #NumOccurrences#<br>
    </cfoutput><br>

    ONLY delete if it has been deleted from GCAR - check links (View CAR) below. A deleted CAR will show the following popup box in Lotus Notes:<br><br>

    <cfoutput>
    <img src="#SiteDir#SiteImages/GCARAdmin/invalidCAR.png" border="0" />
    </cfoutput><br /><br />

    If this message appears, select "delete from table" to remove this CAR from the GCAR Metrics table.<br /><br />

    <!---
	<span class="warning">
    NOTE: There are two VALID CARs with the CAR Number 09396253 - neither one can be deleted. They have been excluded from this duplicate CAR query.
    </span>
    <bR /><br />
	--->

    <cfoutput query="Duplicates">
        #CARNumber#<br>
        <CFQUERY BLOCKFACTOR="100" NAME="getDocID" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT CARNumber, docID
        FROM GCAR_Metrics_New
        WHERE CARNumber = #CARNumber#
        ORDER BY docID
        </CFQUERY>

        <cfloop query="getDocID">
		#docID# :: <a href="#GCARLink##docID#">View CAR</a> :: <a href="dbaDeleteRow.cfm?docID=#docID#&CARNumber=#CARNumber#">delete CAR</a><br>
        </cfloop><br>
    </cfoutput>
<cfelse>
	No Duplicates Found<br /><br />

    <a href="AdminMenu_DataUpdate.cfm?complete=5">Return to Weekly Data Refresh Instructions</a>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->