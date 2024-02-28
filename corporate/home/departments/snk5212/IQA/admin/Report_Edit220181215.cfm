<!--- SubTitle and subTitle2 (if necessary) of Page --->
<cfset subTitle="Edit Report Page 2 - #URL.Year#-#URL.ID#-#URL.AuditedBy#">

<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<script language="JavaScript" src="../webhelp/webhelp.js"></script>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT Month, AuditType, AuditType2, ID, YEAR_ as "Year", AuditedBY, StartDate
FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cfif Check.AuditedBy eq "IQA">
	<cfif Check.year GTE 2015>
		<CFQUERY BLOCKFACTOR="100" name="Time" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		UPDATE IQAAuditTime
		SET
		PlanningTime = '#Form.e_PlanningTime#',
		ReportingTime = '#Form.e_ReportingTime#'

		WHERE ID = #URL.ID#
		AND Year_ = #URL.Year#
		</cfquery>
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE Report
SET

<!--- 8/29/2007 updated update query for new fields 8/29/2007 --->

<cfif form.offices is "None" or form.offices is "NoChanges">
<cfelse>
Offices='#Form.Offices#',
</cfif>

<cfif isDefined("Form.Sector")>
<cfif form.Sector is "None" or form.Sector is "NoChanges">
<cfelse>
Sectors='#Form.Sector#',
</cfif>
</cfif>

<cfif Check.AuditType2 is NOT "Program">
<cfif form.programs is "None">
Programs='',
<cfelseif form.programs is "NoChanges">
<!--- do nothing --->
<cfelse>
Programs='#Form.programs#',
</cfif>
</cfif>

<cfif Check.Year gt 2009 OR Check.Year eq 2009 AND Check.Month gte 4>
	KCInfo='#Form.KCInfo#',
	<cfif len(Form.KCInfo2)>
		KCInfo2='#Form.KCInfo2#',
	</cfif>
<cfelse>
	KCInfo='#Form.e_KCInfo#',
</cfif>

Count1=#Form.e_Count1#,
Count2=#Form.e_Count2#,
Count3=#Form.e_Count3#,
Count4=#Form.e_Count4#,
Count5=#Form.e_Count5#,
Count6=#Form.e_Count6#,
Count7=#Form.e_Count7#,
Count8=#Form.e_Count8#,
Count9=#Form.e_Count9#,
Count10=#Form.e_Count10#,
Count11=#Form.e_Count11#,
Count12=#Form.e_Count12#,
Count13=#Form.e_Count13#,
Count14=#Form.e_Count14#,
Count15=#Form.e_Count15#,
Count16=#Form.e_Count16#,
CAR1='#Form.e_CAR1#',
CAR2='#Form.e_CAR2#',
CAR3='#Form.e_CAR3#',
CAR4='#Form.e_CAR4#',
CAR5='#Form.e_CAR5#',
CAR6='#Form.e_CAR6#',
CAR7='#Form.e_CAR7#',
CAR8='#Form.e_CAR8#',
CAR9='#Form.e_CAR9#',
CAR10='#Form.e_CAR10#',
CAR11='#Form.e_CAR11#',
CAR12='#Form.e_CAR12#',
CAR13='#Form.e_CAR13#',
CAR14='#Form.e_CAR14#',
CAR15='#Form.e_CAR15#',
CAR16='#Form.e_CAR16#',
OCount1=#Form.e_OCount1#,
OCount2=#Form.e_OCount2#,
OCount3=#Form.e_OCount3#,
OCount4=#Form.e_OCount4#,
OCount5=#Form.e_OCount5#,
OCount6=#Form.e_OCount6#,
OCount7=#Form.e_OCount7#,
OCount8=#Form.e_OCount8#,
OCount9=#Form.e_OCount9#,
OCount10=#Form.e_OCount10#,
OCount11=#Form.e_OCount11#,
OCount12=#Form.e_OCount12#,
OCount13=#Form.e_OCount13#,
OCount14=#Form.e_OCount14#,
OCount15=#Form.e_OCount15#,
OCount16=#Form.e_OCount16#,

