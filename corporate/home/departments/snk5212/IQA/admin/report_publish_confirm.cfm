<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Report - Publish Confirmation">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" NAME="Type" Datasource="Corporate">
SELECT ID, AuditedBy, YEAR_ as "Year", AuditType2, AuditType, OfficeName, Area
FROM AuditSchedule
WHERE Year_ = #URL.Year#
AND ID = #URL.ID#
</CFQUERY>

<cfif Type.AuditType2 is "Local Function"
	or Type.AuditType2 is "Local Function FS"
	or Type.AuditType2 is "Local Function CBTL">

	<!--- 
	FROM:
	IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM,
	IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, IQAtblOffices.Regional1, 
	IQAtblOffices.Regional2, IQAtblOffices.Regional3, 

	WHERE:
	AND TRIM(AuditSchedule.OfficeName) = TRIM(IQAtbloffices.OfficeName)

	removed from queries below on May 8 2017 --->
	
	<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
	SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2,
	AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AUDITSCHEDULE.YEAR_ as "Year",
	AuditSchedule.Approved, AuditSchedule.Area, AuditSchedule.AuditArea, AuditSchedule.SME
	FROM AuditSchedule
	WHERE AuditSchedule.Year_ = #URL.Year#
	AND AuditSchedule.ID = #URL.ID#
	</CFQUERY>

<cfelseif Type.AuditType2 is "Program">

	<!---
	<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
	SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2,
	AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AUDITSCHEDULE.YEAR_ as "Year",
	AuditSchedule.Area, AuditSchedule.AuditArea, AuditSchedule.Approved, ProgDev.Program, ProgDev.PMEmail, ProgDev.POEmail, ProgDev.SEMail, AuditSchedule.SME
	FROM AuditSchedule, ProgDev
	WHERE AuditSchedule.Year_ = #URL.Year#
	AND AuditSchedule.ID = #URL.ID#
	AND TRIM(AuditSchedule.Area) = TRIM(ProgDev.Program)
	</CFQUERY>
	--->

	<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
	SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2,
	AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.SME, 
	AuditSchedule.Area, AuditSchedule.Approved
	FROM AuditSchedule
	WHERE AuditSchedule.Year_ = #URL.Year#
	AND AuditSchedule.ID = #URL.ID#
	</CFQUERY>

<cfelseif Type.AuditType2 is "Corporate">

	<!---
	<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
	SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2,
	AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AUDITSCHEDULE.YEAR_ as "Year",
	AuditSchedule.Area, AuditSchedule.AuditArea, AuditSchedule.Approved, CorporateFunctions.Function, CorporateFunctions.Owner, AuditSchedule.SME
	FROM AuditSchedule, CorporateFunctions
	WHERE AuditSchedule.Year_ = #URL.Year#
	AND AuditSchedule.ID = #URL.ID#
	AND AuditSchedule.Area = CorporateFunctions.Function
	</CFQUERY>
	--->
	
	<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
	SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2,
	AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AUDITSCHEDULE.YEAR_ as "Year",
	AuditSchedule.Area, AuditSchedule.AuditArea, AuditSchedule.Approved, AuditSchedule.SME
	FROM AuditSchedule
	WHERE AuditSchedule.Year_ = #URL.Year#
	AND AuditSchedule.ID = #URL.ID#
	</CFQUERY>

<cfelseif Type.AuditType2 is "Global Function/Process">

	<!---
	<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
	SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2,
	AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AUDITSCHEDULE.YEAR_ as "Year",
	AuditSchedule.Area, AuditSchedule.AuditArea, AuditSchedule.Approved, GlobalFunctions.Function, GlobalFunctions.Owner, AuditSchedule.SME
	FROM AuditSchedule, GlobalFunctions
	WHERE AuditSchedule.Year_ = #URL.Year#
	AND AuditSchedule.ID = #URL.ID#
	AND AuditSchedule.Area = GlobalFunctions.Function
	</CFQUERY>
	--->

	<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
	SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2,
	AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AUDITSCHEDULE.YEAR_ as "Year",
	AuditSchedule.Area, AuditSchedule.AuditArea, AuditSchedule.Approved, AuditSchedule.SME
	FROM AuditSchedule
	WHERE AuditSchedule.Year_ = #URL.Year#
	AND AuditSchedule.ID = #URL.ID#
	</CFQUERY>
	
<cfelseif Type.AuditType2 is "Field Services">

	<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
	SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2,
	AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AUDITSCHEDULE.YEAR_ as "Year",
	AuditSchedule.Area, AuditSchedule.AuditArea, AuditSchedule.Approved, AuditSchedule.Desk, AuditSchedule.SME
	FROM AuditSchedule
	WHERE AuditSchedule.Year_ = #URL.Year#
	AND  AuditSchedule.ID = #URL.ID#
	</CFQUERY>

