<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Edit Report Page 4 - #URL.Year#-#URL.ID#-#URL.AuditedBy#">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
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

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<cfquery name="Output" Datasource="Corporate">
SELECT Report4.*, Report4.Year_ AS Year
FROM Report4
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND ID = #URL.ID#
</cfquery>

<cfif isdefined("url.skip")>
	<cfif url.skip is "No">
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
		UPDATE Report3
		SET
		DC =
		'#Form.DC#', DCComments ='#FORM.e_DCComments#',
		MR=
		'#Form.MR#', MRComments ='#FORM.e_MRComments#',
		IA=
		'#Form.IA#', IAComments ='#FORM.e_IAComments#',
		RE=
		'#Form.RE#', REComments ='#FORM.e_REComments#',
		CA=
		'#Form.CA#', CAComments='#Form.e_CAComments#',
		<!--- added 2/4/2009 --->
		Net=
		'#Form.Net#', NetComments ='#FORM.e_NetComments#'
		<!--- removed 3/5/2009
		Cal=
		'#Form.Cal#', CalComments ='#FORM.e_CalComments#'
		--->
		<!--- // --->

		WHERE ID = #URL.ID#
		AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
		AND AuditedBy = '#URL.AuditedBy#'
		</CFQUERY>
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT AuditType2, Area, ID, YEAR_ as Year, AuditedBy, Desk, Month, AuditArea
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditreport.cfm')">[?]</A><br>
Audit Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A></div>

<cfoutput query="Check">
<cfif AuditType2 is "Field Services" or AuditType2 is "Local Function FS">
	<cfif Year gt 2008 OR Year eq 2008 AND Month gte 10>
<FORM Method="Post" enctype="multipart/form-data" name="Audit" Action="Report_edit4_submitNew.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
	<cfelse>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Report_edit5.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
	</cfif>
<cfelse>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Report_edit4_submitnew.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
</cfif>
</cfoutput>

<cfoutput query="Check" group="ID">
<b><u>Audit Coverage</u></b><br>
Audit Area - #Area#
</cfoutput>
<br><br>

<cfif Check.Year eq 2009>
	<cfquery name="Clauses" Datasource="Corporate">
	SELECT * FROM Clauses
	ORDER BY ID
	</cfquery>

	<cfset maxRow = 35>
<cfelseif Check.Year eq 2010>
	<cfif Check.Month lt 9>
		<cfquery name="Clauses" Datasource="Corporate">
		SELECT * FROM Clauses_2009Jan1
		ORDER BY ID
		</cfquery>

		<cfset maxRow = 35>
	<cfelseif Check.Month gte 9>
		<cfquery name="Clauses" Datasource="Corporate">
		SELECT * FROM Clauses_2010SEPT1
		ORDER BY ID
		</cfquery>

		<cfset maxRow = 37>
	</cfif>
<cfelseif Check.Year gte 2010>
	<CFIF Check.Year gte 2019>
	<cfquery name="Clauses" Datasource="UL06046">
	SELECT * FROM Clauses_2018May17
	ORDER BY ID
	</cfquery>

	<cfset maxRow = 45>
	<CFELSE>
	<cfquery name="Clauses" Datasource="Corporate">
	SELECT * FROM Clauses_2010SEPT1
	ORDER BY ID
	</cfquery>

	<cfset maxRow = 37>
	</CFIF>
<cfelseif Check.Year lt 2009>
	<cfquery name="Clauses" Datasource="Corporate">
	SELECT * FROM Clauses
	ORDER BY ID
	</cfquery>

	<cfset maxRow = 34>
</cfif>

<Table width="700" valign="top">
	
	<td valign="top">

	<Table border="1" width="625" valign="top">
		<tr>
			<td height="25"><b><a href="../matrix.cfm" target="_blank">View</a> Matrix</b></td>
		</tr>

		<cfoutput query="Clauses" startrow="1" maxrows="#maxRow#">
		<tr>
			<td valign="top" height="25">#title#</td>
		</tr>
		</cfoutput>
	</table>

	</td>

<td class="blog-content" valign="top">

<Table border="1" width="100">
	<tr>
		<td valign="top" height="25">
			<b><cfoutput>#url.year#-#url.id#</cfoutput></b>
		</td>
	</tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year_" or col is "ID" or col is "OfficeName" or col is "auditedby" or col is "Placeholder" >
<cfelse>
 <cfoutput query="Output">
<CFIF Check.year gte 2019>
<tr>
<Td valign="top" height="25">
	<cfif output[col][1] IS "1">
		Yes <input type="Radio" name="#col#" Value="1" checked>
		No <INPUT TYPE="Radio" name="#col#" value="0">
	<cfelseif output[col][1] IS "0" >
		Yes <input type="Radio" name="#col#" Value="1">
		No <INPUT TYPE="Radio" name="#col#" value="0" checked>
	</cfif>
</TD>
</TR>

