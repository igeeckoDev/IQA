<CFQUERY NAME="Index" DataSource="Corporate"> 
SELECT CAR_Index.ID, CAR_Index.IndexTopicID, CAR_Index.INDEX_ as "Index", CAR_Index.RevNo, CAR_Index.RevAuthor, CAR_Index.RevDate, CAR_Index.RevDetails, CAR_IndexTopics.ID, CAR_IndexTopics.IndexTopic

FROM CAR_INDEX, CAR_INDEXTOPICS

WHERE CAR_IndexTopics.ID = CAR_Index.IndexTopicID 
AND CAR_Index.RevNo = #URL.Rev#
AND CAR_IndexTopics.ID = #URL.ID#
</CFQUERY>

<!--- Start of Page File --->
<cfset subTitle = "Edit Index Text (CAR Process Home Page Text)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
<script 
	language="javascript" 
	type="text/javascript" 
	src="#CARDir#tinymce/jscripts/tiny_mce/tiny_mce.js">
</script>

<script language="javascript" type="text/javascript">
tinyMCE.init({
	mode : "textareas",
	content_css : "#SiteDir#SiteShared/cr_style.css"
});
</script>
</cfoutput>

<cfif isDefined("Form.RevDetails")>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="maxID"> 
SELECT MAX(ID)+1 AS MAXID FROM CAR_Index "Index"
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="maxRev"> 
SELECT MAX(RevNo)+1 AS MaxRev
FROM CAR_INDEX "INDEX"
WHERE IndexTopicID = #URL.ID#
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="addRow"> 
INSERT INTO CAR_INDEX "INDEX" (ID)
VALUES (#maxID.MAXID#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="addData" DataSource="Corporate"> 
UPDATE CAR_INDEX "INDEX" 
SET 
RevDate=#CreateODBCDate(curdate)#, 
<cflock scope="Session" timeout="5">
RevAuthor='#SESSION.Auth.Name#',
</cflock>
RevDetails='#Form.RevDetails#', 
RevNo='#maxRev.MaxRev#', 
IndexTopicID = #URL.ID#, 
INDEX_ = <CFQUERYPARAM VALUE='#Form.Index#'>

WHERE ID = #maxID.MAXID#
</CFQUERY>

<cflocation url="index.cfm" addtoken="No">

<cfelse>
<cfform name="IndexEdit" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post">

<cfoutput query="Index">
<u>Current #IndexTopic# text:</u> [Rev #RevNo#, #dateformat(RevDate, "mm/dd/yyyy")#, by #RevAuthor#]<br>
#index#<br><br>

<u>New #IndexTopic# text:</u><Br>
<textarea WRAP="PHYSICAL" ROWS="15" COLS="75" NAME="index">#index#</textarea>
<br><br>
</cfoutput>

<u>Document this revision:</u><Br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="75" NAME="RevDetails"></textarea><br><br>

<input type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->