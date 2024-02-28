<!--- Start of Page File --->
<cfinclude template="shared/StartOfPage.cfm">

<CFQUERY Name="qData" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * 
FROM AuditPlanning2011
WHERE ID = #URL.ID#
</CFQUERY>

Your submitted form information is shown below. If you need to make changes please select <u>Edit</u> below. Otherwise, please <u>Confirm</u> that you want to send this data to IQA below.<br><br>

<cfoutput>
:: <a href="AuditPlanning_New_Details_Edit.cfm?ID=#URL.ID#">Edit</a><br>
:: <a href="AuditPlanning_Confirm.cfm?ID=#URL.ID#">Confirm</a><br><br>
</cfoutput>

<cfoutput query="qData">
   	<b>#Type# Name</b><Br>
    #New_PName#<Br><br>
    
	<b>#Type# Owner / Manager</b><br />
    #New_OwnerManager#<br /><br />
    
    <b>Submitted By</b><br>
    #PostedBy# - #dateformat(Posted, "mm/dd/yyyy")# #timeformat(Posted, "hh:mm:ss tt")#<br><br>
    
    <b>1.</b> Are there any specific items you want us to concentrate on in 2011?<br>
    <u>Comments</u>: #Focus#<Br><br>
    
    <b>2.</b> Are there any new/pending accreditor requirements affecting your Program?<br>
    #AccredRequirements#<Br>
    <cfif len(AccredRequirementsNotes)>
    <u>Comments</u>: #AccredRequirementsNotes#<br>
    </cfif><br>
    
	<b>3.</b> IQA auditors are trained to ISO 17025, Guide 65, ISO 17021, ISO 17020, 510K requirements and ISO 9001. Are there any program specific training requirements that the auditor needs to complete to support your Program? If so, who can provide the training?<br>
    #TrainingRequirements#<Br>
    <cfif len(TrainingRequirementsTrainer)>
    <u>Trainer Name</u>: #TrainingRequirementsTrainer#<br>
    </cfif>
    <cfif len(TrainingRequirementsNotes)>
    <u>Comments</u>: #TrainingRequirementsNotes#<br>
    </cfif><br>
    
    <b>4.</b> Are any major Program documentation changes pending/planned?<br>
    #DocChangesPending#<Br>
    <cfif len(DocChangesPendingNotes)>
    <u>Comments</u>: #DocChangesPendingNotes#<br>
    </cfif><br>
    
    <b>5.</b> Are any Certification Office changes pending/planned for 2011?<br>
    #CertificationOfficeChanges#<Br>
    <cfif len(CertificationOfficeChangesNote)>
    <u>Comments</u>: #CertificationOfficeChangesNote#<br>
    </cfif><br>

    <b>6.</b> Are any Laboratory changes pending/planned for 2011?<br>
    #LabLocationChanges#<Br>
    <cfif len(LabLocationChangesNotes)>
    <u>Comments</u>: #LabLocationChangesNotes#<br>
    </cfif><br>
    
	<b>7</b>. Are there any scope of accreditation or scope of operations changes pending/planned?<br>
    #ScopeChangesPending#<Br>
    <cfif len(ScopeChangesPendingNotes)>
    <u>Comments</u>: #ScopeChangesPendingNotes#<br>
    </cfif><br>
</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="shared/EndOfPage.cfm">
<!--- /// --->