<cfif Check.Year is "2007">
	<cfif Check.Month gte 9>
Count17=#Form.e_Count17#,
Count18=#Form.e_Count18#,
Count19=#Form.e_Count19#,
Count20=#Form.e_Count20#,
Count21=#Form.e_Count21#,
Count22=#Form.e_Count22#,
CAR17='#Form.e_CAR17#',
CAR18='#Form.e_CAR18#',
CAR19='#Form.e_CAR19#',
CAR20='#Form.e_CAR20#',
CAR21='#Form.e_CAR21#',
CAR22='#Form.e_CAR22#',
OCount17=#Form.e_OCount17#,
OCount18=#Form.e_OCount18#,
OCount19=#Form.e_OCount19#,
OCount20=#Form.e_OCount20#,
OCount21=#Form.e_OCount21#,
OCount22=#Form.e_OCount22#,
OCountOther=0,
CAROther='0',
CountOther=0,
	<cfelse>
	<!--- for pre-9/2007 audits --->
	Count17=0,
	Count18=0,
	Count19=0,
	Count20=0,
	Count21=0,
	Count22=0,
	CAR17='0',
	CAR18='0',
	CAR19='0',
	CAR20='0',
	CAR21='0',
	CAR22='0',
	OCount17=0,
	OCount18=0,
	OCount19=0,
	OCount20=0,
	OCount21=0,
	OCount22=0,
	</cfif>
<!--- After 2007 --->
<cfelseif Check.Year eq 2008>
	<cfif Check.Month gte 10>
	Count17=#Form.e_Count17#,
	Count18=#Form.e_Count18#,
	Count19=#Form.e_Count19#,
	Count20=#Form.e_Count20#,
	Count21=#Form.e_Count21#,
	Count22=#Form.e_Count22#,
	Count23=#Form.e_Count23#,
	Count24=#Form.e_Count24#,
	Count25=#Form.e_Count25#,
	Count26=#Form.e_Count26#,
	Count27=#Form.e_Count27#,
	Count28=#Form.e_Count28#,
	Count29=#Form.e_Count29#,
	Count30=#Form.e_Count30#,
	Count31=#Form.e_Count31#,
	Count32=#Form.e_Count32#,
	Count33=#Form.e_Count33#,
	Count34=#Form.e_Count34#,
	CAR17='#Form.e_CAR17#',
	CAR18='#Form.e_CAR18#',
	CAR19='#Form.e_CAR19#',
	CAR20='#Form.e_CAR20#',
	CAR21='#Form.e_CAR21#',
	CAR22='#Form.e_CAR22#',
	CAR23='#Form.e_CAR23#',
	CAR24='#Form.e_CAR24#',
	CAR25='#Form.e_CAR25#',
	CAR26='#Form.e_CAR26#',
	CAR27='#Form.e_CAR27#',
	CAR28='#Form.e_CAR28#',
	CAR29='#Form.e_CAR29#',
	CAR30='#Form.e_CAR30#',
	CAR31='#Form.e_CAR31#',
	CAR32='#Form.e_CAR32#',
	CAR33='#Form.e_CAR33#',
	CAR34='#Form.e_CAR34#',
	OCount17=#Form.e_OCount17#,
	OCount18=#Form.e_OCount18#,
	OCount19=#Form.e_OCount19#,
	OCount20=#Form.e_OCount20#,
	OCount21=#Form.e_OCount21#,
	OCount22=#Form.e_OCount22#,
	OCount23=#Form.e_OCount23#,
	OCount24=#Form.e_OCount24#,
	OCount25=#Form.e_OCount25#,
	OCount26=#Form.e_OCount26#,
	OCount27=#Form.e_OCount27#,
	OCount28=#Form.e_OCount28#,
	OCount29=#Form.e_OCount29#,
	OCount30=#Form.e_OCount30#,
	OCount31=#Form.e_OCount31#,
	OCount32=#Form.e_OCount32#,
	OCount33=#Form.e_OCount33#,
	OCount34=#Form.e_OCount34#,
	OCountOther=0,
	CAROther='0',
	CountOther=0,
	<cfelseif Check.Month lt 10>
	Count17=#Form.e_Count17#,
	Count18=#Form.e_Count18#,
	Count19=#Form.e_Count19#,
	Count20=#Form.e_Count20#,
	Count21=#Form.e_Count21#,
	Count22=#Form.e_Count22#,
	CAR17='#Form.e_CAR17#',
	CAR18='#Form.e_CAR18#',
	CAR19='#Form.e_CAR19#',
	CAR20='#Form.e_CAR20#',
	CAR21='#Form.e_CAR21#',
	CAR22='#Form.e_CAR22#',
	OCount17=#Form.e_OCount17#,
	OCount18=#Form.e_OCount18#,
	OCount19=#Form.e_OCount19#,
	OCount20=#Form.e_OCount20#,
	OCount21=#Form.e_OCount21#,
	OCount22=#Form.e_OCount22#,
	OCountOther=0,
	CAROther='0',
	CountOther=0,
	</cfif>
