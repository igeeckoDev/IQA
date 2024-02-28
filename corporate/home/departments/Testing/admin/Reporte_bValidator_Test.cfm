<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Add Report Page 3 - #URL.Year#-#URL.ID#-#URL.AuditedBy#">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
SELECT ID, YEAR_ as "Year"
FROM Report2
WHERE ID = #URL.ID#  
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif a.recordcount is 0>
    <CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
    INSERT INTO Report2(ID, Year_, AuditedBy)
    VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">, '#URL.AuditedBy#')
    </cfquery>
</cfif>

<!---
<cfloop index="i" from="1" to="20">
	<cfparam name="#Evaluate("Form.e_Comments#i#")#" default="N/A">
    <cfparam name="#Evaluate("Form.e_VCAR#i#")#" default="0">
</cfloop>
--->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE Report2
SET 

Comments1='#Form.e_Comments1#',
Comments2='#Form.e_Comments2#',
Comments3='#Form.e_Comments3#',
Comments4='#Form.e_Comments4#',
Comments5='#Form.e_Comments5#',
Comments6='#Form.e_Comments6#',
Comments7='#Form.e_Comments7#',
Comments8='#Form.e_Comments8#',
Comments9='#Form.e_Comments9#',
Comments10='#Form.e_Comments10#',
Comments11='#Form.e_Comments11#',
Comments12='#Form.e_Comments12#',
Comments13='#Form.e_Comments13#',
Comments14='#Form.e_Comments14#',
Comments15='#Form.e_Comments15#',
Comments16='#Form.e_Comments16#',
Comments17='#Form.e_Comments17#',
Comments18='#Form.e_Comments18#',
Comments19='#Form.e_Comments19#',
Comments20='#Form.e_Comments20#',
VCAR1='#Form.e_VCAR1#',
VCAR2='#Form.e_VCAR2#',
VCAR3='#Form.e_VCAR3#',
VCAR4='#Form.e_VCAR4#',
VCAR5='#Form.e_VCAR5#',
VCAR6='#Form.e_VCAR6#',
VCAR7='#Form.e_VCAR7#',
VCAR8='#Form.e_VCAR8#',
VCAR9='#Form.e_VCAR9#',
VCAR10='#Form.e_VCAR10#',
VCAR11='#Form.e_VCAR11#',
VCAR12='#Form.e_VCAR12#',
VCAR13='#Form.e_VCAR13#',
VCAR14='#Form.e_VCAR14#',
VCAR15='#Form.e_VCAR15#',
VCAR16='#Form.e_VCAR16#',
VCAR17='#Form.e_VCAR17#',
VCAR18='#Form.e_VCAR18#',
VCAR19='#Form.e_VCAR19#',
VCAR20='#Form.e_VCAR20#'

WHERE ID = #URL.ID# 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Report='2'

WHERE ID = #URL.ID# 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check"> 
SELECT Month, AuditType, AuditType2, ID,YEAR_ as "Year", AuditedBY, Desk
FROM AuditSchedule
WHERE ID = #URL.ID#  
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">  
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cfif Check.Desk is "Yes" AND Check.AuditType2 is "Global Function/Process">
	<cflocation url="Report4.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#&skip=Yes" addtoken="no">
</cfif>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function popUp(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=300,height=300,left = 490,top = 412');");
}
// End -->
</script>	
		
<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditreport.cfm')">[?]</A></div><br>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfoutput>		  
<FORM id="myform" name="myform" METHOD="POST" ENCTYPE="multipart/form-data" ACTION="Report4.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#&Skip=No">
</cfoutput>

Document Control implementation effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=1')">[View Effectiveness Criteria]</A>
<br>
Yes <input type="Radio" Name="DC" Value="Yes"> 
No <INPUT TYPE="Radio" NAME="DC" value="No"> 
N/A <INPUT TYPE="Radio" NAME="DC" value="NA">
Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="DC" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Document Control Implementation Effectiveness">
<br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_DCComments" data-bvalidator="minlength[3],required" data-bvalidator-msg="Document Control Implementation Comments (minimum 3 characters)"></textarea>
<br><br>

