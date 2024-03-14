<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset subTitle = "CAR Source - Add">
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

	<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate">
	SELECT * FROM CARSource
	WHERE CARSource = '#trim(Form.CARSource)#'
	</cfquery>

	<cfif CARSource.recordcount gt 0>
		<cflocation url="CARSource_add.cfm?duplicate=yes&value=#form.CARSource#" addtoken="No">
	<cfelse>

<!--- FAQ Item Number 12 for CAR Source Table --->
<cfset csID = 12>

<!--- maxID to add CAR Source row --->
<CFQUERY BLOCKFACTOR="100" NAME="maxID" DataSource="Corporate">
SELECT MAX(ID)+1 as maxID FROM CARSource
</CFQUERY>

<!--- add CAR Source --->
<CFQUERY BLOCKFACTOR="100" NAME="AddCARSource" DataSource="Corporate">
INSERT INTO CARSource(ID, CARSource, CARSource2, Description, CorpCAR, LocalCAR, Status)
VALUES(#maxID.maxID#, '#Form.CARSource#', '#Form.CARSource2#', '#Form.Description#', '#Form.CorpCAR#', '#Form.LocalCAR#', 1)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="CARSource" DataSource="Corporate">
SELECT * FROM CARSource
WHERE ID = #maxID.maxID#
</CFQUERY>

<!--- rev number update --->
<CFQUERY BLOCKFACTOR="100" NAME="maxRevNo" DataSource="Corporate">
SELECT MAX(RevNo)+1 as maxRevNo FROM CAR_FAQ_RH
WHERE FAQID = #csID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="maxID" DataSource="Corporate">
SELECT MAX(ID)+1 as maxID FROM CAR_FAQ_RH
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="UpdateRevHist" DataSource="Corporate">
INSERT INTO CAR_FAQ_RH(ID, FAQID, RevNo, RevDate, RevAuthor, RevComments)
VALUES(#maxID.maxID#, #csID#, #maxRevNo.maxRevNo#, #CreateODBCDate(curDate)#, '#SESSION.Auth.Name#', 'CAR Source [#CARSource.CARSource#] added to table')
</CFQUERY>
<!--- /// --->

<!--- Notification being sent --->
    <!--- emails --->
    <cfinclude template="incFAQNotify.cfm">
	
	<cfmail 
	to="Internal.Quality_Audits@ul.com" 
    from="Internal.Quality_Audits@ul.com" 
    cc="#Emails2#, #Emails3#"
    bcc="Christopher.J.Nicastro@ul.com"
    query="CARSource" 
    subject="CAR Process Web Site - New CAR Source (#CARSource#)"
    type="html">
    
A new CAR Source <b>(#CARSource#)</b> has been added to FAQ 12/CAR Source Table.<br><Br>

<u>CAR Source</u><br>
#CARSource#<br /><br>

<u>CAR Source Description</u><br>
#CARSource2#<br /><br>

<u>Corporate CAR Verification Responsibility</u><br>
#CorpCAR#<br /><br>

<u>Local CAR Verification Responsibility</u><br>
#LocalCAR#<br /><br>

<u>CAR Source Explanation</u><br>
<cfset D1 = #replace(CARSource.Description, "<p>", "", "All")#>
<cfset D2 = #replace(D1, "</p>", "<br /><Br />", "All")#>
#D2#

View CAR Source Table<Br>
#request.serverProtocol##request.serverDomain#/departments/snk5212/QE/FAQ.cfm###csID#
	</cfmail>
<!--- /// --->

		<Cfoutput query="CARSource">
			<cflocation url="CARSource_View.cfm?duplicate=No&value=#CARSource#" addtoken="No">
		</Cfoutput>
    </cfif>
    
<cfelse>

<cfoutput>
<cfif isDefined("URL.Duplicate") AND isDefined("URL.Value")>
	<font color="red">CAR Source
	<cfif URL.Duplicate eq "No">
		[#URL.Value#] has been added to the CAR Source List
	<cfelseif URL.Duplicate eq "Yes">
		[#URL.Value#] already exists in the CAR Source List
	<cfelseif URL.Duplicate eq "Edit">
		[#URL.OldValue#] has been changed to <b>#URL.Value#</b>
	<cfelseif URL.Duplicate eq "Remove">
		[#URL.Value#] - Status has been changed to '#URL.Action#'
	<cfelseif URL.Duplicate eq "Cancel">
		[#URL.Value#] - Status change has been cancelled. Current status is '#URL.Action#'		
	</cfif>
	</font><br><br>
</cfif>
</cfoutput>

<cfform name = "CarAdmin" action = "#CGI.SCRIPT_NAME#" method = "post">

<cfoutput>
CAR Source<br>
<cfinput name="CARSource" type="Text" size="75" required="Yes" message="CAR Source is a required field"><br><br>

<b>Corporate CAR Verification Responsibility</b><br>
<cfinput name="CorpCAR" type="Text" size="75" required="Yes" message="Corporate CAR Verification Responsibility is a required field"><br><bR>

<b>Local CAR Verification Responsibility</b><br>
<cfinput name="LocalCAR" type="Text" size="75" required="Yes" message="Local CAR Verification Responsibility is a required field"><br><bR>

<b>CAR Source Description - Full Name of CAR Source</b><br>
<cfinput name="CARSource2" type="Text" size="100" required="No"><br><br>

<b>CAR Source Explanation</b> - <font color="red">REQUIRED</font><br>
<textarea wrap="physical" name="Description" rows="4" cols="75">Please give a brief description of the CAR Source.</textarea><br><br />

Change History/Notes: <font color="red">REQUIRED</font><br />
<textarea wrap="physical" name="History" rows="4" cols="75">Please provide a change history which will be included in the email notification.</textarea>

Note: The CAR Source details will be included in the notification email.<br><br>
</cfoutput>

<input name="submit" type="submit" value="Add CAR Source"><br><br>
</cfform>
</cfif>
						  
<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->