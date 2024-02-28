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

<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
SELECT * FROM IQAtblOffices
WHERE Exist <> 'No'
ORDER BY OfficeName
</cfquery>

<cfquery Datasource="Corporate" name="ProgDetail"> 
SELECT IQAtblOffices.ID, IQAtblOffices.OfficeName, ProgDev.* 
FROM IQAtblOffices, ProgDev
WHERE ProgDev.ID = #URL.ProgID#
AND IQAtblOffices.ID = ProgOversight
</CFQUERY>

<cfquery Datasource="Corporate" name="ProgLoc"> 
SELECT * from IQAtblOffices, ProgDev, ProgLocDev
WHERE ProgDev.ID = #URL.ProgID#
AND IQAtblOffices.ID = LocOp
AND ProgDev.ID = ProgID
ORDER BY OfficeName
</CFQUERY>

<cfquery Datasource="Corporate" name="Prog">
SELECT * from ProgDev
WHERE ProgDev.ID = #URL.ProgID#
</CFQUERY>

<cfquery Datasource="Corporate" name="Progs">
SELECT ID, Program from ProgDev
ORDER BY Program
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="UL Programs Master List - Edit Program">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<cfoutput query="progdetail">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="_Prog_edit_submit.cfm?progid=#url.progid#">
<b>Program</b><br>
#Program#<br><br>

<font color="red">Note: Contact Chris Nicastro to change the Program Name.</font><br><br>

<b>Program Manual Link</b><br>
<INPUT TYPE="TEXT" NAME="Manual" size="100" VALUE="#Manual#" displayname="Program Manual Link"><br><br>

<b>Program Owner</b><br>
<INPUT TYPE="TEXT" NAME="e_ProgOwner" size="40" VALUE="#ProgOwner#" displayname="Program Owner"><br><br>

<b>Program Owner Email</b><br>
<INPUT TYPE="TEXT" NAME="POEmail" size="40" VALUE="#POEmail#" displayname="Program Owner Email"><br><br>

<b>Location Owner</b><br>
<SELECT NAME="e_LocOwner">
			<OPTION VALUE="#LocOwner#" selected>#LocOwner#
</CFOUTPUT>
<CFOUTPUT QUERY="LocOwner">
		<OPTION VALUE="#LocOwner#">#LocOwner#
</CFOUTPUT>
</SELECT>
<br><br>

<cfoutput query="progdetail">
<b>Program Manager</b><br>
<INPUT TYPE="TEXT" NAME="e_Manager" size="40" VALUE="#Manager#" displayname="Program Manager"><br><br>

<b>Program Manager Email</b><br>
<INPUT TYPE="TEXT" NAME="PMEmail" size="40" VALUE="#PMEmail#" displayname="Program Manager Email"><br><br>
</cfoutput>

<cfif ProgDetail.Type is "Ancillary">
<cfoutput query="progdetail">
<b>Program Specialist (for Ancillary Programs only)</b><br>
<INPUT TYPE="TEXT" NAME="Specialist" size="40" VALUE="#Specialist#" displayname="Program Specialist"><br><br>

<b>Program Specialist Email</b><br>
<INPUT TYPE="TEXT" NAME="Semail" size="40" VALUE="#SEmail#" displayname="Program Specialist Email"><br><br>

	<cfquery Datasource="Corporate" name="Ancillary"> 
	SELECT * from ProgDev
	WHERE ID = <Cfif NOT len(progdetail.parent)>1<cfelse>#ProgDetail.Parent#</CFIF>
	</CFQUERY>

<b>Ancillary Programs - Parent Program</b><br>
<select name="Parent">
		<option value="#Parent#" selected>#Ancillary.Program#
</cfoutput>
<cfoutput query="Progs">
		<option value="#ID#">#Program#
</cfoutput>
</select>
<br>
</cfif>

<cfoutput query="progdetail">
<b>Commercial Owner</b><br>
<INPUT TYPE="TEXT" NAME="COwner" size="70" VALUE="#Cowner#" displayname="Commercial Owner"><br><br>

<b>Guide Reference</b><br>
<INPUT TYPE="TEXT" NAME="GuideRef" size="25" VALUE="#GuideRef#" displayname="Guide Reference"><br><br>

<B>Region</b> #Region#<br>
<SELECT NAME="e_Region">
		<OPTION VALUE="#Region#" selected>#Region#
</cfoutput>
<CFOUTPUT QUERY="ProgRegion">
		<OPTION VALUE="#ProgRegion#">#ProgRegion#
</CFOUTPUT>
</SELECT>
<br><br>

<cfoutput query="progdetail">
<b>Type of Program</b><br>
<SELECT NAME="e_Type">
		<OPTION VALUE="#Type#" selected>#Type#
</cfoutput>
<CFOUTPUT QUERY="ProgType">
		<OPTION VALUE="#ProgType#">#ProgType#
</CFOUTPUT>
</SELECT>
<br><br>

<cfif progdetail.Type is NOT "Ancillary">
<b>For Ancillary Programs ONLY - Parent Program</b><br>
<select name="Parent">
		<option>Select Below
<cfoutput query="Progs">
		<option value="#ID#">#Program#
</cfoutput>
</select>
<br>

<cfoutput query="progdetail">
<b>Program Specialist (for Ancillary Programs only - some exceptions)</b><br>
<INPUT TYPE="TEXT" NAME="Specialist" size="40" VALUE="<cfif len(Specialist)>#Specialist#</cfif>" displayname="Program Specialist"><br><br>

