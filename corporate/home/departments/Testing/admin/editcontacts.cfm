<CFQUERY BLOCKFACTOR="100" NAME="OfficeName" Datasource="Corporate">
	SELECT * FROM IQAtbloffices
	WHERE OfficeName <> '- None -'
	AND ID = #URL.ID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="<a href='Contacts_new.cfm'>Audit Notification Contacts</a> - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<u>Note</u>: Multiple contacts can be listed in each text box. Separate email addresses with a comma.<br><br>

<cfoutput query="OfficeName">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="Audit" ACTION="updatecontacts.cfm?ID=#ID#">

<b>Office Name</b> <br>
#OfficeName#<br><br>

<b>Region</b> <br>
#subRegion#<br><br>

<b>Contact 1</b> <sup>1</sup> (max 512 characters)<br>
<INPUT TYPE="TEXT" NAME="RQM" VALUE="#RQM#" size="88" maxlength="512"><br><br>

<b>Contact 2</b> <sup>1</sup> (max 512 characters)<br>
<INPUT TYPE="TEXT" NAME="QM" VALUE="#QM#" size="88" maxlength="512"><br><br>

<b>Contact 3</b> <sup>1</sup> (max 512 characters)<br>
<INPUT TYPE="TEXT" NAME="GM" VALUE="#GM#" size="88" maxlength="512"><br><br>

<b>Contact 4</b> <sup>1</sup> (max 512 characters)<br>
<INPUT TYPE="TEXT" NAME="LES" VALUE="#LES#" size="88" maxlength="512"><br><br>

<b>Contact 5</b> <sup>1</sup> (unlimited)<br>
<INPUT TYPE="TEXT" NAME="Other" VALUE="#Other#" size="88"><br><br>

<b>Contact 6</b> <sup>1</sup> (unlimited)<br>
<INPUT TYPE="TEXT" NAME="Other2" VALUE="#Other2#" size="88"><br><br>

<b>Regional Audit Contacts</b> <sup>2</sup> (max 1020 characters)<br>
<INPUT TYPE="TEXT" NAME="Regional1" VALUE="#Regional1#" size="88" maxlength="1020"><br><br>

<INPUT TYPE="TEXT" NAME="Regional2" VALUE="#Regional2#" size="88" maxlength="1020"><br><br>

<INPUT TYPE="TEXT" NAME="Regional3" VALUE="#Regional3#" size="88" maxlength="1020"><br><br>

<!---
<b>QRS</b> <sup>3</sup><br>
<INPUT TYPE="TEXT" NAME="QRS" VALUE="#QRS#" size="88"><br><br>
--->
</cfoutput>

<sup>1</sup> - These fields will include notifications of Corporate Quality Audits.<br>
<sup>2</sup> - These fields will include notifications of Regional Audits.<br>
<!---<sup>3</sup> - These fields will include notifications of QRS Audits.<br>--->
<br>

<INPUT TYPE="Submit" value="Submit Update">
</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->