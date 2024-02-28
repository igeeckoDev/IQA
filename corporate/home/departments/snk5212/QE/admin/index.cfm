<!--- Start of Page File --->
<cfset subTitle = "CAR Process Admin - Super User Menu (Original Menu)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfset indent = "&nbsp;&nbsp;&nbsp;">

<cfoutput>
<table>
<tr>
<td class="blog-content" width="300">
    :: <a href="#CARAdminDir#index.cfm">Main - CAR Process Website</a><br>
    <!--- :: <a href="#CARDir#ASReports.cfm?Year=#curyear#">AS Reports (ANSI / OSHA / SCC)</a><br>--->
    :: <a href="notes:///86256F150051C1B0">Global CAR Database</a> (Link to Lotus Notes)<br>
    :: <a href="#CARDir#CARTrainingFiles.cfm">CAR Training Documents</a><br>
    :: <a href="Links.cfm">Links</a><br>
    :: <a href="KBIndex.cfm">IQA / CAR Website Knowledge Base</a><br>
    :: <a href="Training.cfm">Training Aids</a><br>
    :: CAR Administrators<br>
    #indent# -  <a href="CARAdminList.cfm">View CAR Admin List</a><br>
	#indent# -  <a href="getCARAdminEmailList.cfm">CAR Admin Email List</a> (For Active and In Training Status)<br>
    #indent# -  <a href="#CARAdminDir#CARAdminAdd.cfm">Add CAR Admin</a><br>
    #indent# -  Performance (<u>See QE Files</u>)<br>
    #indent# -  Responsibility Matrix <a href="#CARRootDir#CARmatrix/CARAdministratorResponsibilityList.xls?">[view]</a> <a href="#CARAdminDir#CARResponsibility.cfm">[upload]</a><br>
    #indent# -  Requests <a href="#CARDir#getEmpNo.cfm?page=request">[request form]</a> <a href="Request.cfm">[view requests]</a><br>
    <cflock scope="SESSION" timeout="6">
       <cfif SESSION.Auth.AccessLevel eq "SU">
        :: Email Check<br>
        #indent# -  <a href="#CARAdminDir#EmailCheck.cfm">Email Verify</a><br>
        :: <a href="#CARAdminDir#TrainerLogin.cfm">CAR Trainer Logins - Verify</a><br>
        </cfif>
    </cflock>
</td>
<td class="blog-content" width="300">
    :: FAQ - Frequently Asked Questions<br>
    #indent# -  <a href="FAQ.cfm">Full CAR Process FAQ</a><br>
    #indent# -  <a href="#CARDir#FAQ_RH.cfm">FAQ Revision History</a><br>
    <!---#indent# -  <a href="CAROwners.cfm">FAQ - CAR Owners</a> <br>
    #indent# -  <a href="CARAdmins.cfm">FAQ - CAR Administrators</a><br>--->
    :: Manage Lists<br>
    #indent# -  <a href="#CARAdminDir#CARSource_View.cfm">CAR Sources / FAQ 12</a><br>
    #indent# -  <a href="#CARAdminDir#RootCause_Add.cfm">Root Cause Categories / FAQ 26</a><br>
    :: Quality Alerts<br>
    #indent# -  <a href="#CARDir#Alerts.cfm">View Alerts</a><br>
    #indent# -  <a href="viewMetrics.cfm">Quality Alert Metrics</a><br>
    :: CAR Process Calibration Meetings<br>
    #indent# -  <a href="#CARAdminDir#CM/Calibration_Index.cfm">Calibration Meetings</a><br>
    :: QE Related Files<br>
    #indent# -  <a href="#CARAdminDir#CARFiles.cfm">View/Add Files</a><Br>
    #indent# -  <a href="#CARAdminDir#CARFilesCategories.cfm">View/Add Categories</a><Br>
</td>
</tr>
</table>
</cfoutput>

<br><br>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="TopicCount">
SELECT *
FROM CAR_IndexTopics
WHERE IndexTopic = 'Index'
</CFQUERY>

<cfset loopcount = TopicCount.recordcount>

<cfloop index="i" from="1" to="#variables.loopcount#">

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="maxrev">
SELECT MAX(RevNo) AS MaxRev
 FROM CAR_INDEX  "INDEX"
 WHERE INDEXTopicID=#i#
</CFQUERY>

<CFQUERY NAME="topic" DataSource="Corporate">
  SELECT A.ID, A.IndexTopicID,
  A.Index_ AS "Index", A.RevNo, A.RevAuthor,
  A.RevDate, A.RevDetails, B.ID,
  B.IndexTopic
  FROM CAR_INDEX "A",  CAR_INDEXTOPICS "B"
WHERE B.ID = A.IndexTopicID
AND  RevNo = #maxrev.MaxRev#
AND B.ID=#i#
</CFQUERY>

<cfoutput query="Topic">
<u><b>#IndexTopic#</b></u> [Rev #RevNo#, #dateformat(revdate, "mm/dd/yyyy")#]
<cflock scope="Session" timeout="5">
<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel eq "SU">
 - <a href="#CARDir_Admin#indexEdit.cfm?ID=#IndexTopicID#&Rev=#RevNo#">edit</a></cfif>
</cflock>
<Br>
<cfset Dump = #replace(Index, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
#Dump2#
</cfoutput>
</cfloop>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->