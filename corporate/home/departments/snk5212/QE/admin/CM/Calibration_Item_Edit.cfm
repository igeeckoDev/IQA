<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID as mID, CalibrationMeetings.DB, 

CalibrationItems.ID, CalibrationItems.ItemID, CalibrationItems.MeetingID as MeetingID2, CalibrationItems.DateAdded, CalibrationItems.DueDate, CalibrationItems.Owner, CalibrationItems.Notes, CalibrationItems.AddedBy, CalibrationItems.Subject, CalibrationItems.Status, CalibrationItems.CompletedDate

FROM CalibrationItems, CalibrationMeetings

WHERE CalibrationItems.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> AND
CalibrationMeetings.ID = CalibrationItems.MeetingID
</CFQUERY>

<cfif Query.StartDate eq Query.EndDate>
	<cfset Date = "#dateformat(Query.startdate, "mmmm d, yyyy")#">
<cfelse>
	<cfset Date = "#dateformat(Query.startdate, "mmmm d")#-#dateformat(Query.enddate, "d, yyyy")#">
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Owner"> 
SELECT Name, Email FROM IQADB_LOGIN
WHERE IQA = 'Yes'
AND Name <> 'IQA Auditor Test'

UNION

SELECT Name, Email FROM CAR_LOGIN
WHERE QE = 'Yes'

ORDER BY Name
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Owner2"> 
SELECT Name, Email FROM IQADB_LOGIN
WHERE Email = '#Query.Owner#'
AND IQA = 'Yes'

UNION

SELECT Name, Email FROM CAR_LOGIN
WHERE Email = '#Query.Owner#'
AND QE = 'Yes'

ORDER BY Name
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset SubTitle = "#Query.DB# Calibration Meeting - Action Item #Query.ItemID# - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
    <script language="JavaScript" src="#SiteDir#SiteShared/js/date.js"></script>
</cfoutput>

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

<br>
<cfoutput>
<u>Type</u> - #Query.DB#<br />
<u>Meeting Dates</u> - #Date#<br>
<u>Action Item</u> - #Query.ItemID#<br />
</cfoutput><br />

<cfif IsDefined("Form.Submit")>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit">
UPDATE CalibrationItems
SET

Subject = '#Form.Subject#',
DueDate = #CreateODBCDate(Form.e_DueDate)#,
Owner = '#Form.Owner#',
Status = '#Form.Status#',
<cfif Form.Status is "Yes">
CompletedDate = #CreateODBCDate(curdate)#,
</cfif>
Notes = '#Form.Notes#'

WHERE ID = #URL.ID#
</cfquery>
	
<cflocation url="Calibration_Item.cfm?#CGI.QUERY_STRING#" addtoken="No">
	
<cfelse>

	<cfform name="Audit" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post" enctype="multipart/form-data">
<cfoutput query="Query">
	<b>Subject</b><br>
	<cfinput type="text" name="Subject" value="#Subject#" size="75" required="Yes" message="Please enter the Action Item Subject"><br><br>
		
	<b>Date Added</B><br>
		#dateformat(DateAdded, "mm/dd/yyyy")#<br><br>
	
	<b>Due Date</B><br>
	<INPUT TYPE="Text" NAME="e_DueDate" VALUE="#dateformat(DueDate, "mm/dd/yyyy")#" onchange="return Validate_e_DueDate()"><br><br>
	
	<cflock scope="session" timeout="5">
			<b>Item Added By</b><br>
			#SESSION.Auth.Name#<br><br>
	</cflock>
</cfoutput>
	
	<b>Owner</b><br>
	<SELECT NAME="Owner">
		<cfoutput><option value="#Query.Owner#" selected>#Query.Owner#</cfoutput>
		<option value="">---
		<Option Value="All Auditors">All IQA Auditors
		<Option Value="All IQA">All IQA
		<Option Value="All QE">All QE
		<cfoutput query="Owner2">
			<option value="#Email#" selected>#Name#
		</cfoutput>
		<cfoutput query="Owner">
			<Option Value="#Email#">#Name#
		</cfoutput>		
	</SELECT><br><br>
	
<cfoutput query="Query">
	<b>Notes</b><br>
	<textarea WRAP="PHYSICAL" ROWS="8" COLS="75" NAME="Notes">#Notes#</textarea><br><br>
	
<b>Status</b> - Currently <b><cfif Status is "No">Open<cfelseif Status is "Yes">Completed</cfif></b><br>
<cfif Status is "No">
	Open <input type="Radio" Name="Status" Value="No" checked> Completed <input type="Radio" Name="Status" Value="Yes">
<cfelseif Status is "Yes">
	Open <input type="Radio" Name="Status" Value="No"> Completed <input type="Radio" Name="Status" Value="Yes" checked>
</cfif>
<br><br>
</cfoutput>
	
	<input name="Submit" type="Submit" value="Save Action Item">
	</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->