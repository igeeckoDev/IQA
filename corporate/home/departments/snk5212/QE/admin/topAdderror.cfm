<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" name="PageID" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 8fd293a3-73fd-4857-b2f9-bb9dfbf4bb7e Variable Datasource name --->
SELECT RH.ID, RH.FileName, Page_Content.ID, Page_Content.PageID FROM RH, Page_Content
WHERE RH.filename = '#url.filename#'
AND RH.ID = Page_Content.PageID
<!---TODO_DV_CORP_002_End: 8fd293a3-73fd-4857-b2f9-bb9dfbf4bb7e Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!--- this is for the new rev number --->
<CFQUERY BLOCKFACTOR="100" name="PageID2" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 04ddde02-57aa-47f3-8284-be2f0a682e55 Variable Datasource name --->
SELECT MAX(RevNo)+1 as MaxRev FROM Page_Content
WHERE pageID = #PageID.PageID#
<!---TODO_DV_CORP_002_End: 04ddde02-57aa-47f3-8284-be2f0a682e55 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# - Page Content Management">
<cfinclude template="SOP.cfm">

<!--- / --->

<Br>

<cfif isDefined("Form.RevDetails")>

<!--- add new row --->
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="maxID"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d741c495-c364-4925-8733-250544c1f9a6 Variable Datasource name --->
SELECT MAX(ID)+1 AS MAXID FROM Page_Content
<!---TODO_DV_CORP_002_End: d741c495-c364-4925-8733-250544c1f9a6 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="addRow"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 2498ebbc-a48e-4077-af8f-9117d90fd30f Variable Datasource name --->
INSERT INTO Page_Content(ID, pageID, title)
VALUES(#maxID.MAXID#, #PageID.PageID#, 'Intro Text')
<!---TODO_DV_CORP_002_End: 2498ebbc-a48e-4077-af8f-9117d90fd30f Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cflock scope="Session" Timeout="5">
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="update"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 7fde8d09-c62c-4f66-87c3-b9d24b8e0b61 Variable Datasource name --->
UPDATE Page_Content
SET
<!--- content --->
content = '#form.content#',
<!--- rev hist --->
RevDate = '#curdate#',
RevAuthor = '#SESSION.Auth.Name#',
RevDetails = '#Form.RevDetails#',
RevNo = #PageID2.MaxRev#

WHERE ID = #maxID.MAXID# AND PageID = #PageID.PageID#
<!---TODO_DV_CORP_002_End: 7fde8d09-c62c-4f66-87c3-b9d24b8e0b61 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>
</cflock>

<cflocation url="#url.filename#" addtoken="No">

<cfelse>
<cfform name="IntroText" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post">

<cfoutput>
<b><u>Intro Text</u></b> - #url.filename#<br><Br>
</cfoutput>

<script type="text/javascript" src="../textarea/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="../textarea/scripts/wysiwyg-settings.js"></script>

<CFQUERY BLOCKFACTOR="100" name="PageID" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 2bfdf364-480e-4532-b1ff-919b79bebd85 Variable Datasource name --->
SELECT * FROM RH
WHERE RH.filename = '#url.filename#'
<!---TODO_DV_CORP_002_End: 2bfdf364-480e-4532-b1ff-919b79bebd85 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="introText" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 2c4554c5-48dd-4c06-9f48-3a414a719829 Variable Datasource name --->
SELECT * FROM page_content, RH
WHERE RH.filename = '#url.filename#'
AND page_content.pageID = RH.ID
AND Title = 'Intro Text'
AND page_content.RevNo = (SELECT MAX(RevNo) FROM page_content WHERE PageID = #PageID.ID#)
<!---TODO_DV_CORP_002_End: 2c4554c5-48dd-4c06-9f48-3a414a719829 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<cfoutput query="introText">

<cfparam default="Insert Introductory Text Here" name="content">

<textarea WRAP="PHYSICAL" ROWS="25" COLS="75" NAME="content" id="content" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:10px;">#content#</textarea>

<script language="JavaScript">
	var mysettings = new WYSIWYG.Settings(); 
		mysettings.ImagesDir = "../TextArea/images/";
		mysettings.PopupsDir = "../TextArea/popups/"; 
		mysettings.CSSFile = "../TextArea/styles/wysiwyg.css"; 
		mysettings.Width = "595px"; 
		mysettings.Height = "300px"; 
		mysettings.removeToolbarElement("help");
		mysettings.removeToolbarElement("save");
		mysettings.removeToolbarElement("maximize");
		mysettings.removeToolbarElement("insertimage");
	WYSIWYG.attach('content', mysettings);
</script><br><br>
</cfoutput>

<u>Document this revision:</u><Br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="75" NAME="RevDetails" Value="" required="yes"></textarea><br><br>

<input type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->