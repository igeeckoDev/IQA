<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY NAME="Index" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT IQADB_Index.ID, IQADB_Index.IndexTopicID, IQADB_Index.Index_ as "Index", IQADB_Index.RevNo, IQADB_Index.RevAuthor, IQADB_Index.RevDate, IQADB_Index.RevDetails, IQADB_IndexTopics.ID, IQADB_IndexTopics.IndexTopic

FROM IQADB_INDEX, IQADB_INDEXTOPICS

WHERE IQADB_INDEXTopics.ID = IQADB_Index.IndexTopicID 
AND IQADB_Index.RevNo = #URL.Rev#
AND IQADB_INDEXTopics.ID=#URL.ID#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Audit Database - Admin Index Page - Edit">
<cfinclude template="SOP.cfm">

<!--- / --->

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

<Br>

<cfif isDefined("Form.RevDetails")>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxID"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT MAX(ID)+1 AS MAXID FROM IQADB_INDEX  
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxRev"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
SELECT MAX(RevNo)+1 AS MaxRev
FROM IQADB_INDEX
WHERE INDEXTopicID = #URL.ID#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="addRow"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
INSERT INTO IQADB_INDEX(ID)
VALUES (#maxID.MAXID#)
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="addData" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->
UPDATE IQADB_INDEX
SET 
RevDate=#CreateODBCDate(curdate)#, 
<cflock scope="Session" timeout="5">
RevAuthor='#SESSION.Auth.Name#',
</cflock>
RevDetails='#Form.RevDetails#', 
RevNo='#maxRev.MaxRev#', 
IndexTopicID=#URL.ID#, 
INDEX_=<CFQUERYPARAM VALUE='#Form.Index#'>

WHERE 
ID=#maxID.MAXID#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cflocation url="admin.cfm" ADDTOKEN="No">

<cfelse>
<cfform name="IndexEdit" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post">

<cfoutput query="Index">
<u>Current #IndexTopic# text:</u> [Rev #RevNo#, #dateformat(RevDate, "mm/dd/yyyy")#, by #RevAuthor#]<br>
#index#<br><br>

<u>New #IndexTopic# text:</u><Br>
<textarea WRAP="PHYSICAL" ROWS="15" COLS="75" NAME="index" Value="" required="yes">#Index#</textarea><br><br>
</cfoutput>

<u>Document this revision:</u><Br>
<textarea WRAP="PHYSICAL" ROWS="4" COLS="75" NAME="RevDetails" Value="" required="yes"></textarea><br><br>

<input type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->