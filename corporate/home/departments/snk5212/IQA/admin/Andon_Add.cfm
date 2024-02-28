<cflock scope="Session" timeout="5">
	<cfif SESSION.Auth.Andon NEQ "Yes">
		<cflocation url="authorization.cfm?page=Andon" addtoken="no">
	</cfif>
</cflock>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title="Andon Checklist">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfquery name="Sectors" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT ID, Sector FROM AndonSectors
WHERE Status IS NULL
ORDER BY Sector
</cfquery>

<cfquery name="Questions" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT qID, Question, Max(RevNo) as maxRevNo 
FROM AndonQuestions 
GROUP BY qID, Question
ORDER BY qID
</cfquery> 

<cfquery name="Offices" datasource="Corporate">
SELECT OfficeName, ID FROM IQAtblOffices
WHERE Finance = 'Yes'
</cfquery>

<div class="blog-content">
<cfif isDefined("Form.Submit")>

<cfquery name="newID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as newID FROM Andon
</cfquery> 

<cfquery name="AddnewID" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO Andon(ID) VALUES(#newId.newID#)
</cfquery> 

<cfloop index="i" from="1" to="9">
	<cfparam name="Q#i#Comments" default="No Comments">
</cfloop>

<cfquery name="AddnewRow" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE Andon
SET
AuditorName = '#Form.AuditorName#',
<cfif len(form.L2Name)>L2Name = '#Form.L2Name#',</cfif>
<cfif len(form.L2Dept)>L2Dept = '#Form.L2Dept#',</cfif>
<cfif isDefined("form.L2Location")>L2Location = '#Form.L2Location#',</cfif>
<cfif len(form.L3Name)>L3Name = '#Form.L3Name#',</cfif>
<cfif len(form.L3Dept)>L3Dept = '#Form.L3Dept#',</cfif>
<cfif isDefined("form.L3Location")>L3Location = '#Form.L3Location#',</cfif>
CCN = '#Form.CCN#',
Sector = '#Form.Sector#',
Q1 = '#Form.Q1#',
Q1Comments = '#Form.Q1Comments#',
Q2 = '#Form.Q2#',
Q2Comments = '#Form.Q2Comments#',
Q3 = '#Form.Q3#',
Q3Comments = '#Form.Q3Comments#',
Q4 = '#Form.Q4#',
Q4Comments = '#Form.Q4Comments#',
Q5 = '#Form.Q5#',
Q5Comments = '#Form.Q5Comments#',
Q6 = '#Form.Q6#',
Q6Comments = '#Form.Q6Comments#',
Q7 = '#Form.Q7#',
Q7Comments = '#Form.Q7Comments#',
Q8 = '#Form.Q8#',
Q8Comments = '#Form.Q8Comments#',
Q9 = '#Form.Q9#',
Q9Comments = '#Form.Q9Comments#',
AuditDate = #CreateODBCDateTime(Form.AuditDate)#,
Complete = 'No'

WHERE ID = #newID.newID#
</cfquery>

<cflocation url="Andon_Review.cfm?ID=#newID.newID#" addtoken="no">

<cfelse>

<br />
<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" Action="#CGI.SCRIPT_NAME#">

<cfoutput>
<cfinput type="hidden" value="#now()#" name="AuditDate">

<cflock scope="Session" timeout="5">
Auditor: <b>#SESSION.Auth.Username#</b>
<cfinput type="hidden" value="#Session.Auth.UserName#" name="AuditorName">
</cflock>
</cfoutput>
<br /><br />

<Table border="0">
<tr>
<td class="blog-content">
Name of L2:<br />
<cfinput type="text" name="L2Name" size="50" required="no" message="L2 - Name"><br /><br />

L2 Department: (example: 3016ANBK)<br />
<cfinput type="text" name="L2Dept" size="50" maxlength="8" required="no" message="L2 - Department Number"><br /><br />

L2 Location: <br />
    <cfselect 
        name="L2Location" 
        size="12" 
        multiple="No" 
        query="Offices" 
        required="no"
        message="L2 - Location"
        display="OfficeName" 
        value="OfficeName" 
        class="blog-content">
    </cfselect><br><br>
</td>
<td class="blog-content">
Name of L3:<br />
<cfinput type="text" name="L3Name" size="50" required="no" message="L3 - Name"><br /><br />

L3 Department: (example: 3016ANBK)<br />
<cfinput type="text" name="L3Dept" size="50" maxlength="8" required="no" message="L3 - Department Number"><br /><br />

L3 Location:<br />
    <cfselect 
        name="L3Location" 
        size="12" 
        multiple="No" 
        query="Offices" 
        required="no"
        message="L3 - Location"
        display="OfficeName" 
        value="OfficeName" 
        class="blog-content">
    </cfselect><br><br>
</td>
</tr>
<tr>
<td colspan="2" class="blog-content" valign="top">   
<strong><u>Note</u></strong> - Information for the L2 <strong>OR</strong> L3 is required - both cannot be left blank.<br /><br />

CCN:<br />
<cfinput type="text" name="CCN" size="25" required="yes" message="CCN" maxlength="10"><br /><br />

Project Industry/Sector: <br />
    <cfselect 
        name="Sector" 
        size="10" 
        query="Sectors" 
        required="yes"
        message="Project Industry/Sector"
        display="Sector" 
        value="Sector" 
        class="blog-content">
    </cfselect><br><br>
</td>
</tr>
</Table>

<table border="0" class="blog-content">
<tr>
<td class="blog-content">
<b>References to Table 1 and 2 in the questions below refer to document 95-OP-G0026.</b>
</td>
</tr>
<cfoutput query="Questions">
<tr>
<td class="blog-content">
#qID#. #Question# 
<cfif qID eq 7>
	(Numbers only)
<cfelseif qID eq 9>
	Provide the Project or SR Number if applicable.
</cfif>
<br>
	<cfif qID eq 5>
    	<cfinput type="Radio" value="No" name="Q#qID#" checked> No
	<cfelseif qID eq 6>
    	<cfinput type="Radio" value="Yes" name="Q#qID#" checked> Yes 
        <cfinput type="Radio" value="No" name="Q#qID#"> No
        <cfinput type="Radio" value="NA" name="Q#qID#"> NA (If Andon has not been completed) 
    <cfelseif qID eq 7>
    	<cfinput type="text" name="Q#qID#" required="yes" message="Question #qID# - Length of Time (Numbers only)" validate="float" validateat="onsubmit">
    <cfelse>
		<cfinput type="Radio" value="Yes" name="Q#qID#" checked> Yes
        <cfinput type="Radio" value="No" name="Q#qID#"> No
    </cfif><br>
<cftextarea name="Q#qID#Comments" cols="100" rows="4" class="blog-content" required="yes" message="Question #qID# - Comments"><cfif qID eq 5>Data not available to answer this question.<cfelse>Please provide comments if necessary.</cfif>
</cftextarea>
<br />
</td>
</tr>
</cfoutput>
</table>

<INPUT TYPE="Submit" value="Submit" Name="Submit">
</cfFORM>
</cfif>
</div>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->