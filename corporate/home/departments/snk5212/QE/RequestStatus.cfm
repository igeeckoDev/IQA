<!--- Start of Page File --->
<cfset subTitle = "Request to be a CAR Administrator - Change Status">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("Form.Status")>

<CFQUERY BLOCKFACTOR="100" NAME="RequestStatus" DataSource="Corporate">
UPDATE CARAdminRequest
SET

<cfif Form.Status eq "">
	Status = NULL,
<cfelse>
	Status = '#Form.Status#',
</cfif>

statusDate = #CreateODBCDate(curdate)#

WHERE ID = #URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Requests" DataSource="Corporate">
SELECT * FROM CARAdminRequest
WHERE ID = #URL.ID#
</cfquery>

<cfif len(Requests.Status)>
	<cfmail to="#Email#"
			from="CAR.Process.Web.Site@ul.com"
            replyto="Cheryl.Adams@ul.com, Christopher.J.Nicastro@ul.com"
			subject="CAR Admin Request - #Status#"
			query="Requests"
			bcc="christopher.j.nicastro@ul.com">
Your Request to be a CAR Administrator has been #Status#. Please contact Cheryl Adams for further information.

#Body#
	</cfmail>
</cfif>

<cfoutput query="Requests">
	<cfif form.status is "Approved">
		<cflocation url="admin/CARAdminAdd.cfm?ID=#ID#" addtoken="No">
	<cfelse>
		<cflocation url="RequestView.cfm?ID=#ID#" addtoken="No">
	</cfif>
</cfoutput>

<cfelse>

<CFQUERY BLOCKFACTOR="100" NAME="Requests" DataSource="Corporate">
SELECT * FROM CARAdminRequest
WHERE ID = #URL.ID#
</cfquery>

<cfform name="ChangeStatus" action="#CGI.SCRIPT_NAME#?#CGI.Query_String#" method="post">
Change Request Status:<br>
	<SELECT NAME="Status">
		<OPTION VALUE="Approved">Approved
		<OPTION VALUE="Not Approved">Not Approved
		<OPTION VALUE="">Open (No Decision Made Yet)
	</SELECT><br><br>

	<b>Email Text</B>:<br>
	<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Body">Please enter text that will be sent to the Requestor.</textarea><br><br>

<u>Status</u><br>
<u>Approved</u>* - Request is Approved, email is sent to Requestor.<br>
<u>Denied</u> - Request is Denied, email is sent to Requestor.<br>
<u>Open</u> - No decision is made, the Request is left in an Open state until a decision can be made<br><br>
* Note - You will be prompted to add the CAR Admin Profile for this accepted request.<br><br>

<input type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->