<cfelseif Type.AuditType2 is "MMS - Medical Management Systems">

	<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
	SELECT
	AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2,
	AuditSchedule.AuditType2, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AuditSchedule.Year_ AS "Year",
	AuditSchedule.Area, AuditSchedule.AuditArea, AuditSchedule.Approved, AuditSchedule.SME

	FROM
	AuditSchedule

	WHERE AuditSchedule.Year_ = #URL.Year#
	AND AuditSchedule.ID = #URL.ID#
	</CFQUERY>
</cfif>

<cfoutput query="Notify">
<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="report_publish.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#AuditedBy#">
<br>
Do you wish to publish the report for Audit #year#-#id#-#auditedby#?<br><br>

The following email will be sent when you publish this report:<br><br>

----------------------------------------------------------------<br>
<b>To:</b> #trim(Email)#<br>
<input name="To" value="#trim(Email)#" type="Hidden" />

<b>From:</b> Internal Quality Audits (Internal.Quality_Audits@ul.com)<br>
<input name="From" value="Internal.Quality_Audits@ul.com" type="Hidden" />

<cfset cc = "">
<b>cc:</b>
<cfif len(Email2)>
    <cfset CC = listAppend(CC, "#Email2#")>
</cfif>
<cfif len(SME)>
	<cfset SME = listAppend(CC, "#SME#")>
</cfif>

<cfif Type.auditedby is "IQA">
	<!---
		<cfif Type.AuditType2 is "Program">
			<cfset CC = listAppend(CC, "#trim(PMEmail)#")>
			<cfset CC = listAppend(CC, "#trim(POEmail)#")>
			<cfif len(SEMail)>
				<cfset CC = listAppend(CC, "#SEMail#")>
			</cfif>
			
			<!--- 
			site contacts : no longer added to audit report emails (as of May 8 2017)
			<cfif len(RQM)><cfset CC = listAppend(CC, "#RQM#")></cfif>
			<cfif len(QM)><cfset CC = listAppend(CC, "#QM#")></cfif>
			<cfif len(GM)><cfset CC = listAppend(CC, "#GM#")></cfif>
			<cfif len(LES)><cfset CC = listAppend(CC, "#LES#")></cfif>
			<cfif len(Other)><cfset CC = listAppend(CC, "#Other#")></cfif>
			<cfif len(Other2)><cfset CC = listAppend(CC, "#Other2#")></cfif>
			--->
			
		<cfelseif Type.AuditType2 is "Corporate">
			<cfset CC = listAppend(CC, "#trim(Owner)#")>
		<cfelseif Type.AuditType2 is "Global Function/Process">
			<cfset CC = listAppend(CC, "#trim(Owner)#")>
	 
			 <!--- 
			site contacts : no longer added to audit report emails (as of May 8 2017)
			<cfif len(RQM)><cfset CC = listAppend(CC, "#RQM#")></cfif>
			<cfif len(QM)><cfset CC = listAppend(CC, "#QM#")></cfif>
			<cfif len(GM)><cfset CC = listAppend(CC, "#GM#")></cfif>
			<cfif len(LES)><cfset CC = listAppend(CC, "#LES#")></cfif>
			<cfif len(Other)><cfset CC = listAppend(CC, "#Other#")></cfif>
			<cfif len(Other2)><cfset CC = listAppend(CC, "#Other2#")></cfif>
			--->
			
		<cfelseif Type.AuditType2 is "Local Function" OR Type.AuditType2 is "Local Function FS" OR Type.AuditType2 is "Local Function CBTL">

			<!--- 
			site contacts : no longer added to audit report emails (as of May 8 2017)
			<cfif len(RQM)><cfset CC = listAppend(CC, "#RQM#")></cfif>
			<cfif len(QM)><cfset CC = listAppend(CC, "#QM#")></cfif>
			<cfif len(GM)><cfset CC = listAppend(CC, "#GM#")></cfif>
			<cfif len(LES)><cfset CC = listAppend(CC, "#LES#")></cfif>
			<cfif len(Other)><cfset CC = listAppend(CC, "#Other#")></cfif>
			<cfif len(Other2)><cfset CC = listAppend(CC, "#Other2#")></cfif>
			--->

		</cfif>
	--->

    <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
    SELECT Email
    FROM AuditorList
    WHERE Auditor = '#LeadAuditor#'
    </CFQUERY>

    <cfset CC = listAppend(CC, "#AuditorEmail.Email#")>
    <input type="hidden" name="ReplyTo" value="#AuditorEmail.Email#" />

    <!--- add auditor field emails --->
    <cfif len(Auditor) AND Auditor neq "- None -">
        <cfloop index = "ListElement" list = "#Auditor#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset CC = listAppend(cc, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>

    <!--- add auditor in training field emails --->
    <cfif len(AuditorInTraining) AND AuditorInTraining neq "- None -">
        <cfloop index = "ListElement" list = "#AuditorInTraining#">
            <Cfoutput>
                <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                SELECT Email
                FROM AuditorList
                WHERE Auditor = '#trim(ListElement)#'
                </CFQUERY>

                <cfset CC = listAppend(cc, "#AuditorEmail.Email#")>
            </cfoutput>
        </cfloop>
    </cfif>
    <!--- /// --->
