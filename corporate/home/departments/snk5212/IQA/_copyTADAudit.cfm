<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID# AND Year_ = #URL.Year#
</cfquery>

<!--- get maxID --->
<CFQUERY BLOCKFACTOR="100" NAME="checkMaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(ID)+1 as maxID
FROM TechnicalAudits_AuditSchedule
WHERE Year_ = #URL.Year#
</CFQUERY>

<!--- get max xGUID --->
<CFQUERY BLOCKFACTOR="100" NAME="checkMaxGUID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(xGUID)+1 as maxGUID
FROM TechnicalAudits_AuditSchedule
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="newRow" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO TechnicalAudits_AuditSchedule(xGUID, ID, Year_, AuditedBy)
VALUES(#checkMaxGUID.maxGUID#, #checkMaxID.maxID#, #URL.Year#, '#Audit.AuditedBy#')
</CFQUERY>

<cfoutput query="Audit">
    <CFQUERY BLOCKFACTOR="100" NAME="newRow2" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    Month = #Month#,
    AuditType = '#AuditType#',
    AuditType2 = '#AuditType2#',
    Program = '#Program#',
    CCN = '#CCN#',
    FileNumber = '#FileNumber#',
    ProjectNumber = '#ProjectNumber#',
    OfficeName = '#OfficeName#',
    Industry = '#Industry#',
    Standard = '#Standard#',
    ProjectHandlerManager = '#ProjectHandlerManager#',
    ProjectHandlerManagerDept ='#ProjectPrimeReviewerDept#',
    ProjectHandlerManagerOffice ='#ProjectHandlerManagerOffice#',
    ProjectHandlerManagerEmail ='#ProjectHandlerManagerEmail#',
    ProjectHandler ='#ProjectHandler#',
    ProjectHandlerDept ='#ProjectHandlerDept#',
    ProjectHandlerOffice ='#ProjectHandlerOffice#',
    ProjectHandlerEmail ='#ProjectHandlerEmail#',
    EngManager ='#EngManager#',
    EngManagerEmail ='#EngManagerEmail#',
    EngManagerDirector ='#EngManagerDirector#',
    EngManagerDirectorEmail ='#EngManagerDirectorEmail#',
    EngManagerDirectorDept ='EngManagerDirectorDept##',
    EngManagerDirectorOfficeName ='#EngManagerDirectorOfficeName#',
    History ='#History#',
    Flag_CurrentStep ='#Flag_CurrentStep#',
    RequestType ='#RequestType#',
    Notes ='#Notes#',
    CCN2 ='#CCN2#',
    Standard2 ='#Standard2#',
    ProjectLink ='#ProjectLink#',
    Approved ='#Approved#',
    ApprovedDate = #CreateODBCDate(ApprovedDate)#,
    Region ='#Region#',
    SubRegion ='#SubRegion#'
    
    WHERE
    xGUID = #checkMaxGUID.maxGUID#
	</CFQUERY>
</cfoutput>

<cfoutput>
#checkMaxGUID.maxGUID#  / #URL.Year#-#checkMaxID.maxID# Created<br>
<a href="TechnicalAudits_AuditSchedule.cfm?ID=#checkMaxID.maxID#&Year=#URL.Year#">Link to Audit</a>
</cfoutput>