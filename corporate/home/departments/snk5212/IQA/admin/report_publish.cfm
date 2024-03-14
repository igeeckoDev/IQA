<cfif Form.Publish is "Cancel">
	<cflocation url="Report_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">
<cfelseif Form.Publish is "Confirm to Publish Report">

<!--- add to confirm table --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT AuditedBy, Year_ AS Year
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cflock scope="Session" timeout="5">
	<cfif Check.AuditedBy eq "IQA">
		<cfif Check.year GTE 2016>
			<CFQUERY BLOCKFACTOR="100" name="Time" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			INSERT INTO IQAReportConfirm(ID, Year_, Confirm, Auditor)
			VALUES(#URL.ID#, #URL.Year#, '#Form.CONFIRMATION_CHECKBOX#', '#SESSION.Auth.Username#')
			</cfquery>
		</cfif>
	</cfif>
</cflock>

<!--- Report Marked Completed in Audit Schedule with publish date --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET

Report='Completed',
ReportDate=#CreateODBCDate(curdate)#

WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<!--- Report Publish Date entered in report --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE Report
SET

ReportDate=#CreateODBCDate(curdate)#

WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<!--- update log file --->
<cflog application="no"
	   file="iqaCompletedAudits"
	   text="Audit #URL.Year#-#URL.ID#-#AuditedBy# Completed"
	   type="Information">

<!--- Send Mail --->
<cfmail
    to="#Form.To#"
    from="#Form.From#"
    cc="#Form.CC#"
    bcc="#Form.BCC#"
    subject="#Form.Subject#"
    type="html"
    failto="Internal.Quality_Audits@ul.com"
    replyto="#Form.ReplyTo#">
    <cfoutput>
    #Form.BodyText#

    #Form.BodyText2#
    </cfoutput>
</cfmail>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="GetMonth">
SELECT Month, Year_ as Year, Email, Email2, AuditedBy
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</CFQUERY>

<cfif getMonth.AuditedBy eq "IQA" AND getMonth.Year EQ 2014 AND getMonth.Month GTE 4
	OR getMonth.AuditedBy eq "IQA" AND getMonth.Year GT 2014>
	<!--- store survey recipients, starting June 1 2014 audit completion --->

	<cfset postDate = #now()#>

	<!--- Primary Contact (Email field): get new ID for Audit Survey Users Table --->
    <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT MAX(ID)+1 as NewID
    FROM AuditSurvey_Users
    </CFQUERY>

    <!--- add new User row --->
    <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO AuditSurvey_Users(ID, AuditID, AuditYear, SentTo, SentDate)
    VALUES(#NewUserID.NewID#, #URL.ID#, #URL.Year#, '#trim(getMonth.Email)#', #postdate#)
    </CFQUERY>

    <cfset emailList = ValueList(getMonth.Email2)>

    <cfif len(emailList)>
        <cfloop index = "ListElement" list = "#emailList#">
            <!--- Other Contacts (Email2 field): get new ID for Audit Survey Users Table --->
            <CFQUERY BLOCKFACTOR="100" name="NewUserID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT MAX(ID)+1 as NewID
            FROM AuditSurvey_Users
            </CFQUERY>

            <!--- add new User row --->
            <CFQUERY Name="AddRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
            INSERT INTO AuditSurvey_Users(ID, AuditID, AuditYear, SentTo, SentDate)
            VALUES(#NewUserID.NewID#, #URL.ID#, #URL.Year#, '#trim(ListElement)#', #postdate#)
            </CFQUERY>
        </cfloop>
    </cfif>

	<!--- send survey, starting June 1 2014 audit completion --->
    <cfmail
        to="#getMonth.Email#, #getMonth.Email2#"
        cc="#Form.CC#"
        from="#Form.From#"
        failto="Internal.Quality_Audits@ul.com"
        subject="#Form.SurveySubject#"
        replyto="#Form.ReplyTo#"
        type="html">
        Thank you for participating in this Internal Quality Audit. We would greatly appreciate it if you can take a few minutes of your time to fill out the below survey. The survey will assist us in improving our current process.<br /><br />

        Please use the following link to complete the Audit Survey:<Br />
        <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/AuditSurvey.cfm?ID=#URL.ID#&year=#URL.Year#">#Form.SurveyBody#</a><br><br>

        If you wish to have additional staff complete this survey, simply forward this email to them, including the above link.<br /><br />

        If you have any questions or concerns please contact <a href="mailto:Global.InternalQuality@ul.com?Subject=#Form.SurveyBody#">Global Internal Quality</a><br /><br />
    </cfmail>
</cfif>

<cflocation url="Report_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">
</cfif>