<cfelseif Check.Year gte 2009>
Count17=#Form.e_Count17#,
Count18=#Form.e_Count18#,
Count19=#Form.e_Count19#,
Count20=#Form.e_Count20#,
Count21=#Form.e_Count21#,
Count22=#Form.e_Count22#,
Count23=#Form.e_Count23#,
Count24=#Form.e_Count24#,
Count25=#Form.e_Count25#,
Count26=#Form.e_Count26#,
Count27=#Form.e_Count27#,
Count28=#Form.e_Count28#,
Count29=#Form.e_Count29#,
Count30=#Form.e_Count30#,
Count31=#Form.e_Count31#,
Count32=#Form.e_Count32#,
Count33=#Form.e_Count33#,
Count34=#Form.e_Count34#,
Count35=#Form.e_Count35#,
<cfif Check.Year eq 2010 AND Check.Month gte 9 OR Check.Year gte 2011>
	Count36=#Form.e_Count36#,
	Count37=#Form.e_Count37#,
	CAR36='#Form.e_CAR36#',
	CAR37='#Form.e_CAR37#',
	OCount36=#Form.e_OCount36#,
	OCount37=#Form.e_OCount37#,
	SR36='#Form.e_SR36#',
	SR37='#Form.e_SR37#',
</cfif>
CAR17='#Form.e_CAR17#',
CAR18='#Form.e_CAR18#',
CAR19='#Form.e_CAR19#',
CAR20='#Form.e_CAR20#',
CAR21='#Form.e_CAR21#',
CAR22='#Form.e_CAR22#',
CAR23='#Form.e_CAR23#',
CAR24='#Form.e_CAR24#',
CAR25='#Form.e_CAR25#',
CAR26='#Form.e_CAR26#',
CAR27='#Form.e_CAR27#',
CAR28='#Form.e_CAR28#',
CAR29='#Form.e_CAR29#',
CAR30='#Form.e_CAR30#',
CAR31='#Form.e_CAR31#',
CAR32='#Form.e_CAR32#',
CAR33='#Form.e_CAR33#',
CAR34='#Form.e_CAR34#',
CAR35='#Form.e_CAR35#',
OCount17=#Form.e_OCount17#,
OCount18=#Form.e_OCount18#,
OCount19=#Form.e_OCount19#,
OCount20=#Form.e_OCount20#,
OCount21=#Form.e_OCount21#,
OCount22=#Form.e_OCount22#,
OCount23=#Form.e_OCount23#,
OCount24=#Form.e_OCount24#,
OCount25=#Form.e_OCount25#,
OCount26=#Form.e_OCount26#,
OCount27=#Form.e_OCount27#,
OCount28=#Form.e_OCount28#,
OCount29=#Form.e_OCount29#,
OCount30=#Form.e_OCount30#,
OCount31=#Form.e_OCount31#,
OCount32=#Form.e_OCount32#,
OCount33=#Form.e_OCount33#,
OCount34=#Form.e_OCount34#,
OCount35=#Form.e_OCount35#,
OCountOther=0,
CAROther='0',
CountOther=0,
<!--- 2010 and forward --->
<cfif Check.Year GTE 2010>
SR1='#Form.e_SR1#',
SR2='#Form.e_SR2#',
SR3='#Form.e_SR3#',
SR4='#Form.e_SR4#',
SR5='#Form.e_SR5#',
SR6='#Form.e_SR6#',
SR7='#Form.e_SR7#',
SR8='#Form.e_SR8#',
SR9='#Form.e_SR9#',
SR10='#Form.e_SR10#',
SR11='#Form.e_SR11#',
SR12='#Form.e_SR12#',
SR13='#Form.e_SR13#',
SR14='#Form.e_SR14#',
SR15='#Form.e_SR15#',
SR16='#Form.e_SR16#',
SR17='#Form.e_SR17#',
SR18='#Form.e_SR18#',
SR19='#Form.e_SR19#',
SR20='#Form.e_SR20#',
SR21='#Form.e_SR21#',
SR22='#Form.e_SR22#',
SR23='#Form.e_SR23#',
SR24='#Form.e_SR24#',
SR25='#Form.e_SR25#',
SR26='#Form.e_SR26#',
SR27='#Form.e_SR27#',
SR28='#Form.e_SR28#',
SR29='#Form.e_SR29#',
SR30='#Form.e_SR30#',
SR31='#Form.e_SR31#',
SR32='#Form.e_SR32#',
SR33='#Form.e_SR33#',
SR34='#Form.e_SR34#',
SR35='#Form.e_SR35#',
</cfif>
<!--- before 2007 --->
<cfelseif Check.Year lt 2007>
Count17=0,
Count18=0,
Count19=0,
Count20=0,
Count21=0,
Count22=0,
CAR17='0',
CAR18='0',
CAR19='0',
CAR20='0',
CAR21='0',
CAR22='0',
OCount17=0,
OCount18=0,
OCount19=0,
OCount20=0,
OCount21=0,
OCount22=0,
</cfif>

