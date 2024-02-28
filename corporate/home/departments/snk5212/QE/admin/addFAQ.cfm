<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Add FAQ Item">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
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
</cfoutput>

	<cfquery name="FAQ" datasource="Corporate" blockfactor="100"> 
	SELECT MAX(ID)+1 as maxId FROM CAR_FAQ
    WHERE Status IS NULL
	</cfquery>

<cfif IsDefined("Form.Submit")>
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
        <cfset NewFileName="FAQ#FAQ.maxID#-Attach.#cffile.ClientFileExt#">
        
        <!--- rename the uploaded file --->
        <cffile
            action="rename"
            source="#FileName#"
            destination="#CARPath#FAQ\#NewFileName#">
	</cfif>
	
	<cfquery name="addFaq" datasource="Corporate" blockfactor="100"> 
	INSERT INTO CAR_FAQ "FAQ" (ID)
	VALUES(#FAQ.maxId#)
	</cfquery>	

	<cfquery name="UpdateFAQ" datasource="Corporate" blockfactor="100"> 
	UPDATE CAR_FAQ "FAQ" SET
	Question='#form.question#',
	Content='#form.content#',
	<!---
	<cfif include is "Yes">
		include='Yes',
	<cfelse>
		include='No',
	</cfif>
	--->	
	<cflock scope="Session" timeout="5">
		Added='#SESSION.Auth.Name#',
	</cflock>
    <!--- add file name to table --->
    <cfif len(Form.AttachedFile)>
		AttachedFile = '#NewFileName#',
	</cfif>
	Category='#Form.Category#'
	
	WHERE ID = #FAQ.maxId#
	</cfquery>
	
	<cfquery name="postEdit" datasource="Corporate" blockfactor="100"> 
	SELECT * FROM CAR_FAQ "FAQ" 
    WHERE ID = #faq.maxID#
	</cfquery>
    
	<!--- rev number update --->
    <CFQUERY BLOCKFACTOR="100" NAME="maxID" DataSource="Corporate">
    SELECT MAX(ID)+1 as maxID FROM CAR_FAQ_RH
    </CFQUERY>
    
    <CFQUERY BLOCKFACTOR="100" NAME="UpdateRevHist" DataSource="Corporate">
    INSERT INTO CAR_FAQ_RH(ID, FAQID, RevNo, RevDate, RevAuthor, RevComments)
    VALUES(#maxID.maxID#, #FAQ.maxID#, 1, #CreateODBCDate(curDate)#, '#SESSION.Auth.Name#', 'FAQ Item #FAQ.MaxID# added to CAR Process FAQ.')
    </CFQUERY>
    <!--- /// --->
    
    <!--- emails --->
    <cfinclude template="incFAQNotify.cfm">
	
	<cfmail 
	to="Internal.Quality_Audits@ul.com" 
    from="Internal.Quality_Audits@ul.com" 
    cc="#Emails2#, #Emails3#"
    bcc="Christopher.J.Nicastro@ul.com"
    query="postEdit" 
    subject="CAR Process Web Site - New FAQ Item">
A new CAR Process FAQ (Item #ID#) has been added by #Added# on #dateformat(curdate, "mmmm dd, yyyy")#. This item is categorized for <cfif Category is "Admin">CAR Admins<cfelseif Category is "Owner">CAR Owners<cfelseif Category is "Both">both CAR Admins and CAR Owners</cfif>.

Please follow the link below to view the new item:
http://usnbkiqas100p/departments/snk5212/QE/FAQ.cfm###ID#
	</cfmail>
		
<cfoutput>
	<cflocation url="../FAQ.cfm" addtoken="No">
</cfoutput>
<cfelse>

	<cfquery name="EditFaq" datasource="Corporate" blockfactor="100"> 
	SELECT * FROM CAR_FAQ "FAQ" WHERE ID = 0
	</cfquery>
	
	<cfform name="editFaq" action="#CGI.SCRIPT_NAME#" method="post" enctype="multipart/form-data">
	<B>Question</B> <cfoutput>(FAQ will be ###FAQ.maxID#)</cfoutput><br>
	<cfinput type="text" name="question" value="#editFaq.question#" message="Please Enter the FAQ Item Title (Question)" required="Yes" size="75"><br><br>
	
	<b>Answer</B><br>
	<cfoutput>

    <textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Content">#EditFAQ.Content#</textarea>
    <br><br>

    <!--- Attach a File --->
    <b>Attach a File</b><br />
    <cfinput type="File" size="50" name="AttachedFile" required="no">
    <br /><br />
	
	<b>FAQ Category</b><Br>
	<cfset selValue=#editFaq.category#>
	
	<cfinput type="radio" name="Category" value="Admin" checked="#iif(selValue eq "Admin", de("true"), de("false"))#"> Admin 
	<cfinput type="radio" name="Category" value="Owner" checked="#iif(selValue eq "Owner", de("true"), de("false"))#"> Owner 
	<cfinput type="radio" name="Category" value="Both" checked="#iif(selValue eq "Both", de("true"), de("false"))#"> Both
	<br><br>
	</cfoutput>
	
Note: If a table or other attachment is necessary for this FAQ, please contact <a href="mailto:Christopher.J.Nicastro@ul.com">Chris Nicastro</a> to post this item.<br /><br />

<!---
	<b>Include external data, table, etc?</b><br>
	<cfinput type="radio" name="include" value="Yes" checked="false"> Yes 
	<cfinput type="radio" name="include" value="No" checked="true"> No
	<br><br>

	Note: If you select Yes, Chris Nicastro will contact you to attach any external data to this FAQ item.<br><br>
--->
	
	<input type="submit" name="submit" value="Add New FAQ Item">
	</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->