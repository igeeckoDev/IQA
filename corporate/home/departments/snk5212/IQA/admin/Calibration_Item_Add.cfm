<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID as mID, CalibrationMeetings.DB, 

CalibrationItems.ID, CalibrationItems.ItemID, CalibrationItems.MeetingID as MeetingID2, CalibrationItems.DateAdded, CalibrationItems.DueDate, CalibrationItems.Owner, CalibrationItems.Notes, CalibrationItems.AddedBy, CalibrationItems.Subject, CalibrationItems.Status, CalibrationItems.CompletedDate

FROM CalibrationItems, CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> 
AND CalibrationMeetings.ID = CalibrationItems.MeetingID
</CFQUERY>

<cfif Query.RecordCount GT 0>
	<cfif Query.StartDate eq Query.EndDate>
		<cfset Date = "#dateformat(Query.startdate, "mmmm d, yyyy")#">
	<cfelse>
		<cfset Date = "#dateformat(Query.startdate, "mmmm d")#-#dateformat(Query.enddate, "d, yyyy")#">
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="MaxItemID">
SELECT MAX(ItemID)+1 as MaxItemID FROM CalibrationItems
WHERE CalibrationItems.MeetingID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER">
</cfquery>

<cfif NOT Len(MaxItemID.MaxItemID)>
	<cfset MaxItemID.MaxItemID = 1>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
SELECT CalibrationMeetings.StartDate, CalibrationMeetings.EndDate, CalibrationMeetings.MeetingID, CalibrationMeetings.MeetingYear, CalibrationMeetings.AgendaFile, CalibrationMeetings.ID, CalibrationMeetings.DB

FROM CalibrationMeetings

WHERE CalibrationMeetings.ID = <cfqueryparam value="#URL.ID#" CFSQLTYPE="CF_SQL_INTEGER"> 
</CFQUERY>

<cfif Query.RecordCount eq 0>
	<cfif Query2.StartDate eq Query2.EndDate>
        <cfset Date = "#dateformat(Query2.startdate, "mmmm d, yyyy")#">
    <cfelse>
        <cfset Date = "#dateformat(Query2.startdate, "mmmm d")#-#dateformat(Query2.enddate, "d, yyyy")#">
    </cfif>
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

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Query.DB# Calibration Meeting - Add Action Item">
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
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<cfoutput>
<u>Meeting Dates</u> - #Date#<br>
<u>Type</u> - #Query2.DB#<br />
<u>Action Item</u> - #MaxItemID.MaxItemID#<br /><br />
</cfoutput>

<cfif IsDefined("Form.Submit")>
<!--- check to see if any items exist for this calibration meeting ID --->
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="check">
	SELECT * FROM CalibrationItems
	WHERE MeetingID = #URL.ID#
	</CFQUERY>
	
<!--- if not set variable to 1, for first record --->	
	<cfif check.recordcount eq 0>
		<cfset maxItemId.maxItemID = 1>
	<cfelse>
<!--- if there are items, find max ItemID and add 1 --->
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxItemID">
		SELECT MAX(ItemID)+1 as maxItemID FROM CalibrationItems
		WHERE MeetingID = #URL.ID#
		</CFQUERY>
	</cfif>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="check2">
	SELECT * FROM CalibrationItems
	</CFQUERY>

<!--- if not set variable to 1, for first record --->	
	<cfif check2.recordcount eq 0>
		<cfset maxID.maxID = 1>
	<cfelse>
<!--- if there are items, find max ItemID and add 1 --->
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="maxID">
		SELECT MAX(ID)+1 as maxID FROM CalibrationItems
		</CFQUERY>
	</cfif>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add">
	INSERT INTO CalibrationItems(ID, ItemID, MeetingID)
	VALUES(#maxID.maxID#, #maxItemID.maxItemID#, #URL.ID#)
	</CFQUERY>
	
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Add2">
	UPDATE CalibrationItems
	SET
	Owner='#form.owner#',
	DateAdded=#CreateODBCDate(curdate)#,
	DueDate=#CreateODBCDate(form.e_DueDate)#,
	Notes='#form.notes#',
	AddedBy='#form.addedby#',
	Subject='#form.subject#',
	Status='No'
	
	WHERE ID = #maxID.maxID#
	</cfquery>	
	
	<cflocation url="Calibration_Item.cfm?ID=#maxID.maxID#" addtoken="no">
			
<cfelse>

	<cfform name="Audit" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post">
	<br><b>Subject</b><br>
	<cfinput type="text" name="Subject" size="75" required="Yes" message="Please enter the Action Item Subject"><br><br>
		
	<b>Date Added</B><br>
	<cfoutput>
		#curdate#
		<INPUT TYPE="hidden" NAME="DateAdded" VALUE="#curdate#"><br><br>
	</cfoutput>
	
	<b>Due Date</B><br>
	<input type="text" name="e_DueDate" Value="" displayname="Due Date" onchange="return Validate_e_DueDate()"><br><br>
	
	<cflock scope="session" timeout="5">
		<cfoutput>
			<b>Item Added By</b><br>
			#SESSION.Auth.Name#
			<input type="hidden" name="AddedBy" value="#SESSION.Auth.Name#"><br><br>
		</cfoutput>
	</cflock>
	
	<b>Owner</b><br>
	<SELECT NAME="Owner">
		<option value="">Select Owner Below
		<option value="">---
		<Option Value="All Auditors">All IQA Auditors
		<Option Value="All IQA">All IQA
		<Option Value="All QE">All QE
		<cfoutput query="Owner">
			<Option Value="#Email#">#Name#
		</cfoutput>		
	</SELECT><br><br>
	
	<b>Notes</b><br>
	<textarea WRAP="PHYSICAL" ROWS="5" COLS="75" NAME="Notes">Please add notes to describe this item</textarea><br><br>
	
	<input name="Submit" type="Submit" value="Save Action Item">
	</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->