<cfif len(form.bestprac)>
	<cfset BP = #ReplaceNoCase(Form.BestPrac,"<p>","", "ALL")#>
    <cfset BP2 = #ReplaceNoCase(BP, "</p>","<br><br>", "ALL")#>
    BestPrac=<CFQUERYPARAM VALUE="#Form.BestPrac#" CFSQLTYPE="CF_SQL_CLOB">,
    <!---
    <cfset BP3 = #ReplaceNoCase(BP2,chr(39),"&rsquo;", "ALL")#>
    <cfset BP4 = #ReplaceNoCase(BP3,chr(34),"&quot;", "ALL")#>
    BestPrac='#BP4#',
	--->
</cfif>

<cfif len(form.Summary)>
	<cfset SU = #ReplaceNoCase(Form.Summary,"<p>","", "ALL")#>
    <cfset SU2 = #ReplaceNoCase(SU, "</p>","<br><br>", "ALL")#>
	Summary=<CFQUERYPARAM VALUE="#Form.Summary#" CFSQLTYPE="CF_SQL_CLOB">,
	<!---
    <cfset SU3 = #ReplaceNoCase(SU2,chr(39),"&rsquo;", "ALL")#>
    <cfset SU4 = #ReplaceNoCase(SU3,chr(34),"&quot;", "ALL")#>
	Summary='#SU4#',
	--->
</cfif>

<cfif Check.Year GTE 2016
	OR Check.Year EQ 2015 AND Check.Month GT 10
	OR Check.Year EQ 2015 AND Check.StartDate GTE "10/12/2015">
	<cfif len(form.OFIs)>
		OFIs=<CFQUERYPARAM VALUE="#Form.OFIs#" CFSQLTYPE="CF_SQL_CLOB">,
	</cfif>
</cfif>

