<!--- DV_CORP_002 02-APR-09 --->
<CFQUERY BLOCKFACTOR="100" name="PageID" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d55a1ac0-9909-466d-ad3f-8ddda8e900b5 Variable Datasource name --->
SELECT * FROM RH
WHERE RH.filename = '#replace(cgi.script_name, "admin/", "", "All")#'
<!---TODO_DV_CORP_002_End: d55a1ac0-9909-466d-ad3f-8ddda8e900b5 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="introText" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 8a2f850a-cb1a-4060-a698-7111c35a53e1 Variable Datasource name --->
SELECT * FROM page_content, RH
WHERE RH.filename = '#replace(cgi.script_name, "admin/", "", "All")#'
AND page_content.pageID = RH.ID
AND Title = 'Intro Text'
AND page_content.RevNo = (SELECT MAX(RevNo) FROM page_content WHERE PageID = #PageID.ID#)
<!---TODO_DV_CORP_002_End: 8a2f850a-cb1a-4060-a698-7111c35a53e1 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="PageID" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: c94af996-11b1-4605-a030-065d68687788 Variable Datasource name --->
SELECT RH.ID, RH.FileName, Page_Content.ID, Page_Content.PageID FROM RH, Page_Content
WHERE RH.filename = '#url.filename#'
AND RH.ID = Page_Content.PageID
<!---TODO_DV_CORP_002_End: c94af996-11b1-4605-a030-065d68687788 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<!--- this is for the new rev number --->
<CFQUERY BLOCKFACTOR="100" name="PageID2" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 93b12035-ab88-47cf-82b3-aec553c7074e Variable Datasource name --->
SELECT MAX(RevNo)+1 as MaxRev FROM Page_Content
WHERE pageID = #PageID.PageID#
<!---TODO_DV_CORP_002_End: 93b12035-ab88-47cf-82b3-aec553c7074e Variable Datasource name --->
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
<!---TODO_DV_CORP_002_Start: f100b18a-c880-46e3-a6fd-e1ae48bc487c Variable Datasource name --->
SELECT MAX(ID)+1 AS MAXID FROM Page_Content
<!---TODO_DV_CORP_002_End: f100b18a-c880-46e3-a6fd-e1ae48bc487c Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="addRow"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: d6f0a3d4-7139-4926-b836-992d607302f3 Variable Datasource name --->
INSERT INTO Page_Content(ID, pageID, title)
VALUES(#maxID.MAXID#, #PageID.PageID#, 'Intro Text')
<!---TODO_DV_CORP_002_End: d6f0a3d4-7139-4926-b836-992d607302f3 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</CFQUERY>

<cflock scope="Session" Timeout="5">
<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="update"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 8cc87a6f-5df5-4f99-88b5-059b077db4b2 Variable Datasource name --->
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
<!---TODO_DV_CORP_002_End: 8cc87a6f-5df5-4f99-88b5-059b077db4b2 Variable Datasource name --->
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
<!---TODO_DV_CORP_002_Start: 9ae2c1f6-6694-4d01-a56e-0af5dc83eee1 Variable Datasource name --->
SELECT * FROM RH
WHERE RH.filename = '#url.filename#'
<!---TODO_DV_CORP_002_End: 9ae2c1f6-6694-4d01-a56e-0af5dc83eee1 Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="introText" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: c7aeb36e-6c8a-473a-8ddc-262dfaaf400e Variable Datasource name --->
SELECT * FROM page_content, RH
WHERE RH.filename = '#url.filename#'
AND page_content.pageID = RH.ID
AND Title = 'Intro Text'
AND page_content.RevNo = (SELECT MAX(RevNo) FROM page_content WHERE PageID = #PageID.ID#)
<!---TODO_DV_CORP_002_End: c7aeb36e-6c8a-473a-8ddc-262dfaaf400e Variable Datasource name --->
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