<CFELSE>
<CFIF col is "A038" or Col is "A039" or col is "A040" or Col is "A041" or Col is "A042" or Col is "A043" or Col is "A044" or col is "A045">

<CFELSE>

<tr>
	<td valign="top" height="25">
	<cfif Check.Year eq 2010 AND Check.Month lt 9 AND col eq "A036"
		OR Check.Year eq 2010 AND Check.Month lt 9 AND col eq "A037">
	<cfelseif Check.Year lte 2009 AND col eq "A036"
		OR Check.Year lte 2009 AND col eq "A037"
		OR Check.Year lte 2009 AND col eq "A035">
	<cfelse>
	
		<cfif Check.Desk is "Yes" AND Check.AuditType2 is "Global Function/Process"
		OR check.AuditType2 eq "Program" AND check.AuditArea eq "Scheme Documentation Audit"
		OR Check.AuditType2 eq "Program" AND Check.AuditArea NEQ "Scheme Documentation Audit">

			<cfif output[col][1] IS "1">
			Yes <input type="Radio" name="#col#" Value="1" checked>
			No <INPUT TYPE="Radio" name="#col#" value="0">
			<cfelseif output[col][1] IS "0" >
			Yes <input type="Radio" name="#col#" Value="1">
			No <INPUT TYPE="Radio" name="#col#" value="0" checked>
	
			</cfif>

		<cfelseif Check.AuditType2 eq "Local Function" AND Check.AuditArea EQ "Certification Body (CB) Audit">
	
			<cfif col is "A003">
			Yes <INPUT TYPE="Radio" NAME="#col#" value="1" checked>
			<cfelseif col is "A008">
			Yes <INPUT TYPE="Radio" NAME="#col#" value="1" checked>
			<cfelseif col is "A0011">
			Yes <INPUT TYPE="Radio" NAME="#col#" value="1" checked>
			<cfelseif col is "A0013">
			Yes <INPUT TYPE="Radio" NAME="#col#" value="1" checked>
			<cfelseif col is "A0015">
			Yes <INPUT TYPE="Radio" NAME="#col#" value="1" checked>
			<cfelseif col is "A0017">
			Yes <INPUT TYPE="Radio" NAME="#col#" value="1" checked>
			<cfelse>
				<cfif output[col][1] IS "1">
				Yes <input type="Radio" name="#col#" Value="1" checked>
				No <INPUT TYPE="Radio" name="#col#" value="0">
				<cfelseif output[col][1] IS "0" >
				Yes <input type="Radio" name="#col#" Value="1">
				No <INPUT TYPE="Radio" name="#col#" value="0" checked>
				</cfif>
			</cfif>
		<cfelse>
		<cfif col is "A003">
			<cfif FORM.DC is NOT "NA">
			Yes <input type="Radio" name="#col#" value="1" checked>
			<cfelse>
			No <input type="Radio" name="#col#" value="0" checked>
			</cfif>
		<cfelseif col is "A011">
			<cfif form.ca is NOT "NA">
			Yes <input type="Radio" name="#col#" value="1" checked>
			<cfelse>
			No <input type="Radio" name="#col#" value="0" checked>
			</cfif>
		<cfelseif col is "A013">
			<cfif form.re is NOT "NA">
			Yes <input type="Radio" name="#col#" value="1" checked>
			<cfelse>
			No <input type="Radio" name="#col#" value="0" checked>
			</cfif>
 		<cfelseif col is "A014">
			<cfif form.ia is NOT "NA">
			Yes <input type="Radio" name="#col#" value="1" checked>
			<cfelse>
			No <input type="Radio" name="#col#" value="0" checked>
			</cfif>
		<cfelseif col is "A015">
			<cfif form.mr is NOT "NA">
			Yes <input type="Radio" name="#col#" value="1" checked>
			<cfelse>
			No <input type="Radio" name="#col#" value="0" checked>
			</cfif>
  		<cfelse>
	  		<cfif output[col][1] IS "1">
	   		Yes <input type="Radio" name="#col#" Value="1" checked>
	   		No <INPUT TYPE="Radio" name="#col#" value="0">
	  		<cfelseif output[col][1] IS "0" >
	   		Yes <input type="Radio" name="#col#" Value="1">
	   		No <INPUT TYPE="Radio" name="#col#" value="0" checked>
	  		</cfif>

	
		</cfif>
		</cfif>
	</td>
	</tr>		
	</cfif>
</CFIF>
</CFIF>
 </cfoutput>
</cfif>
</cfloop>
</TABLE>

<tr>
<td colspan="2" class="blog-content">
<br>Audit Coverage Comments: (Not Required)<br>
<textarea WRAP="PHYSICAL" ROWS="8" COLS="85" NAME="Comments" Value="" displayname="Audit Coverage Comments">
<cfoutput query="output">
<cfset C1 = #ReplaceNoCase(Comments, "<br>", chr(13), "ALL")#>
#C1#
</cfoutput>
</textarea>
<br><br>
</td>
</tr>
</TABLE>

<INPUT TYPE="Submit" value="Save and Continue">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->