<cfset Sc = #ReplaceNoCase(Form.Scope, "<p>","", "ALL")#>
<cfset Sc2 = #ReplaceNoCase(Sc, "</p>","<br><br>", "ALL")#>
Scope=<CFQUERYPARAM VALUE="#Form.Scope#" CFSQLTYPE="CF_SQL_CLOB">,
<!---
<cfset Sc3 = #ReplaceNoCase(Sc2,chr(39),"&rsquo;", "ALL")#>
<cfset Sc4 = #ReplaceNoCase(Sc3,chr(34),"&quot;", "ALL")#>

Scope = '#Sc4#'
--->

ReportDate=#CreateODBCDate(FORM.e_ReportDate)#

WHERE ID = #URL.ID#
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<!---
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET

Email='#Form.e_KCInfo#'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>
--->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT Report2.*, Report2.Year_ as Year
FROM REPORT2
WHERE Report2.ID = #URL.ID#
AND Report2.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<br><div class="blog-time">
Audit Report Help - <A HREF="javascript:popUp('../webhelp/webhelp_auditreport.cfm')">[?]</A></div>

<cfset var=ArrayNew(2)>

<CFSET var[1][1] = 'VCAR1'>
<CFSET var[2][1] = 'VCAR2'>
<CFSET var[3][1] = 'VCAR3'>
<CFSET var[4][1] = 'VCAR4'>
<CFSET var[5][1] = 'VCAR5'>
<CFSET var[6][1] = 'VCAR6'>
<CFSET var[7][1] = 'VCAR7'>
<CFSET var[8][1] = 'VCAR8'>
<CFSET var[9][1] = 'VCAR9'>
<CFSET var[10][1] = 'VCAR10'>
<CFSET var[11][1] = 'VCAR11'>
<CFSET var[12][1] = 'VCAR12'>
<CFSET var[13][1] = 'VCAR13'>
<CFSET var[14][1] = 'VCAR14'>
<CFSET var[15][1] = 'VCAR15'>
<CFSET var[16][1] = 'VCAR16'>
<CFSET var[17][1] = 'VCAR17'>
<CFSET var[18][1] = 'VCAR18'>
<CFSET var[19][1] = 'VCAR19'>
<CFSET var[20][1] = 'VCAR20'>

<CFSET var[1][2] = 'Comments1'>
<CFSET var[2][2] = 'Comments2'>
<CFSET var[3][2] = 'Comments3'>
<CFSET var[4][2] = 'Comments4'>
<CFSET var[5][2] = 'Comments5'>
<CFSET var[6][2] = 'Comments6'>
<CFSET var[7][2] = 'Comments7'>
<CFSET var[8][2] = 'Comments8'>
<CFSET var[9][2] = 'Comments9'>
<CFSET var[10][2] = 'Comments10'>
<CFSET var[11][2] = 'Comments11'>
<CFSET var[12][2] = 'Comments12'>
<CFSET var[13][2] = 'Comments13'>
<CFSET var[14][2] = 'Comments14'>
<CFSET var[15][2] = 'Comments15'>
<CFSET var[16][2] = 'Comments16'>
<CFSET var[17][2] = 'Comments17'>
<CFSET var[18][2] = 'Comments18'>
<CFSET var[19][2] = 'Comments19'>
<CFSET var[20][2] = 'Comments20'>

<cfset var2=ArrayNew(2)>

<cfoutput query="View">
<CFSET var2[1][1] = '#VCAR1#'>
<CFSET var2[2][1] = '#VCAR2#'>
<CFSET var2[3][1] = '#VCAR3#'>
<CFSET var2[4][1] = '#VCAR4#'>
<CFSET var2[5][1] = '#VCAR5#'>
<CFSET var2[6][1] = '#VCAR6#'>
<CFSET var2[7][1] = '#VCAR7#'>
<CFSET var2[8][1] = '#VCAR8#'>
<CFSET var2[9][1] = '#VCAR9#'>
<CFSET var2[10][1] = '#VCAR10#'>
<CFSET var2[11][1] = '#VCAR11#'>
<CFSET var2[12][1] = '#VCAR12#'>
<CFSET var2[13][1] = '#VCAR13#'>
<CFSET var2[14][1] = '#VCAR14#'>
<CFSET var2[15][1] = '#VCAR15#'>
<CFSET var2[16][1] = '#VCAR16#'>
<CFSET var2[17][1] = '#VCAR17#'>
<CFSET var2[18][1] = '#VCAR18#'>
<CFSET var2[19][1] = '#VCAR19#'>
<CFSET var2[20][1] = '#VCAR20#'>

