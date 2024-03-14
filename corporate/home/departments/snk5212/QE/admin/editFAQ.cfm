<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Edit FAQ Item #URL.ID#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("Form.Submit")>
	<cfquery name="preEdit" datasource="Corporate" blockfactor="100">
	SELECT *
    FROM CAR_FAQ
    WHERE ID = #url.id#
	</cfquery>

    <!---
	<!--- If there is an attached file, add it now --->
    <cfif len(Form.AttachedFile)>
    	<!--- upload the file, overwrite a similarly named file --->
        <CFFILE ACTION="UPLOAD"
        FILEFIELD="AttachedFile"
        DESTINATION="#CARPath#FAQ\"
        NAMECONFLICT="OVERWRITE">

        <!--- set filename variable to the filename of the file being uploaded via the submitted form --->
		<cfset FileName="#Form.AttachedFile#">

        <!--- rename the file to FAQ + FAQ ID from URL + file extension (example - FAQ1.doc) --->
        <cfset NewFileName="FAQ#URL.ID#-Attach.#cffile.ClientFileExt#">

        <!--- rename the uploaded file --->
        <cffile
            action="rename"
            source="#FileName#"
            destination="#CARPath#FAQ\#NewFileName#">
	</cfif>
	--->

	<!---
	<cfquery name="UpdateFAQ" datasource="Corporate" blockfactor="100">
	UPDATE CAR_FAQ
    SET
	Question='#form.question#',
	Content=<CFQUERYPARAM VALUE="#Form.Content#" CFSQLTYPE="CF_SQL_CLOB">,
	<cflock scope="Session" timeout="5">
		Added='#SESSION.Auth.Name#',
	</cflock>
    <!--- add file name to table --->
    <cfif len(Form.AttachedFile)>
		AttachedFile = '#NewFileName#',
	</cfif>
	Category='#Form.Category#'

    WHERE ID = #url.id#
	</cfquery>
	--->

	<cfquery name="FAQ" datasource="Corporate" blockfactor="100">
	SELECT *
    FROM CAR_FAQ
    WHERE ID = #url.id#
	</cfquery>

    <cfif Form.RevUpdate is "Yes">
	<!--- rev number update --->
    <CFQUERY BLOCKFACTOR="100" NAME="maxID" DataSource="Corporate">
    SELECT MAX(ID)+1 as maxID FROM CAR_FAQ_RH
    </CFQUERY>

    <CFQUERY BLOCKFACTOR="100" NAME="maxRevNo" DataSource="Corporate">
	SELECT MAX(RevNo)+1 as maxRevNo FROM CAR_FAQ_RH
	WHERE FAQID = #URL.ID#
	</CFQUERY>

	<cfset Dump = replace(Form.History, "<p>", "", "All")>
    <Cfset Dump2 = replace(Dump, "</p>", "<br /><Br />", "All")>
    <cfif Right(Dump2, 12) is "<br /><Br />">
        <cfset Dump3 = Left(Dump2, Len(Dump2)-12)>
    <cfelse>
        <cfset Dump3 = Dump2>
    </cfif>

    <CFQUERY BLOCKFACTOR="100" NAME="UpdateRevHist" DataSource="Corporate">
    INSERT INTO CAR_FAQ_RH(ID, FAQID, RevNo, RevDate, RevAuthor, RevComments)
    VALUES(#maxID.maxID#, #URL.ID#, #maxRevNo.maxRevNo#, #CreateODBCDate(curDate)#, '#SESSION.Auth.Name#', <CFQUERYPARAM VALUE="#dump3#" CFSQLTYPE="cf_sql_clob">)
    </CFQUERY>

    <cfset changeLogText = "Values prior to this revision<br />Question - #preEdit.Question#<br />Answer - #preEdit.Content#<br />Added/Edited By - #preEdit.Added#<br />Category - #preEdit.Category#">

    <CFQUERY BLOCKFACTOR="100" NAME="UpdateChangeLog" DataSource="Corporate">
    UPDATE CAR_FAQ_Rh
    SET
    ChangeLog_CLOB = <CFQUERYPARAM VALUE="#changeLogText#" CFSQLTYPE="cf_sql_clob">
    WHERE ID = #maxID.maxID#
    </CFQUERY>
    <!--- /// --->
    </cfif>

    <!--- emails --->
    <cfif Form.RevNotify is "Yes">
        <cfinclude template="incFAQNotify.cfm">

        <cfmail
        to="Internal.Quality_Audits@ul.com"
        from="Internal.Quality_Audits@ul.com"
        cc="#Emails2#, #Emails3#"
        bcc="Christopher.J.Nicastro@ul.com"
        query="FAQ"
        subject="CAR Process Web Site - FAQ ###ID# has been updated"
        type="html">
    CAR Process FAQ ###ID# has been updated by #Added# on #dateformat(curdate, "mmmm dd, yyyy")#. This item is categorized for <cfif Category is "Admin">CAR Admins<cfelseif Category is "Owner">CAR Owners<cfelseif Category is "Both">both CAR Admins and CAR Owners</cfif>.<br /><br />

    Change History:<br />
    #Dump3#<br /><br />

    Please follow the link below to view this FAQ Item:<br />
    #request.serverProtocol##request.serverDomain#/departments/snk5212/QE/FAQ.cfm###ID#
        </cfmail>
	</cfif>

<cfoutput>
	<cflocation url="#CARRootDir#FAQ.cfm###URL.ID#" addtoken="No">
</cfoutput>

<cfelse>

<cfoutput>
    <!---
	<cfif URL.ID NEQ "99">
        <script
            language="javascript"
            type="text/javascript"
            src="#CARDir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
        </script>

        <script language="javascript" type="text/javascript">
        tinyMCE.init({
            mode : "textareas",
            content_css : "#SiteDir#SiteShared/cr_style.css"
        });
        </script>
    </cfif>
	--->
</cfoutput>

	<cfquery name="EditFaq" datasource="Corporate" blockfactor="100">
	SELECT * FROM CAR_FAQ "FAQ" WHERE ID = #url.id#
	</cfquery>

	<cfif EditFAQ.status is "removed">
	This FAQ item has been removed.<br><br>
	<cfelse>

	<cfform name="editFaq" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post" enctype="multipart/form-data">
        <Cfoutput>
        <!---
	<B>Question</B><br>
	<cfinput type="text" name="question" value="#editFaq.question#" message="Please Enter the FAQ Item Title (Question)" required="Yes" size="75"><br><br>

    <Cfoutput>
	<b>Answer</B><br>
	<textarea WRAP="PHYSICAL" ROWS="35" COLS="100" NAME="Content">#EditFAQ.Content#</textarea><br><br>

	<cfif len(editFAQ.AttachedFile)>
    Current File Attachment - <a href="FAQ\#EditFAQ.AttachedFile#"><b>View</b></a><br /><br />
    </cfif>

    <!--- Attach a File --->
    <b>Attach a File</b><br />
    <cfinput type="File" size="50" name="AttachedFile" required="no">
    <br /><br />

	<cfinput type="radio" name="Category" value="Admin" checked="#iif(selValue eq "Admin", de("true"), de("false"))#"> Admin
	<cfinput type="radio" name="Category" value="Owner" checked="#iif(selValue eq "Owner", de("true"), de("false"))#"> Owner
	<cfinput type="radio" name="Category" value="Both" checked="#iif(selValue eq "Both", de("true"), de("false"))#"> Both
	<br><br>
	--->

<Br>
<!--- Rev History and Notifications --->
<b><u>Revision History Information and Notifications</u></b><br />
    
<cfset selValue=#editFaq.category#>
<b>FAQ Category</b> (Current Value: #selValue#)<Br />
</Cfoutput>

<cfif NOT len(editFAQ.Status)>
<u>Revision Number Update?</u><Br />
	<cfinput type="radio" name="RevUpdate" value="Yes" checked="Yes"> Yes<br>
	<cfinput type="radio" name="RevUpdate" value="No" checked="No"> No<br><br>

Change History/Notes: <font color="red">REQUIRED</font><br />
<textarea wrap="physical" name="History" rows="4" cols="75">Please provide a change history which will be included in the email notification. Even if this is a grammatical edit, please include the change history.</textarea>
<br /><br />

<u>Send Notification to CAR Admins about this FAQ change?</u><Br />
	<cfinput type="radio" name="RevNotify" value="Yes" checked="Yes"> Yes<br>
	<cfinput type="radio" name="RevNotify" value="No" checked="No"> No<br><br>
</cfif>
<!--- /// --->

	<cfif editFaq.include is "yes">
	 <b>Included File</b> (table, external data, etc)<br>
	 <Cfoutput>
	 	<a href="../FAQattachView.cfm?ID=#URL.ID#">view/edit</a><br><br>
	 </CFOUTPUT>
	</cfif>

	<input type="submit" name="submit" value="Edit FAQ Item">
	</cfform>

	</cfif>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->