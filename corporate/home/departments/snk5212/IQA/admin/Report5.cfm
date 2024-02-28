<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Add Report Page 5 - #URL.Year#-#URL.ID#-#URL.AuditedBy#">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a"> 
SELECT ID, Year_ as Year
FROM Report4
WHERE ID = #URL.ID# 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif a.recordcount is 0>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
INSERT INTO Report4(ID, Year_, auditedby)
VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">, '#url.auditedby#')
</cfquery>
</cfif>

<cfquery name="Input" Datasource="Corporate">
UPDATE Report4
SET 

<cfloop index="x" list="#form.fieldnames#">
<cfoutput>
<cfif x is "Comments">
<cfset C1 = #ReplaceNoCase(Form.Comments,chr(13),"<br>", "ALL")#>
Comments='#C1#',
<cfelse>
#x# = #form[x]#,
</cfif>
</cfoutput>
</cfloop>
Placeholder='N/A'

WHERE
Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = #URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Report='4'

WHERE ID = #URL.ID# 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditreport.cfm')">[?]</A></div><br>

<b><u>Field Service ISO/IEC 17020 Audit Coverage</u></b><br>
<br><br>

<cfquery name="Clauses" Datasource="Corporate"> 
SELECT * 
FROM A17020 "17020" 
ORDER BY ID
</cfquery>

<cfquery name="View" Datasource="Corporate">
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year 
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = #URL.ID#
</cfquery>

<cfoutput>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Report5_submit.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">

<table width="750">
<tr>
<td valign="top" class="blog-title">#url.Year#-#url.ID#
</cfoutput>

<table border="1" valign="top">
<tr>
<td class="blog-title">&nbsp;</td>
<td class="blog-title">Audited - Yes/No</td>
</tr>
<cfoutput query="Clauses">
<tr>
<td width="500" class="blog-content">
	<cfif view.year lt 2008>
        #Clause#
    <cfelseif view.year eq 2008 AND view.month lt 10>
        #Clause#
    <cfelse>
        #NewClause#
    </cfif>
</td>
<td class="blog-content">

<cfif ID lt 10>
	<cfset j = "A00">
<cfelse>
	<cfset j = "A0">
</cfif>

	Yes <INPUT TYPE="Radio" NAME="#j##ID#" value="1"> No <INPUT TYPE="Radio" NAME="#j##ID#" value="0" Checked>
</td>
</tr>
</cfoutput>
<tr>
<td colspan="2" class="blog-content">
<br>Audit Coverage Comments: (Not Required)<br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="85" NAME="Comments" Value="" displayname="Audit Coverage Comments"></textarea>
<br><br>
</td>
</tr>
</table>
</td>
</tr>
</table>

<INPUT TYPE="Submit" value="Save and Continue">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->