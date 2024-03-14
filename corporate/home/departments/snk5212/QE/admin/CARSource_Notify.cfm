<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate">
SELECT * FROM CARSource
WHERE ID = #URL.ID#
</cfquery>

<cfset csID = 12>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset subTitle = "CAR Source - Notification">
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

<cfif isDefined("Form.Submit")>

    <!--- emails --->
    <cfinclude template="incFAQNotify.cfm">
	
	<cfmail 
	to="Internal.Quality_Audits@ul.com" 
    from="Internal.Quality_Audits@ul.com" 
    cc="Christopher.J.Nicastro@ul.com"
    query="CARSource" 
    subject="CAR Process Web Site - #Form.Type# CAR Source (#CARSource#)"
    type="html">
    
<cfif Form.Type is "New">
A new CAR Source has been added to the CAR Source List.<Br>
<cfelseif Form.Type is "Edited">
A CAR Source has been edited in the CAR Source List.<br><Br>

Change History/Notes:<br>
#replace(Form.History, "<p>", "", "All")#
</cfif><br>

<u>CAR Source</u><br>
#CARSource#<br /><br>

<u>CAR Source Description</u><br>
#CARSource2#<br /><br>

<u>Corporate CAR Verification Responsibility</u><br>
#CorpCAR#<br /><br>

<u>Local CAR Verification Responsibility</u><br>
#LocalCAR#<br /><br>

<u>CAR Source Explanation</u><br>
#CARSource.Description#<br /><br />

View CAR Source Table<Br>
#request.serverProtocol##request.serverDomain#/departments/snk5212/QE/FAQ.cfm###csID#
	</cfmail>
    
    <cflocation url="CARSource_Add.cfm" addtoken="no">
    
<cfelse>

<cfform name = "CarAdmin" action = "#CGI.SCRIPT_NAME#?#CGI.Query_String#" method = "post">

<cfoutput query="CARSource">
<b>To</b>: CAR Admins<br />
<b>From</b>: CAR Process Web Site<br />
<b>Subject</b>: Changes to CAR Source Table<br /><br>

<b>Change Type</b><Br />
	<cfinput type="radio" name="Type" value="New" checked="Yes"> New CAR Source<br>
	<cfinput type="radio" name="Type" value="Edited" checked="No"> Edited CAR Source<br><br>

Change History/Notes: <font color="red">REQUIRED</font><br />
<textarea wrap="physical" name="History" rows="4" cols="75">Please provide a change history which will be included in the email notification.</textarea><br>

Note: The CAR Source details will be included in the email, as well as the Change History/Notes. Please be specific when explaining a change (edit) to CAR Source information.<br><br>

<input name="submit" type="submit" value="Send CAR Source Notification"><br><br>

</cfoutput>
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->