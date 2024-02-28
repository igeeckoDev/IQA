<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset SubTitle = "CAR Trend Reports - <a href=Report_Owners.cfm>Functional Group Owners</a> - Email Owner(s)">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<cflock scope="session" timeout="5">
	<CFQUERY NAME="getEmail" datasource="OracleNet" Timeout="600">
	SELECT employee_email as Email
	FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
	WHERE Employee_Number = '#SESSION.Auth.EmpNo#'
	</CFQUERY>
</cflock>

<cfif isDefined("Form.Submit") AND isDefined("FORM.Ready") AND Form.Ready eq "Yes">
	<cfdump var="#Form#">

<cfquery name="newID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as newID 
FROM GCAR_METRICS_SentEmail
</cfquery>

<cfif NOT len(newID.newID)>
	<cfset newID.newID = 1>
</cfif>

<cfif url.ID eq "All">
	<cfset vReportID = "All">
<cfelseif url.ID eq "Select">
	<cfset vReportID = "#URL.List#">
<cfelse>
	<cfset vReportID = "#URL.ID#">
</cfif>

<cfquery name="addRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO GCAR_METRICS_SentEmail(ID, SendTo, SendFrom, SendCC, Subject, LinkTo, EmailBody, SendDate, ReportID)
VALUES(#newID.newID#, <CFQUERYPARAM VALUE="#form.SendTo#" CFSQLTYPE="CF_SQL_CLOB">, '#Form.SendFrom#', <CFQUERYPARAM VALUE="#form.SendCC#" CFSQLTYPE="CF_SQL_CLOB">, '#Form.Subject#', '#Form.LinkTo#', <CFQUERYPARAM VALUE="#form.EmailBody#" CFSQLTYPE="CF_SQL_CLOB">, #CreateODBCDate(Form.SendDate)#, '#vReportID#')
</cfquery>

<cfquery name="selectRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM GCAR_METRICS_SentEmail
WHERE ID = #newID.newID#
</cfquery>

<cfmail 
	query="selectRow" 
	to="#SendTo#" 
    from="#SendFrom#" 
    cc="#SendCC#" 
    subject="#Subject#"
    failto="#SendFrom#"
    type="html"
    replyto="#SendFrom#">
    #EmailBody#
    
    Reference: <a href="#LinkTo#">#LinkTo#</a>
</cfmail>

<span class="warning">Email Sent.</span>
<br /><br />

<cfoutput query="selectRow">
<b>Date Sent</b><br />
#dateformat(SendDate, "mm/dd/yyyy")#<br /><br />

<b>To</b><br />
#replace(SendTo, ",", "<br />", "All")#<br /><br />

<cfif len(SendCC)>
<b>CC / FYI</b><br />
#replace(SendCC, ",", "<br />", "All")#<br /><br />
</cfif>

<b>From</b><br />
#SendFrom#<br /><br />

<b>Subject</b><br />
#Subject#<br /><br />

<b>Link</b><br />
<a href="#LinkTo#">#LinkTo#</a><br /><br />

<b>Email Body</b><br />
#EmailBody#<br /><br />
</cfoutput>

<u>Options</u><br />
:: <a href="Report_EmailOwner_History.cfm">View Email History</a><br />
:: <A href="Report_Owners.cfm">View Function Group Owners</A><br />
<cfelse>

<cfif url.ID eq "Select">
	<cfset lstEmails1 = "">
    <cfset lstCC1 = "">

	<cfloop index="ListElement" list="#URL.List#"> 
        <cfquery name="checkEmail" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT Owner, Function, FunctionField, SortField, CC
        FROM GCAR_Metrics_QReports
        WHERE ID = #ListElement#
        </cfquery>
        
        <cfoutput query="checkEmail">
        	<cfset lstEmails1 = listAppend(lstEmails1, "#Owner#")>
            <cfif len(CC)>
            	<cfset lstCC1 = listAppend(lstCC1, "#CC#")>
            </cfif>
        </cfoutput>
    </cfloop>
<cfelse>
    <cfquery name="SendEmail" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Owner, Function, FunctionField, SortField, CC
    FROM GCAR_Metrics_QReports
        <cfif url.ID EQ "All">
        WHERE ReportType = 'QE'
        ORDER BY Function
        <cfelse>
        WHERE ID = #URL.ID#
        </cfif>
    </cfquery>
</cfif>

<cfif url.ID EQ "All">
	<cfset lstEmails1 = "#valueList(SendEmail.Owner)#">
    <cfset lstEmails = ArrayToList(ListToArray(LstEmails1,','))>
    <cfset lstCC1 = "#valueList(SendEmail.CC)#">
    <cfset lstCC = ArrayToList(ListToArray(LstCC1,','))>
<cfelseif url.ID eq "Select">
	<cfset lstEmails = ArrayToList(ListToArray(lstEmails1, ','))>
    <cfset lstCC = ArrayToList(ListToArray(LstCC1,','))>
<cfelse>
	<cfset lstEmails = "#SendEmail.Owner#">
    <cfset lstCC = "#SendEmail.CC#">
</cfif>

<cfform name="SendEmail" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post">

<b>Date Sent</b><br />
<cfinput type="datefield" name="SendDate" value="#dateformat(now(), "mm/dd/yyyy")#" required="yes" size="25"><br />
<br /><br />

<B>To</B>:<br>
<cfoutput>
#replace(lstEmails, ",", "<br />", "All")#
<br /><br />
</cfoutput>
<cfinput type="hidden" name="SendTo" value="#lstEmails#">

<B>CC / FYI</B>:<br>
<cfoutput>
<cfif len(lstCC)>
	#replace(lstCC, ",", "<br />", "All")#
<cfelse>
	None Listed
</cfif>
<br><br />
</cfoutput>
<cfinput type="hidden" name="SendCC" value="#lstCC#">

<b>From</b>:<br />
<cfoutput>
#getEmail.Email#<br /><br />
</cfoutput>
<cfinput type="hidden" name="SendFrom" value="#getEmail.Email#">

<cfif url.ID EQ "All" OR url.ID eq "Select">
	<cfset varSubject = "GCAR Metrics CAR Trend Reports">
<cfelse>
	<cfset varSubject = "GCAR Metrics CAR Trend Reports - #SendEmail.Function#">
</cfif>
    
<B>Subject</B>:<br>
<cfinput type="text" name="Subject" value="#varSubject#" message="Required Field - Subject" required="Yes" size="75"><br><br>

<cfif url.ID EQ "All" OR url.ID eq "Select">
	<cfset varLinkTo = "http://usnbkiqas100p/departments/snk5212/GCARMetrics/Report.cfm">
<cfelse>
	<cfset varLinkTo = "http://usnbkiqas100p/departments/snk5212/GCARMetrics/Report_Details.cfm?ID=#URL.ID#">
</cfif>

<b>Link To Report</b>:<br />
<cfoutput>
<a href="#varLinkTo#">#varLinkTo#</a><Br /><br />
</cfoutput>
<cfinput type="hidden" name="LinkTo" value="#varLinkTo#" size="75">

<b>Email Text Box Use</b><br />
<u>Text Only</u> - no screenshots or images. Use formatting buttons included at bottom of text box.<br />
<u>Spacing</u> - Control+Enter for single space/carriage return, Enter for new paragraph.<Br />
<u>Preferred method of use</u> - either type into this text box and format as you go OR copy/paste contents from notepad. If your source is in Notes/Word/Etc, copy/paste into notepad, then into this text box.<br /><br />
  
<b>Email Text</B>:<br>
<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="EmailBody" required="yes" message="Required - Email Text"></textarea><br>

<b>Ready to Send Confirmation</b><Br />
<cfinput type="checkbox" name="Ready" value="yes" required="yes" message="Required Checkbox - Ready to Send Confirmation"> Check this box when you are ready to send this email, then press the Submit button below.<br /><br />

<input type="submit" name="Submit" value="Send Email Now">
</cfform>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->