<cfelse>
	<cfif Type.AuditedBy is "Field Services" OR Type.AuditType2 is "Field Services">
        <cfset CC = listAppend(CC, "John.Carlin@ul.com, Clint.Ferguson@ul.com")>
        <input type="hidden" name="ReplyTo" value="John.Carlin@ul.com" />
	<cfelse>
        <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
        SELECT Email
        FROM AuditorList
        WHERE Auditor = '#LeadAuditor#'
        </CFQUERY>

        <cfset CC = listAppend(CC, "#AuditorEmail.Email#")>
        <input type="hidden" name="ReplyTo" value="#AuditorEmail.Email#" />

        <!--- add auditor field emails --->
        <cfif len(Auditor) AND Auditor neq "- None -">
            <cfloop index = "ListElement" list = "#Auditor#">
                <Cfoutput>
                    <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                    SELECT Email
                    FROM AuditorList
                    WHERE Auditor = '#trim(ListElement)#'
                    </CFQUERY>

                    <cfset CC = listAppend(cc, "#AuditorEmail.Email#")>
                </cfoutput>
            </cfloop>
        </cfif>

        <!--- add auditor in training field emails --->
        <cfif len(AuditorInTraining) AND AuditorInTraining neq "- None -">
            <cfloop index = "ListElement" list = "#AuditorInTraining#">
                <Cfoutput>
                    <CFQUERY BLOCKFACTOR="100" NAME="AuditorEmail" Datasource="Corporate">
                    SELECT Email
                    FROM AuditorList
                    WHERE Auditor = '#trim(ListElement)#'
                    </CFQUERY>

                    <cfset CC = listAppend(cc, "#AuditorEmail.Email#")>
                </cfoutput>
            </cfloop>
        </cfif>
        <!--- /// --->

<!---
		<cfif len(Regional1)><cfset CC = listAppend(CC, "#Regional1#")></cfif>
        <cfif len(Regional2)><cfset CC = listAppend(CC, "#Regional2#")></cfif>
        <cfif len(Regional3)><cfset CC = listAppend(CC, "#Regional3#")></cfif>
--->
		</cfif>
</cfif>
#replace(cc, ",", ", ", "All")#<br />
<input name="CC" value="#cc#" type="Hidden" />

<cfset bcc = "">
<b>bcc:</b>
<cfset bcc = listAppend(bcc, "Internal.Quality_Audits@ul.com")>
    <cflock scope="SESSION" timeout="60">
	    <cfset bcc = listAppend(bcc, "#SESSION.Auth.Email#")>
    </cflock>
#bcc#<Br />
<input name="bcc" value="#bcc#" type="Hidden" />

<!--- Fix for the PSE Mark difficulties with the cfmail subject line --->
<cfif Area eq "&lt;PS&gt;E Mark (JP) (JP CO)">
    <cfset incArea = "<PS>E Mark (JP) (JP CO)">
<!--- Fix for the PSE Mark difficulties with the cfmail subject line --->
<cfelseif Area eq "&lt;PS&gt;E Mark (JP) (US CO)">
    <cfset incArea = "<PS>E Mark (JP) (US CO)">
<!--- all other programs --->
<cfelse>
    <cfset incArea = "#Area#">
</cfif>
<!--- /// --->

<cfif AuditType2 eq "Program" OR AuditType2 is "MMS - Medical Management Systems">
	<cfset incSubject = "#Trim(incArea)#">
	<cfset incBody = "#Trim(Area)#">
<cfelseif AuditType2 eq "Field Services">
	<cfif Desk eq "Yes">
    	<cfset incSubject = "#trim(AuditArea)#">
		<cfset incBody = "#trim(AuditArea)#">
    <cfelse>
		<cfset incSubject = "#trim(OfficeName)# (#Trim(AuditArea)#)">
		<cfset incBody = "#trim(OfficeName)# (#Trim(AuditArea)#)">
	</cfif>
