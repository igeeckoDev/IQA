        <CFQUERY BLOCKFACTOR="100" name="InitialProgramAuditCheck" Datasource="Corporate">
        SELECT Count(*) as Count
        FROM AuditSchedule
        WHERE Area = 'D Mark (Denmark)'
        AND AuditType2 = 'Program'
        AND Year_ < 2012
        AND Status IS NULL
        AND AuditedBy = 'IQA'
        </CFQUERY>
        
         <CFQUERY BLOCKFACTOR="100" name="InitialSiteAuditCheck" Datasource="Corporate">
        SELECT Count(*) as Count
        FROM AuditSchedule
        WHERE OfficeName = 'Northbrook, Illinois'
        AND AuditType2 = 'Local Function'
        AND (Area = 'Processes' OR Area = 'Processes and Labs' OR Area = 'Laboratories')
        AND Year_ < 2012
        AND Status IS NULL
        AND AuditedBy = 'IQA'
        </CFQUERY>
        
        <CFQUERY BLOCKFACTOR="100" name="InitialSiteAuditCheck2" Datasource="Corporate">
        SELECT ID, Year_, Status
        FROM AuditSchedule
        WHERE OfficeName = 'Northbrook, Illinois'
        AND (Area = 'Processes' OR Area = 'Processes and Labs')
        AND Year_ < 2012
        AND Status IS NULL
        AND AuditedBy = 'IQA'
        </CFQUERY>
        
        <cfdump var="#InitialSiteAuditCheck#">
        <cfdump var="#InitialSiteAuditCheck2#">
        
        <cfoutput>
        #InitialSiteAuditCheck.Count#
        </cfoutput>