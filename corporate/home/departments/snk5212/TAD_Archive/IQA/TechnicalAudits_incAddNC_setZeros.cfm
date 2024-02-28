<CFQUERY DataSource="UL06046" Name="Category" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	ID as CategoryID
FROM 
	TechnicalAudits_Categories
WHERE 
    Status IS NULL
ORDER BY
	ID
</CFQUERY>

<!--- get max ID --->
<CFQUERY Name="ID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(ID)+1 as maxID
FROM TechnicalAudits_NC
</CFQUERY>

<cfif NOT len(ID.MaxID)>
	<cfset ID.maxID = 1>
</cfif>

<!--- set max ID to newID --->
<cfset newID = ID.maxID>

<cfoutput query="Category">
    <!--- get item IDs for looping through query --->
    <CFQUERY DataSource="UL06046" Name="Items" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT 
       TechnicalAudits_Items.ID
    FROM 
        TechnicalAudits_Items
    WHERE 
        TechnicalAudits_Items.Status IS NULL
        AND TechnicalAudits_Items.CategoryID = #CategoryID#
    ORDER BY 
        TechnicalAudits_Items.ID
    </CFQUERY>
       
    <!--- loop through Items query to add data --->
    <cfloop query="Items"> 
        <!--- get subitem ID for looping through query --->
        <CFQUERY DataSource="UL06046" Name="SubItems" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT 
           TechnicalAudits_SubItems.ID
        FROM 
            TechnicalAudits_SubItems
        WHERE 
            TechnicalAudits_SubItems.Status IS NULL
            AND TechnicalAudits_SubItems.ItemID = #ID#
        ORDER BY 
            TechnicalAudits_SubItems.ID
        </CFQUERY>
        
        <cfloop index="ListElement" list="#ValueList(SubItems.ID)#">
            <!--- check if row exists --->
            <CFQUERY DataSource="UL06046" Name="checkRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT *
            FROM TechnicalAudits_NC
            WHERE AuditYear = #URL.Year#
            AND AuditID = #URL.ID#
            AND SubItemID = #ListElement#
            </CFQUERY>
    
            <cfif checkRow.recordcount eq 0>
                <!--- Add New Row --->
                <CFQUERY DataSource="UL06046" Name="EnterNCaddRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
                INSERT INTO TechnicalAudits_NC(ID, AuditYear, AuditID)
                VALUES(#newID#, #URL.Year#, #URL.ID#)
                </CFQUERY>
            
                <!--- add data to new row --->
                <CFQUERY DataSource="UL06046" Name="EnterNCaddDetails" username="#OracleDB_Username#" password="#OracleDB_Password#">
                UPDATE TechnicalAudits_NC
                SET 
                
                SubItemID = #ListElement#,
                NC_OriginalCount = 0,
                NC_AfterAppealCount = 0,
                CNBD_OriginalCount = 0,
                Analysis = 'N/A'
                
                WHERE ID = #newID#
                </CFQUERY>
                
                <!--- +1 to NewID --->
                <cfset newID = newID + 1>
            </cfif>
        </cfloop>
	</cfloop>
</cfoutput>