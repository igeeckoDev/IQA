<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Auditor List - Auditor Profiles">
<cfinclude template="#SiteDir#SiteShared/StartOfPage_test.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="test" Datasource="Corporate">
SELECT Auditor, LastName
FROM AuditorList
WHERE (Status = 'Active' OR Status = 'In Training')
ORDER BY Auditor
</CFQUERY>

<cfoutput query="test">
<u>#Auditor#</u><br />
CAR Admin - 
	<CFQUERY BLOCKFACTOR="100" name="test" Datasource="Corporate">
    SELECT Name, Status 
    FROM CARAdminList
    WHERE Name = '#Auditor#'
    </CFQUERY>
    
    <cfif test.recordcount gt 0>
        <cfloop query="test">
        #Name# (#Status#)
        </cfloop>
    <cfelse>
    	<b>No</b><br />
        CAR Admins with same last name: 
            <CFQUERY BLOCKFACTOR="100" name="test2" Datasource="Corporate">
            SELECT Name, Status, ID
            FROM CARAdminList
            WHERE LastName = '#LastName#'
            </CFQUERY>

			<cfif test2.recordcount gt 0>
                <cfloop query="test2">
                #Name# (#Status#)
                </cfloop>
            <cfelse>
            	<b>No</b>
			</cfif>
	</cfif><br /><br />
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->