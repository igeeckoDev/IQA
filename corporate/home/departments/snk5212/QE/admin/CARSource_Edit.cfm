<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate">
SELECT * FROM CARSource
WHERE ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset subTitle = "CAR Source - Edit/Delete">
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

<cfif isDefined("Form.CARSource")>

<!--- FAQ Item Number 12 for CAR Source Table --->
<cfset csID = 12>

<CFQUERY BLOCKFACTOR="100" NAME="Add" DataSource="Corporate">
UPDATE CARSource
SET
<cfif Form.CARSource2 neq "">
CARSource2 = '#Form.CARSource2#',
<cfelse>
CARSource2 = null,
</cfif>
<cfif Form.Description neq "">
Description = '#Form.Description#',
<cfelse>
Description = null,
</cfif>
CARSource = '#Form.CARSource#',
CorpCAR = '#Form.CorpCAR#',
LocalCAR = '#Form.LocalCAR#'

WHERE ID = #URL.ID#
</cfquery>

<cfif Form.RevUpdate is "Yes">
<!--- is the rev number being updated? --->
<CFQUERY BLOCKFACTOR="100" NAME="maxRevNo" DataSource="Corporate">
SELECT MAX(RevNo)+1 as maxRevNo FROM CAR_FAQ_RH
WHERE FAQID = #csID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="maxID" DataSource="Corporate">
SELECT MAX(ID)+1 as maxID FROM CAR_FAQ_RH
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
VALUES(#maxID.maxID#, #csID#, #maxRevNo.maxRevNo#, #CreateODBCDate(curDate)#, '#SESSION.Auth.Name#', '#Dump3#')
</CFQUERY>
<!--- /// --->
</cfif>

<cfif Form.RevNotify is "Yes">
<!--- Notification being sent? --->
    <!--- emails --->
    <cfinclude template="incFAQNotify.cfm">
	
	<cfmail 
	to="Internal.Quality_Audits@ul.com" 
    from="Internal.Quality_Audits@ul.com" 
    cc="#Emails2#, #Emails3#"
    bcc="Christopher.J.Nicastro@ul.com"
    query="CARSource" 
    subject="CAR Process Web Site - Edited CAR Source (#CARSource#)"
    type="html">
CAR Source Information for <b>#CARSource#</b> has been edited in FAQ 12/CAR Source Table.<br><Br>

<u>Change History</u><br>
#Dump3#

<u>CAR Source</u><br>
#CARSource#<br /><br>

<u>CAR Source Description</u><br>
#CARSource2#<br /><br>

<u>Corporate CAR Verification Responsibility</u><br>
#CorpCAR#<br /><br>

<u>Local CAR Verification Responsibility</u><br>
#LocalCAR#<br /><br>

<u>CAR Source Explanation</u><br>
#Dump3#<br /><br />

View CAR Source Table<Br>
http://usnbkiqas100p/departments/snk5212/QE/FAQ.cfm###csID#
	</cfmail>
<!--- /// --->
</cfif>

<cflocation url="CARSource_Add.cfm?duplicate=Edit&value=#form.CARSource#&oldvalue=#CARSource.CARSource#" addtoken="No">

<cfelse>

<cfform name = "CarAdmin" action = "#CGI.SCRIPT_NAME#?#CGI.Query_String#" method = "post">

<cfoutput>
Edit CAR Source <b>#CARSource.CARSource#</b><br>
<cfinput name="CARSource" type="Text" size="75" value="#CARSource.CARSource#" required="Yes" message="CAR Source is a required field"><br><br>

<b>Corporate CAR Verification Responsibility</b><br>
<cfinput name="CorpCAR" type="Text" size="75" value="#CARSource.CorpCAR#" required="Yes" message="Corporate CAR Verification Responsibility is a required field"><br><bR>

<b>Local CAR Verification Responsibility</b><br>
<cfinput name="LocalCAR" type="Text" size="75" value="#CARSource.LocalCAR#" required="Yes" message="Local CAR Verification Responsibility is a required field"><br><bR>

<b>CAR Source Description - Full Name of CAR Source</b><br>
<cfinput name="CARSource2" type="Text" size="100" value="#CARSource.CARSource2#" required="No"><br><br>

<b>CAR Source Explanation</b> - <font color="red">REQUIRED</font><br>
<textarea wrap="physical" name="Description" rows="4" cols="75">#CARSource.Description#</textarea><br><br />

<b><u>Revision History Information</u></b><br />

<cfif CARSource.status eq 1>
<u>Revision Number Update?</u><Br />
	<cfinput type="radio" name="RevUpdate" value="Yes" checked="Yes"> Yes<br>
	<cfinput type="radio" name="RevUpdate" value="No" checked="No"> No<br><br>

Change History/Notes: <font color="red">REQUIRED</font><br />
<textarea wrap="physical" name="History" rows="4" cols="75">Please provide a change history which will be included in the email notification. Even if this is a grammatical edit, please include the change history.</textarea>

Note: The CAR Source details will be included in the email, as well as the Change History/Notes. Please be specific when explaining a change (edit) to CAR Source information.<br><br>

<u>Send Notification to CAR Admins about this CAR Source change?</u><Br />
	<cfinput type="radio" name="RevNotify" value="Yes" checked="Yes"> Yes<br>
	<cfinput type="radio" name="RevNotify" value="No" checked="No"> No<br><br>

 :: <a href="CARSource_Remove_Confirm.cfm?ID=#URL.ID#&action=remove">remove</a> this CAR Source from the active list
<cfelse>
 :: <a href="CARSource_Remove_Confirm.cfm?ID=#URL.ID#&action=reinstate">reinstate</a> this CAR Source to the active list
</cfif>
</cfoutput>
<br><br>

<input name="submit" type="submit" value="Edit CAR Source"><br><br>
</cfform>
</cfif>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->