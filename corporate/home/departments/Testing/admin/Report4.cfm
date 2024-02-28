<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Add Report Page 4 - #URL.Year#-#URL.ID#-#URL.AuditedBy#">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="a">
SELECT ID, YEAR_ as "Year"
FROM Report3
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif a.recordcount is 0>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
	INSERT INTO Report3(ID, Year_, AuditedBy)
	VALUES (#URL.ID#, <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">, '#URL.AuditedBy#')
	</cfquery>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT AuditType2, ID, YEAR_ as Year, AuditedBy, Desk, Month, AuditArea
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cfif isdefined("url.skip")>
	<cfif url.skip is "Yes">
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
		UPDATE AuditSchedule
		SET
		Report='3'
		WHERE ID = #URL.ID#
		AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
		AND AuditedBy = '#URL.AuditedBy#'
		</CFQUERY>

	<cfelseif url.skip is "No">
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
		UPDATE Report3

		SET
		DC='#Form.DC#',
		DCComments='#FORM.e_DCComments#',

		MR='#Form.MR#',
		MRComments='#FORM.e_MRComments#',

		IA='#Form.IA#',
		IAComments='#FORM.e_IAComments#',

		RE='#Form.RE#',
		REComments='#FORM.e_REComments#',

		CA='#Form.CA#',
		CAComments='#Form.e_CAComments#',

		<!--- added 2/4/2009 --->
		Net=
		'#Form.Net#', NetComments='#FORM.e_NetComments#'

		<!--- removed 3/5/2009
		Cal=
		'#Form.Cal#', CalComments='#FORM.e_CalComments#'
		--->
		<!--- // --->

		WHERE ID = #URL.ID#
		AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
		AND AuditedBy = '#URL.AuditedBy#'
		</CFQUERY>

		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
		UPDATE AuditSchedule
		SET
		Report='3'
		WHERE ID = #URL.ID#
		AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
		AND AuditedBy = '#URL.AuditedBy#'
		</CFQUERY>
	</cfif>
</cfif>

<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditreport.cfm')">[?]</A><br>
Audit Coverage Help - <A HREF="javascript:popUp('../webhelp/webhelp_plancoverage.cfm')">[?]</A></div><br>

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

<cfoutput query="Check">
<cfif AuditType2 is "Local Function FS" OR AuditType2 is "Field Services">
	<cfif Year gt 2008 OR Year eq 2008 AND Month gte 10>
<FORM Method="Post" enctype="multipart/form-data" name="Audit" Action="Report4_submitnew.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
	<cfelse>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Report5.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
	</cfif>
<cfelse>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Report4_submitNew.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
</cfif>

<table width="750">
<tr>
<td valign="top" class="blog-title">#Year#-#ID#
</cfoutput>

<table border="1" valign="top">
<tr>
<td class="blog-title"><a href="../matrix.cfm" target="_blank">View</a> Matrix</td>
<td class="blog-title">Audited - Yes/No</td>
</tr>
<cfoutput query="Clauses" startrow="1" maxrows="#maxRow#">
<tr>
<td class="blog-content">#title#</td>
<td class="blog-content">
<cfif ID lt 10>
	<cfset j = "A00">
<cfelse>
	<cfset j = "A0">
</cfif>



	Yes <INPUT TYPE="Radio" NAME="#j##ID#" value="1">
	No <INPUT TYPE="Radio" NAME="#j##ID#" value="0" Checked>
	

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