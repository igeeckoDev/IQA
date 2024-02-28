<cfquery Datasource="Corporate" name="ProgType">
SELECT * from ProgType
ORDER BY ProgType
</CFQUERY>

<cfquery Datasource="Corporate" name="LocOwner">
SELECT * from LocOwner
ORDER BY LocOwner
</CFQUERY>

<cfquery Datasource="Corporate" name="ProgRegion">
SELECT * from ProgRegion
ORDER BY ProgRegion
</CFQUERY>

<cfquery Datasource="Corporate" name="Progs">
SELECT ID, Program from ProgDev
ORDER BY Program
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
ORDER BY OfficeName
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="UL Programs Master List - Add Program">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="_Prog_add_submit.cfm">
<b>Program</b><br>
<INPUT TYPE="TEXT" NAME="e_Program" size="75" VALUE="" displayname="Program"><br><br>

<b>Program Manual Link</b><br>
<INPUT TYPE="TEXT" NAME="e_Manual" size="100" VALUE="" displayname="Program Manual Link"><br><br>

<b>Program Owner</b><br>
<INPUT TYPE="TEXT" NAME="e_ProgOwner" size="40" VALUE="" displayname="Program Owner"><br><br>

<b>Program Owner Email</b><br>
<INPUT TYPE="TEXT" NAME="e_POEmail" size="40" VALUE="" displayname="Program Owner Email"><br><br>

<b>Location Owner</b><br>
<SELECT NAME="e_LocOwner" displayname="Location Owner">
		<option>Select Below
<CFOUTPUT QUERY="LocOwner">
		<OPTION VALUE="#LocOwner#">#LocOwner#
</CFOUTPUT>
</SELECT>
<br><br>

<b>Program Manager</b><br>
<INPUT TYPE="TEXT" NAME="e_Manager" size="40" VALUE="" displayname="Program Manager"><br><br>

<b>Program Manager Email</b><br>
<INPUT TYPE="TEXT" NAME="e_PMEmail" size="40" VALUE="" displayname="Program Manager Email"><br><br>

<b>Program Specialist (for Ancillary Programs only)</b><br>
<INPUT TYPE="TEXT" NAME="Specialist" size="40" VALUE="" displayname="Program Specialist"><br><br>

<b>Program Specialist Email</b><br>
<INPUT TYPE="TEXT" NAME="Semail" size="40" VALUE="" displayname="Program Specialist Email"><br><br>

<b>Commercial Owner</b><br>
<INPUT TYPE="TEXT" NAME="COwner" size="70" VALUE="" displayname="Commercial Owner"><br><br>

<b>Guide Reference</b><br>
<INPUT TYPE="TEXT" NAME="GuideRef" size="25" VALUE="" displayname="Guide Reference"><br><br>

<B>Region</b><br>
<SELECT NAME="e_Region" displayname="Region">
		<option>Select Below
<CFOUTPUT QUERY="ProgRegion">
		<OPTION VALUE="#ProgRegion#">#ProgRegion#
</CFOUTPUT>
</SELECT>
<br><br>

<b>Type of Program</b><br>
<SELECT NAME="e_Type" displayname="Type of Program">
		<option>Select Below
<CFOUTPUT QUERY="ProgType">
		<OPTION VALUE="#ProgType#">#ProgType#
</CFOUTPUT>
</SELECT>
<br><br>

<b>For Ancillary Programs ONLY - Parent Program</b><br>
<select name="Parent">
		<option>Select Below
<cfoutput query="Progs">
		<option value="#ID#">#Program#
</cfoutput>
</select>
<br>

<b>CPC-MR</b><br>
Yes <INPUT TYPE="Radio" name="CPCMR" value="1"> No <INPUT TYPE="Radio" name="CPCMR" value="0" checked><br><br>

<b>CPO</b><br>
Yes <INPUT TYPE="Radio" name="CPO" value="1"> No <INPUT TYPE="Radio" name="CPO" value="0" checked><br><br>

<b>Silver/Bronze</b><br>
Yes <INPUT TYPE="Radio" name="Silver" value="1"> No <INPUT TYPE="Radio" name="Silver" value="0" checked><br><br>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
<b>IQA</b><br>
Yes <INPUT TYPE="Radio" name="IQA" value="1"> No <INPUT TYPE="Radio" name="IQA" value="0" checked><br><br>
</cfif>
</cflock>

<b>Status</b><br>
<Select Name="e_Status" displayname="Status">
	<option>Select Below
	<OPTION VALUE="Active">Active
	<OPTION VALUE="Pending">Pending
	<OPTION VALUE="Under Review">Under Review
	<OPTION VALUE="Withdrawn">Withdrawn		
</SELECT><br><br>

<b>Withdrawn Date</b> (mm/dd/yyyy, Only for Status = Withdrawn)<br>
<INPUT TYPE="TEXT" NAME="EndDate" size="40" VALUE="" displayname="Withdrawn Date"><br><br>

<b>Effective Date for a Pending Program</b> (mm/dd/yyyy, Only for Status = Pending)<br>
<INPUT TYPE="TEXT" NAME="StartDate" size="40" VALUE="" displayname="Effective Date for a Pending Program"><br><br>

<b>Comments</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="75" NAME="Comments" Value=""></textarea><br><br>

<b>Notes</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="75" NAME="Notes" Value=""></textarea><br><br>

<b>Oversight Location</b><br>
<Select Name="e_ProgOversight" displayname="Oversight Location">
	<option>Select Below
<cfoutput query="OfficeName">
	<OPTION VALUE="#ID#">#OfficeName#
</cfoutput>
</SELECT>
<br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</form>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->