<cfelseif AuditType2 is "Corporate" or AuditType2 is "Local Function" or AuditType2 is "Local Function FS" or audittype2 is "Local Function CBTL" or audittype2 is "Global Function/Process">
	<cfif Area eq "Acquired Facility">
		<cfset incSubject = "#Trim(OfficeName)# - #Trim(AuditArea)#">
		<cfset incBody = "#Trim(OfficeName)# - #Trim(AuditArea)#">
    <cfelseif Area eq "Laboratories">
    	<cfset incSubject = "#Trim(OfficeName)# - #Trim(incArea)# [#Trim(AuditArea)#]">
		<cfset incBody = "#Trim(OfficeName)# - #Trim(Area)# [#Trim(AuditArea)#]">
	<cfelse>
    	<cfset incSubject = "#Trim(OfficeName)# - #Trim(incArea)#">
		<cfset incBody = "#Trim(OfficeName)# - #Trim(Area)#">
    </cfif>
</cfif>

<b>Subject:</b>
<cfif auditedby EQ "IQA">
	<cfset Subject = "IQA Audit Completed - Quality System Audit of #incSubject#">
<cfelse>
   	<cfset Subject = "#AuditedBy# Quality Audit Completed (#year#-#id#-#auditedby#)">
</cfif>
#Subject#<br><br>
<input name="Subject" value="#Subject#" type="Hidden" />
<input name="SurveySubject" value="Audit Survey - IQA Audit of #incSubject#" type="Hidden" />
<input name="SurveyBody" value="Audit Survey - IQA Audit of #incBody#" type="Hidden" />

<cfsavecontent variable="bodyText">
The Quality System Audit of <u>#incBody#</u> has been completed.<br /><br />

You can review the Audit Summary, Findings/Observations and Audit Coverage by following the link to the Audit Report below:<br />
<a href=http://usnbkiqas100p/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#>
http://usnbkiqas100p/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#
</a>
<br><br>

Audit Details:<br>
<a href=http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#>
http://usnbkiqas100p/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#
</a>
<br><br>

Please contact #LeadAuditor# for any questions or comments.<br /><br />
</cfsavecontent>
#bodyText#

<input name="bodyText" value="#bodyText#" type="hidden" />

<cfif Type.AuditType2 is "Local Function" or Type.AuditType2 is "Local Function FS" or Type.AuditType2 is "Local Function CBTL">
	<cfset responsibleParty = "The Local Quality Manager is">
<cfelseif Type.AuditType2 is "Program">
	<cfset responsibleParty = "The Program Manager and Program Owner are">
<cfelseif Type.AuditType2 is "Corporate">
	<cfset responsibleParty = "The Corporate Process Owner is">
<cfelseif Type.AuditType2 is "Global Function/Process">
	<cfset responsibleParty = "The Global Process Owner is">
<cfelseif Type.AuditType2 is "Field Services">
	<cfset responsibleParty = "The Field Service Quality Rep is">
<cfelseif Type.AuditType2 is "MMS - Medical Management Systems">
	<cfset responsibleParty = "The MMS Program Manager is">
</cfif>

<cfset bodyText2 = "#responsibleParty# responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.">
#bodyText2#
<input name="bodyText2" value="#bodyText2#" type="hidden" />

<br>----------------------------------------------------------------<br><br>

<!--- Explantion on how to access CARs for this audit with link to web help --->
* - <u>Primary Audit Contacts</u> are listed on the Audit Details page.<br>
<u>Global and Corporate Process Owners</u> are listed under Corporate Functions and Global Function/Process.<br>
<u>Program Managers and Program Owners</u> are listed on the UL Programs Master List.<br><br>

=============<br><br>

<b>Confirmation of Reporting the Accreditor and Regulatory Requirements in the Audit Documentation</b><br>
Please confirm that all applicable accreditor and regulatory requirements have been documented in the audit agenda, pathnotes, audit report, and audit coverage table.<br><br>

Confirm <cfinput type="radio" value="Confirmed" required="Yes" name="Confirmation_Checkbox"><br><br>

<INPUT TYPE="Submit" name="Publish" Value="Confirm to Publish Report">
<INPUT TYPE="Submit" name="Publish" Value="Cancel">

</cfFORM>
</cfoutput>

<!---
<!--- update log file --->
<cflog application="no"
	   date="YES"
	   file="iqaCompletedAudits"
	   text="Audit #URL.Year#-#URL.ID#-#AuditedBy# Test - #incSubject#"
	   time="YES"
	   thread="YES"
	   type="Information">

<cfmail to="Christopher.J.Nicastro@ul.com" from="Christopher.J.Nicastro@ul.com" Subject="Report Publication and Audit Survey - Code Test - Subject Line Test - #incSubject#" type="html">
Test Report Publication Body - #incBody#<br>
Test Audit Survey Email Body - Audit Survey - IQA Audit of #incBody#
</cfmail>
--->

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->