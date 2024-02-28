<cfoutput>
	<cfset postDate = #now()#>
</cfoutput>

<cfif URL.UserID eq "Quality" OR URL.UserID eq "New">
	<!--- get new ID --->
    <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(ID)+1 as NewID
    FROM AuditPlanning_Users
    </CFQUERY>
    
    <cfif URL.UserID eq "Quality">
		<!--- extract Type and pID from Form.e_NameAndType --->
        <cfset Type = ListFirst(Form.e_NameAndType, ",")>
        <Cfset pID = ListLast(Form.e_NameAndType, ",")>
    
		<!--- add new User row --->
        <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning_Users(ID, Type, pID, SurveyType, SentTo)
        VALUES(#NewUserID.NewID#, '#Type#', '#pID#' , 'Quality', 'RQM Response')
        </CFQUERY>
	<cfelseif URL.UserID eq "New">
		<!--- add new User row --->
        <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        INSERT INTO AuditPlanning_Users(ID, Type, pID, SurveyType, SentTo, Request)
        VALUES(#NewUserID.NewID#, '#URL.UserID#', '0' , '#URL.UserID#', 'New Item Request', '#Form.e_Request#')
        </CFQUERY>
	</cfif>
    
<cfset URL.UserID = NewUserID.NewID>
</cfif>

<CFQUERY Name="ResponseCheck" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	PostedBy
FROM 
	AuditPlanning_Users
WHERE 
	ID = #URL.UserID#
</CFQUERY>

<CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE 
	AuditPlanning_Users
SET
    Responded='Yes',
    Posted=#postDate#,
<cfif len(ResponseCheck.PostedBy)>
	<!--- append new posted info to existing data to handle multiple responses --->
	PostedBy='#ResponseCheck.PostedBy#, #Form.PostedInfo#'
<cfelse>
    PostedBy='#Form.PostedInfo#'
</cfif>

WHERE 
	ID = #URL.UserID#
</CFQUERY>

<cfoutput>
    <cfloop index="i" from="1" to="13">
        <cfif isDefined("e_#i#_Answer")>
            <!--- if the question exists, add a record in the db --->
            <!--- get record count of Answers table --->
            <CFQUERY Name="CheckRows" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ID FROM AuditPlanning_Answers
            </CFQUERY>
            
            <cfif CheckRows.RecordCount gte 1>
                <CFQUERY Name="NewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT MAX(ID)+1 as NewID 
                FROM AuditPlanning_Answers
                </CFQUERY>
            <cfelse>
                <cfset NewID.NewID = 1>
            </cfif>
            
            <cfif isDefined("e_#i#_Notes")>
        		<cfif len(Evaluate("Form.e_#i#_Notes"))>
                	<cfset Notes = "#Evaluate("Form.e_#i#_Notes")#">
                <cfelse>
                	<cfset Notes = "None Listed">
                </cfif>
        	</cfif>
                    
            <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            INSERT INTO AuditPlanning_Answers(ID, qID, Answer, Notes, UserID)
            VALUES(#NewID.NewID#, #i#, '#Evaluate("Form.e_#i#_Answer")#', '#Notes#', #URL.UserID#)
            </CFQUERY>
            
            <cfif isDefined("e_#i#_ExtraField_Text")>
           		<cfif len(Evaluate("Form.e_#i#_ExtraField_Text"))>
                	 <CFQUERY Name="UpdateRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
                     UPDATE AuditPlanning_Answers
                     SET
                     ExtraField_Text = '#Evaluate("Form.e_#i#_ExtraField_Text")#'
                     WHERE
                     ID = #NewID.NewID#
                     </CFQUERY>
                </cfif>
        	</cfif>
        </cfif>
    </cfloop>
</cfoutput>

<cflocation url="2012_Details.cfm?UserID=#URL.UserID#" addtoken="no">