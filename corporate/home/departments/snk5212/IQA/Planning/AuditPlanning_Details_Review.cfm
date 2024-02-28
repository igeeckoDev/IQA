<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<CFQUERY Name="qData" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM AuditPlanning2011
WHERE ID = #URL.ID#
</CFQUERY>

<cfif qData.Type eq "Program">
    <CFQUERY BLOCKFACTOR="100" name="qPType" Datasource="Corporate">
    SELECT ID, Program as pName, POEmail, PMEmail, SEmail
    FROM ProgDev
    WHERE ID = #qData.pID#
    </cfquery>   
<cfelseif qData.Type eq "Process">
    <CFQUERY BLOCKFACTOR="100" name="qPType" Datasource="Corporate">
    SELECT ID, Function as pName, Owner
    FROM GlobalFunctions
    WHERE ID = #qData.pID#
    </cfquery>
<cfelseif qData.Type eq "Site">
    <CFQUERY BLOCKFACTOR="100" name="qPType" Datasource="Corporate">
    SELECT OfficeName as PName 
    FROM IQAtblOffices
    WHERE ID = #qData.pID#
    </CFQUERY>
</cfif>

<cfif NOT isDefined("URL.View")>
Your submitted form information is shown below. If you need to make changes please select <u>Edit</u> below. Otherwise, please <u>Confirm</u> that you want to send this data to IQA below.<br><br>

<cfoutput>
<cfif qData.Quality eq "Yes">
	:: <a href="AuditPlanning_Quality_Details_Edit.cfm?ID=#URL.ID#">Edit</a>
<cfelseif qData.NACPO eq "Yes">
	:: <a href="AuditPlanning_NACPO_Details_Edit.cfm?ID=#URL.ID#">Edit</a>
<cfelse>
	<cfif qData.pID eq 0>
        :: <a href="AuditPlanning_New_Details_Edit.cfm?ID=#URL.ID#">Edit</a>
    <Cfelseif qData.pID neq 0>
        :: <a href="AuditPlanning_Details_Edit.cfm?ID=#URL.ID#">Edit</a>
    </Cfif>
</cfif><br />
:: <a href="AuditPlanning_Confirm.cfm?ID=#URL.ID#">Confirm</a><br><br>
</cfoutput>
</cfif>

<cfoutput query="qData">
   	<b>#Type# Name</b><Br>
    #qPType.pName#<Br><br>
    
    <cfif Type eq "Program">
        <cfif isDefined("qPType.POEmail") AND len(qPType.POEmail)>
        <b>Program Owner</b><br>
        #qPType.POEmail#<br><br />
        </cfif>
        
        <cfif isDefined("qPType.PMEmail") AND len(qPType.PMEmail)>
        <b>Program Manager</b><br>
        #qPType.PMEmail#<br><br />
        </cfif>
        
        <cfif isDefined("qPType.SEmail") AND len(qPType.SEMail)>
        <b>Program Specialist</b><br>
        #qPType.SEmail#<br><br>
        </cfif>
    <cfelse>
    	<cfif isDefined("qPType.Owner") AND len(qPType.Owner)>
    	<b>Process Owner(s)</b><br>
        #qPType.Owner#<br><br>
    	</cfif>
	</cfif>
    
    <b>Submitted By</b><br>
    #PostedBy# - #dateformat(Posted, "mm/dd/yyyy")# #timeformat(Posted, "hh:mm:ss tt")#<br><br>
    
    <b>1.</b> Are there any specific items you want us to concentrate on in 2011?<br>
    <u>Comments</u> #Focus#<Br><br>
    
    <b>2.</b> Are there any new/pending accreditor requirements affecting your Program?<br>
    #AccredRequirements#<Br>
    <cfif len(AccredRequirementsNotes)>
    <u>Comments</u> #AccredRequirementsNotes#<br>
    </cfif><br>
    
	<b>3.</b> IQA auditors are trained to ISO 17025, Guide 65, ISO 17021, ISO 17020, 510K requirements and ISO 9001. Are there any program specific training requirements that the auditor needs to complete to support your Program? If so, who can provide the training?<br>
    #TrainingRequirements#<Br>
    <cfif len(TrainingRequirementsTrainer)>
    Trainer Name: #TrainingRequirementsTrainer#<br>
    </cfif>
    <cfif len(TrainingRequirementsNotes)>
    <u>Comments</u> #TrainingRequirementsNotes#<br>
    </cfif><br>
    
    <b>4.</b> Are any major Program documentation changes pending/planned?<br>
    #DocChangesPending#<Br>
    <cfif len(DocChangesPendingNotes)>
    <u>Comments</u> #DocChangesPendingNotes#<br>
    </cfif><br>
    
    <b>5.</b> Are any Certification Office changes pending/planned for 2011?<br>
    #CertificationOfficeChanges#<Br>
    <cfif len(CertificationOfficeChangesNote)>
    <u>Comments</u> #CertificationOfficeChangesNote#<br>
    </cfif><br>

    <b>6.</b> Are any Laboratory changes pending/planned for 2011?<br>
    #LabLocationChanges#<Br>
    <cfif len(LabLocationChangesNotes)>
    <u>Comments</u> #LabLocationChangesNotes#<br>
    </cfif><br>
    
	<b>7</b>. Are there any scope of accreditation or scope of operations changes pending/planned?<br>
    #ScopeChangesPending#<Br>
    <cfif len(ScopeChangesPendingNotes)>
    <u>Comments</u> #ScopeChangesPendingNotes#<br>
    </cfif><br>
    
	<b>8</b>. Are there any EMC related changes pending/planned?<br>
    <cfif NOT len(EMCChanges)>No Response<cfelse>#EMCChanges#</cfif><Br>
    <cfif len(EMCChanges)>
    <u>Comments</u> #EMCChangesNotes#<br>
    </cfif><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->