Management Review implementation effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=2')">[View Effectiveness Criteria]</A>
<br>
Yes <input type="Radio" Name="MR" Value="Yes"> 
No <INPUT TYPE="Radio" NAME="MR" value="No"> 
N/A <INPUT TYPE="Radio" NAME="MR" value="NA">
Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="MR" value="Cannot Determine Effectiveness"  data-bvalidator="required" data-bvalidator-msg="Select Management Review Implementation Effectiveness"><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_MRComments" data-bvalidator="minlength[3],required" data-bvalidator-msg="Management Review Implementation Comments (minimum 3 characters)"></textarea>
<br><br>

Corrective Action implementation effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=3')">[View Effectiveness Criteria]</A>
<br>
Yes <input type="Radio" Name="CA" Value="Yes"> 
No <INPUT TYPE="Radio" NAME="CA" value="No"> 
N/A <INPUT TYPE="Radio" NAME="CA" value="NA">
Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="CA" value="Cannot Determine Effectiveness"  data-bvalidator="required" data-bvalidator-msg="Select Corrective Action Implementation Effectiveness">
<br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_CAComments" data-bvalidator="minlength[3],required" data-bvalidator-msg="Corrective Action Implementation Comments (minimum 3 characters)"></textarea>
<br><br>

Records implementation effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=4')">[View Effectiveness Criteria]</A>
<br>
Yes <input type="Radio" Name="RE" Value="Yes"> 
No <INPUT TYPE="Radio" NAME="RE" value="No"> 
N/A <INPUT TYPE="Radio" NAME="RE" value="NA">
Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="RE" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Records Implementation Effectiveness"><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_REComments" data-bvalidator="minlength[3],required" data-bvalidator-msg="Records Implementation Comments (minimum 3 characters)"></textarea>
<br><br>

Internal Audits implementation effective?<br>
<A HREF="javascript:popUp('help.cfm?ID=5')">[View Effectiveness Criteria]</A>
<br>
Yes <input type="Radio" Name="IA" Value="Yes"> 
No <INPUT TYPE="Radio" NAME="IA" value="No"> 
N/A <INPUT TYPE="Radio" NAME="IA" value="NA">
Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="IA" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select Internal Audits Implementation Effectiveness">
<br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_IAComments" data-bvalidator="minlength[3],required" data-bvalidator-msg="Internal Audits Implementation Comments (minimum 3 characters)"></textarea>
<br><br>

<!--- added Feb 4 2009 --->
Does the Site have access to files and records via the UL Network?<br>
<A HREF="javascript:popUp('help.cfm?ID=7')">[View Effectiveness Criteria]</A>
<br>
Yes <input type="Radio" Name="Net" Value="Yes"> 
No <INPUT TYPE="Radio" NAME="Net" value="No"> 
N/A <INPUT TYPE="Radio" NAME="Net" value="NA">
Cannot Determine Effectiveness <INPUT TYPE="Radio" NAME="Net" value="Cannot Determine Effectiveness" data-bvalidator="required" data-bvalidator-msg="Select File and Records Access on UL Net">
<br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="NetComments" data-bvalidator="required" data-bvalidator-msg="Files and Records Comments"></textarea>
<br><br>

<!---
External Calibration included in Audit?<br>
<A HREF="javascript:popUp('help.cfm?ID=8')">[View Effectiveness Criteria]</A>
<br>
Yes <input type="Radio" Name="Cal" Value="Yes" Checked> No <INPUT TYPE="Radio" NAME="Cal" value="No"> N/A <INPUT TYPE="Radio" NAME="IA" value="NA"><br>

Please add comments:<br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="70" NAME="e_CalComments" displayname="External Calibration Comments"></textarea>
<br><br>
--->

<input type="submit" value="Save and Continue">
<input type="reset" value="Reset Form">

<!---
<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">
--->

</FORM>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->