<CFSET var2[1][2] = '#Comments1#'>
<CFSET var2[2][2] = '#Comments2#'>
<CFSET var2[3][2] = '#Comments3#'>
<CFSET var2[4][2] = '#Comments4#'>
<CFSET var2[5][2] = '#Comments5#'>
<CFSET var2[6][2] = '#Comments6#'>
<CFSET var2[7][2] = '#Comments7#'>
<CFSET var2[8][2] = '#Comments8#'>
<CFSET var2[9][2] = '#Comments9#'>
<CFSET var2[10][2] = '#Comments10#'>
<CFSET var2[11][2] = '#Comments11#'>
<CFSET var2[12][2] = '#Comments12#'>
<CFSET var2[13][2] = '#Comments13#'>
<CFSET var2[14][2] = '#Comments14#'>
<CFSET var2[15][2] = '#Comments15#'>
<CFSET var2[16][2] = '#Comments16#'>
<CFSET var2[17][2] = '#Comments17#'>
<CFSET var2[18][2] = '#Comments18#'>
<CFSET var2[19][2] = '#Comments19#'>
<CFSET var2[20][2] = '#Comments20#'>
</cfoutput>

<cfoutput query="View">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="Report_edit3.cfm?#CGI.QUERY_STRING#">
</cfoutput>

<table>
<tr><td colspan="2" class="blog-content"><b>Verified CARs</b><br><Br>
</td></tr>

<tr>
<td class="blog-content"><b>CAR/Audit<br>Finding Number</b></td>
<td class="blog-content"><b>Verification Comments</b></td>
</tr>
<cfloop index="i" to="20" from="1">
<cfoutput>
<tr>
<td><input type="text" name="e_#var[i][1]#" value="#var2[i][1]#" size="10" displayname="#var[i][1]#"></td>
<td><input type="text" name="e_#var[i][2]#" value="#HTMLeditFormat(var2[i][2])#" size="60" displayname="#var[i][2]#"></td>
</tr>
</cfoutput>
</cfloop>
</table>

<!--- added for November 2017 audits and forward - implemented on 11/20/2017 --->
	<cfif Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 73 
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 71 
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 74 
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 166
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 159 
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 383 
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 200 
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 81 
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 82 
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 80 
		OR Check.Year eq 2017 AND Check.Month GTE 11 AND Check.ID eq 135
		OR check.Year eq 2017 AND check.Month EQ 12
		OR Check.Year GTE 2018>
			
		<Br><br>
		<b>CARs that could not be verified during the audit</b><br><Br>
					
		Please list the CARs in 'Closed Awaiting Verification' that meet the following criteria:<br>
			 :: CARs closed too recently to verify during the audit<br>
			 :: CARs where there was not enough evidence to determine the effectiveness (small sample size, no samples, etc)<br><br>

		 Additionally, add a note to these CARs in the "Verification Evidence" field to explain the reason the verification could not be conducted.<br><br>

		<cfoutput query="View">
			<textarea 
				WRAP="PHYSICAL" 
				ROWS="5" 
				COLS="70" 
				NAME="CARsNotVerified"
				data-bvalidator="required" 
				data-bvalidator-msg="CARs that could not be verified during the audit"><cfif len(CARsNotVerified)>#CARsNotVerified#<cfelse>None</cfif></textarea><br><br>
		</cfoutput>

			<font class="warning">If this section is not applicable, please indicate 'None' in the text box above.</font><br><br>
	</cfif>
<!--- /// --->

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->