<b>Program Specialist Email</b><br>
<INPUT TYPE="TEXT" NAME="Semail" size="40" VALUE="<cfif len(SEMail)>#SEMail#</cfif>" displayname="Program Specialist Email"><br><br>
</cfoutput>
</cfif>

<cfoutput query="progdetail">
<b>CPC</b><br>
<cfswitch expression="#CPCMR#">
	<cfcase value="1">
	Yes <INPUT TYPE="Radio" name="CPCMR" value="1" checked> No <INPUT TYPE="Radio" name="CPCMR" value="0">
	</cfcase>
	<cfcase value="0">
	Yes <INPUT TYPE="Radio" name="CPCMR" value="1"> No <INPUT TYPE="Radio" name="CPCMR" value="0" checked>
	</cfcase>
	<cfcase value="">
	Yes <INPUT TYPE="Radio" name="CPCMR" value="1"> No <INPUT TYPE="Radio" name="CPCMR" value="0">
	</cfcase>
</cfswitch><br><br>

<b>CPO</b><br>
<cfswitch expression="#CPO#">
	<cfcase value="1">
	Yes <INPUT TYPE="Radio" name="CPO" value="1" checked> No <INPUT TYPE="Radio" name="CPO" value="0">
	</cfcase>
	<cfcase value="0">
	Yes <INPUT TYPE="Radio" name="CPO" value="1"> No <INPUT TYPE="Radio" name="CPO" value="0" checked>
	</cfcase>
	<cfcase value="">
	Yes <INPUT TYPE="Radio" name="CPO" value="1"> No <INPUT TYPE="Radio" name="CPO" value="0">
	</cfcase>
</cfswitch><br><br>

<b>Silver/Bronze</b><br>
<cfswitch expression="#Silver#">
	<cfcase value="1">
	Yes <INPUT TYPE="Radio" name="Silver" value="1" checked> No <INPUT TYPE="Radio" name="Silver" value="0">
	</cfcase>
	<cfcase value="0">
	Yes <INPUT TYPE="Radio" name="Silver" value="1"> No <INPUT TYPE="Radio" name="Silver" value="0" checked>
	</cfcase>
	<cfcase value="">
	Yes <INPUT TYPE="Radio" name="Silver" value="1"> No <INPUT TYPE="Radio" name="Silver" value="0">
	</cfcase>
</cfswitch><br><br>

<cflock scope="SESSION" timeout="60">
	<CFIF SESSION.Auth.accesslevel is "SU" OR SESSION.Auth.AccessLevel is "Admin">
		<b>IQA</b><br>
		<cfswitch expression="#IQA#">
			<cfcase value="1">
			 Yes <INPUT TYPE="Radio" name="IQA" value="1" checked> No <INPUT TYPE="Radio" name="IQA" value="0">
			</cfcase>
			<cfcase value="0">
			 Yes <INPUT TYPE="Radio" name="IQA" value="1"> No <INPUT TYPE="Radio" name="IQA" value="0" checked>
			</cfcase>
			<cfcase value="">
			 Yes <INPUT TYPE="Radio" name="IQA" value="1"> No <INPUT TYPE="Radio" name="IQA" value="0">
			</cfcase>
		</cfswitch><br><br>
	<cfelseif SESSION.Auth.AccessLevel is "CPO">
	 <input type="hidden" name="IQA" value="#IQA#">
	</cfif>
</cflock>

<b>Status</b><br>
<Select Name="e_Status">
	<OPTION VALUE="<cfif NOT len(status)>Active<cfelse>#Status#</cfif>" selected><cfif NOT len(status)>Active<cfelse>#Status#</cfif>
	<OPTION VALUE="Active">Active
	<OPTION VALUE="Pending">Pending
	<OPTION VALUE="Under Review">Under Review
	<OPTION VALUE="Withdrawn">Withdrawn		
	<OPTION VALUE="Removed">Removed
</SELECT><br><br>

Note: Status = Removed - The program will be removed from all Program List views. The revision history will remain and the program will be able to be seen via the 'removed programs' listing.<br><br>

<b>Withdrawn Date</b> (mm/dd/yyyy, Only for Status = Withdrawn)<br>
<INPUT TYPE="TEXT" NAME="EndDate" size="40" VALUE="<cfif len(EndDate)>#dateformat(EndDate, "mm/dd/yyyy")#</cfif>" displayname="Withdrawn Date"><br><br>

<b>Effective Date for a Pending Program</b> (mm/dd/yyyy, Only for Status = Pending)<br>
<INPUT TYPE="TEXT" NAME="StartDate" size="40" VALUE="<cfif len(StartDate)>#dateformat(StartDate, "mm/dd/yyyy")#</cfif>" displayname="Effective Date for a Pending Program"><br><br>

<b>Comments</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="75" NAME="Comments">#Comments#</textarea><br><br>

<b>Notes</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="75" NAME="Notes">#Notes#</textarea><br><br>

<b>Oversight Location</b><br>
<Select Name="e_ProgOversight">
	<OPTION VALUE="#ProgOversight#" selected>#OfficeName#
</cfoutput>
<cfoutput query="OfficeName">
	<OPTION VALUE="#ID#">#OfficeName#
</cfoutput>
</SELECT>
<br><br>

<b>Document Revision Details:</b><br>
<textarea WRAP="PHYSICAL" ROWS="5" COLS="75" NAME="e_RevDetails" displayname="Revision Details"></textarea><br><br>

<INPUT TYPE="button" value="Save and Continue" onClick=" javascript:checkFormValues(document.all('Audit'));">

</form>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->