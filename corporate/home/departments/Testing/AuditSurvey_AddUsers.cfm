<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="GetMonth">
SELECT Month, Year_ as Year, Email, Email2
FROM AuditSchedule
WHERE ID = 150
AND Year_ = 2014
</CFQUERY>

<cfset postDate = #now()#>

<!--- Primary Contact (Email field): get new ID for Audit Survey Users Table --->
<CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID
FROM AuditSurvey_Users
</CFQUERY>

<!--- add new User row --->
<CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO AuditSurvey_Users(ID, AuditID, AuditYear, SentTo, SentDate)
VALUES(#NewUserID.NewID#, 150, 2014, '#trim(getMonth.Email)#', #postdate#)
</CFQUERY>

<cfset emailList = ValueList(getMonth.Email2)>

<cfloop index = "ListElement" list = "#emailList#">
    <!--- Other Contacts (Email2 field): get new ID for Audit Survey Users Table --->
    <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(ID)+1 as NewID
    FROM AuditSurvey_Users
    </CFQUERY>
    
    <!--- add new User row --->
    <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO AuditSurvey_Users(ID, AuditID, AuditYear, SentTo, SentDate)
    VALUES(#NewUserID.NewID#, 15, 2014, '#trim(ListElement)#', #postdate#)
    </CFQUERY>
</cfloop>