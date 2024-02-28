<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title="Andon Checklist">
<cfinclude template="SOP.cfm">

<!--- / --->

<cfquery name="Sectors" datasource="Corporate">
SELECT ID, Sector FROM CAR_Sector
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
<cfFORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" Action="#CGI.SCRIPT_NAME#">

<cfoutput>
Audit Date: #dateformat(now(), "mm/dd/yyyy")#<br /><br />
</cfoutput>

<!---
<cflock scope="Session" timeout="5">
Name of Auditor: #SESSION.Auth.Name#
</cflock><br /><br />
--->

<Table border="0">
<tr>
<td width="400" class="blog-content">
Name of L2:<br />
<cfinput type="text" name="L2Name" size="50" required="yes" message="Name of L2 is required"><br /><br />

<!---
L2 Department: (example: 3016ANBK)<br />
<cfinput type="text" name="L2Dept" size="50" required="yes" message="Department Number of L2 is required"><br /><br />

L2 Location: [drop down]<br />
    <cfselect 
        name="L2Location" 
        size="12" 
        multiple="No" 
        required="Yes"
        message="Select an Office Name" 
        query="Offices" 
        display="OfficeName" 
        value="OfficeName" 
        queryPosition="Below"
        class="blog-content">
    </cfselect><br><br>
</td>
<td class="blog-content">
Name of L3:<br />
<cfinput type="text" name="L2Name" size="60" required="yes" message="Name of L3 is required"><br /><br />

L3 Department: (example: 3016ANBK)<br />
<cfinput type="text" name="L2Dept" size="60" required="yes" message="Department Number of L3 is required"><br /><br />

L3 Location: [drop down]<br />
    <cfselect 
        name="L3Location" 
        size="12" 
        multiple="No" 
        required="Yes"
        message="Select an Office Name" 
        query="Offices" 
        display="OfficeName" 
        value="OfficeName" 
        queryPosition="Below"
        class="blog-content">
    </cfselect><br><br>
</td>
</tr>
<tr>
<td width="400" class="blog-content" valign="top">    
CCN:<br />
<cfinput type="text" name="CCN" size="50" required="yes" message="CCN is required"><br /><br />
</td>
<td class="blog-content" valign="top">
Project Industry/Sector:<br />
    <cfselect 
        name="Sector" 
        size="5" 
        multiple="Yes" 
        required="Yes"
        message="Select Project Industry/Sector" 
        query="Sectors" 
        display="Sector" 
        value="Sector" 
        queryPosition="Below"
        class="blog-content">
    </cfselect><br><br>
</td>
</tr>
</Table>

<table border="0" class="blog-content">
<cfoutput query="Questions">
<tr>
<td class="blog-content">
#qID#. #Question#<br>
	<cfif qID eq 6>
    	<cfinput type="Radio" value="Yes" name="Q#qID#" checked> Yes 
        <cfinput type="Radio" value="No" name="Q#qID#"> No
        <cfinput type="Radio" value="NA" name="Q#qID#"> NA (Andon has not been completed) 
    <cfelseif qID eq 7>
    	input box
    <cfelse>
		<cfinput type="Radio" value="Yes" name="Q#qID#" checked> Yes
        <cfinput type="Radio" value="No" name="Q#qID#"> No
    </cfif><br>
<cftextarea name="#qID#Comments" cols="100" rows="4" required="yes" message="Required" class="blog-content">Please add comments if necessary.</cftextarea>
<br />
</td>
</tr>
</cfoutput>
<tr><td>
--->
<INPUT TYPE="Submit" value="Submit">
</td></tr>
</table>
</cfFORM>
</div>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->