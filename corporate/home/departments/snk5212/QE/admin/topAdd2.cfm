<!--- DV_CORP_002 02-APR-09 --->
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

<CFQUERY BLOCKFACTOR="100" name="PageID" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: b0a4627b-7679-443b-80ea-93b0f33b5c21 Variable Datasource name --->
SELECT RH.ID, RH.FileName, Page_Content.ID, Page_Content.PageID 
FROM RH, Page_Content
WHERE RH.filename = '#url.filename#'
AND RH.ID = Page_Content.PageID
<!---TODO_DV_CORP_002_End: b0a4627b-7679-443b-80ea-93b0f33b5c21 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!---Should show all Revs of particular file name<br>
<cfdump var="#PageID#">--->

<cfif PageID.RecordCount eq 0>
	<CFQUERY BLOCKFACTOR="100" name="PageID2" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: b88ab294-0fcf-425a-a66f-d04f1c4d3615 Variable Datasource name --->
SELECT * FROM RH 
	WHERE RH.filename = '#url.filename#'
<!---TODO_DV_CORP_002_End: b88ab294-0fcf-425a-a66f-d04f1c4d3615 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
	<cfset pID = #PageID2.ID#>
<cfelse>
	<cfset pID = #PageID.PageID#>
	<!--- this is for the new rev number --->
	<CFQUERY BLOCKFACTOR="100" name="PageID2" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 12569e7a-4480-4092-94aa-dc1e86176795 Variable Datasource name --->
SELECT MAX(RevNo)+1 as MaxRev 
FROM Page_Content
WHERE pageID = #pID#
<!---TODO_DV_CORP_002_End: 12569e7a-4480-4092-94aa-dc1e86176795 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
</cfif>

<!---Should show maxRev using PageID2.MaxRev and pID
<cfdump var="#PageID2#">

<cfoutput>
Page ID - #pID#<br>
New Max Rev +1 = #PageID2.MaxRev#
</cfoutput>--->

<CFQUERY BLOCKFACTOR="100" name="introText" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: f5872fe7-630b-406d-a0f8-d84983873648 Variable Datasource name --->
SELECT * FROM page_content
WHERE PageID = #pID#
AND Title = 'Intro Text'
AND RevNo = (SELECT MAX(RevNo) FROM page_content WHERE PageID = #pID#)
<!---TODO_DV_CORP_002_End: f5872fe7-630b-406d-a0f8-d84983873648 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!---Should show only Max Rev details... Rev = 6
<cfdump var="#introText#">--->

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Page Content Management">
<cfinclude template="SOP.cfm">

<!--- / --->

<Br>

<cfif isDefined("Form.RevDetails")>

<!--- add new row --->
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="maxID"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 15be03f0-e71c-44fb-8521-3b87b064ffc3 Variable Datasource name --->
SELECT MAX(ID)+1 AS MAXID FROM Page_Content
<!---TODO_DV_CORP_002_End: 15be03f0-e71c-44fb-8521-3b87b064ffc3 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="addRow"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 8804f993-9905-4b1a-802a-48b440ea18e0 Variable Datasource name --->
INSERT INTO Page_Content(ID, pageID, title)
VALUES(#maxID.MAXID#, #pID#, 'Intro Text')
<!---TODO_DV_CORP_002_End: 8804f993-9905-4b1a-802a-48b440ea18e0 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cflock scope="Session" Timeout="5">
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="update"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d8d8d780-7b85-4aa0-8fec-712249694183 Variable Datasource name --->
UPDATE Page_Content
SET
<!--- content --->
content = '#form.content#',
<!--- rev hist --->
RevDate = #CREATEODBCDate(curdate)#,
RevAuthor = '#SESSION.Auth.Name#',
RevDetails = '#Form.RevDetails#',
<cfif PageID.RecordCount eq 0>
RevNo = 1
<cfelse>
RevNo = #PageID2.MaxRev#
</cfif>

WHERE ID = #maxID.MAXID# AND PageID = #pID#
<!---TODO_DV_CORP_002_End: d8d8d780-7b85-4aa0-8fec-712249694183 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
</cflock>

<cfif url.filename neq "/departments/snk5212/QE/request.cfm">
	<cflocation url="#url.filename#" addtoken="No">
<cfelse>
	<cflocation url="../getEmpNo.cfm?page=request" addtoken="No">
</cfif>
	
<cfelse>
<cfform name="IntroText" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post">

<cfoutput>
<b><u>Intro Text</u></b> - #url.filename#<br><Br>
</cfoutput>

<cfoutput query="introText">
Previous Intro Text: #trim(content)#
</cfoutput><br>

<cfif PageID.RecordCount eq 0>
	<cfset blank = "Enter New Text Here">
<cfelse>
	<cfset blank = "#introText.Content#">
</cfif>

<textarea WRAP="PHYSICAL" ROWS="25" COLS="75" NAME="content"><cfoutput>#blank#</cfoutput></textarea>
<br><br>

<u>Document this revision:</u><Br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="75" NAME="RevDetails" Value="" required="yes">Please enter a description of the revision</textarea><br><br>

<input type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->