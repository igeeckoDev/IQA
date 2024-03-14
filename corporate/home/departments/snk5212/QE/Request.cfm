<!--- Start of Page File --->
<cfset subTitle = "Request to be a CAR Champion">
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

<cfinclude template="inc_TOP.cfm">

<cfparam name="form.EmpNo" type="string" default="NA">

<cfset v_name = ''>
<cfset v_email = ''>
<cfset qresult = 1>

  <cfset v_name = ''>
  <cfset v_email = ''>
  <cfset qresult = 1>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" DataSource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
AND Finance = 'Yes'
AND CB = 'No'
ORDER BY OfficeName
</cfquery>

<cfif isDefined("Form.Name")>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Check">
SELECT * FROM CARAdminRequest
</CFQUERY>

<Cfif Check.recordcount eq 0>
	<cfset Query.newid = 1>
<cfelse>
	<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="Query">
	SELECT MAX(ID) + 1 AS newid FROM CARAdminRequest
	</CFQUERY>
</CFIF>

<CFQUERY BLOCKFACTOR="100" NAME="maxID" DataSource="Corporate">
INSERT INTO CARAdminRequest(ID)
VALUES(#query.newid#)
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="maxID" DataSource="Corporate">
UPDATE CARAdminRequest
SET
Name='#form.name#',
Email='#Form.Email#',
Location='#Form.Location#',
x17020=#form.x17020#,
x17020yrs=#form.x17020yrs#,
x17020notes='#form.x17020notes#',
x17025=#form.x17025#,
x17025yrs=#form.x17025yrs#,
x17025notes='#form.x17025notes#',
x17065=#form.x17065#,
x17065yrs=#form.x17065yrs#,
x17065notes='#form.x17065notes#',
status=NULL,
posted=#CreateODBCDate(curdate)#

WHERE ID = #query.newid#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="view" DataSource="Corporate">
SELECT * FROM CARAdminRequest
WHERE ID = #query.newid#
</cfquery>

<cfmail to="Christopher.J.Nicastro@ul.com, Cheryl.Adams@ul.com"
		from="CAR.Process.Web.Site@ul.com"
		subject="Request to be a CAR Champion"
		query="view">
#dateformat(posted, "mm/dd/yyyy")# - A CAR Admin Request has been logged in the CAR Admin web site by #Name#.

View this request -
#request.serverProtocol##request.serverDomain#/departments/snk5212/QE/RequestView.cfm?ID=#ID#

QE Staff: To manage this request, please log in to the CAR Admin Web Site.
</cfmail>

<cfmail to="#Email#" replyto="Christopher.J.Nicastro@ul.com, Cheryl.Adams@ul.com" from="CAR.Process.Web.Site@ul.com" subject="Request to be a CAR Champion" query="View" bcc="Christopher.j.nicastro@ul.com" type="HTML">
Thank you for your Request.<br><br>

Your request to become a CAR Champion will be processed within a week of receipt of your request. You will be contacted with the status and details at that time.<br><br>

If you have any questions or comments, please contact Chery Adams.<br /><br />

<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/QE/RequestView.cfm?ID=#ID#">View Request</a>
</cfmail>

<cfoutput>
	<cflocation url="RequestView.cfm?ID=#query.newid#" addtoken="No">
</cfoutput>

<cfelse>
<cfform name = "login" action = "#CGI.SCRIPT_NAME#" method = "post">

Employee Number:<Br>
<cfinput size="75" name="EmpNo" required="yes" Message="Please Enter your Employee Number" type="text" Maxlength="128" value=""><br><br>

Name:<Br>
<cfinput size="75" name="Name" required="yes" Message="Please Enter your Full Name" type="text" Maxlength="128" value="#v_name#"><br><br>

Email: (external UL Email address)<br>
<cfinput size="75" name="Email" required="yes" Message="Please enter your external UL Email Address" type="text" Maxlength="255" value="#v_email#"><br><br>

Location:<Br>
<SELECT NAME="Location">
		<OPTION VALUE="None Selected">Select your office location below
<CFOUTPUT QUERY="OfficeName">
		<OPTION VALUE="#OfficeName#">#OfficeName#
</CFOUTPUT>
</SELECT><br><br>

<b><u>Training</u></b><br>
<b>ISO/IEC 17020</b>:<br>
Yes <cfinput type="Radio" name="x17020" value="1"> No <cfinput type="Radio" name="x17020" value="0" checked><br><Br>

Years of Experience:<br>
<cfinput type="text" name="x17020yrs" value="0" validate="integer" required="yes" message="Please enter the number of years experience with ISO/IEC 17020. If none, enter 0"><br><br>

ISO/IEC 17020 Comments:<br>
<textarea name="x17020notes" value="" WRAP="PHYSICAL" ROWS="5" COLS="75"></textarea><br><br>

<b>ISO/IEC 17025</b>:<br>
Yes <cfinput type="Radio" name="x17025" value="1"> No <cfinput type="Radio" name="x17025" value="0" checked><Br><br>

Years of Experience:<br>
<cfinput type="text" name="x17025yrs" value="0" validate="integer" required="yes" message="Please enter the number of years experience with ISO/IEC 17025. If none, enter 0"><br><br>

ISO/IEC 17025 Comments:<br>
<textarea name="x17025notes" value="" WRAP="PHYSICAL" ROWS="5" COLS="75"></textarea><br><br>

<b>ISO/IEC 17065</b>:<br>
Yes <cfinput type="Radio" name="x17065" value="1"> No <cfinput type="Radio" name="x17065" value="0" checked><Br><br>

Years of Experience:<br>
<cfinput type="text" name="x17065yrs" value="0" validate="integer" required="yes" message="Please enter the number of years experience with ISO/IEC 17065. If none, enter 0"><br><br>

ISO/IEC 17065 Comments:<br>
<textarea name="x17065notes" value="" WRAP="PHYSICAL" ROWS="5" COLS="75"></textarea><br><br>

<!---<input type="hidden" name="posted" value="#dateformat(curdate, "mm/dd/yyyy")#">--->

<input type="submit" value="Submit">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->