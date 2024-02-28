<!--- Start of Page File --->
<cfset subTitle = "<a href='CARAdminList.cfm'>CAR Administrator Profiles</a> - View CAR Administrator Profile">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="Details" DataSource="Corporate">
SELECT * FROM CARAdminList
WHERE ID = #URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="Backup" DataSource="Corporate">
SELECT ID, Name FROM CARAdminList
WHERE ID = #Details.Backup#
</cfquery>

<cfif isDefined("URL.Msg") AND isDefined("URL.Msg2")>
	<cfoutput>
    	<font color="red">
        <b>#URL.Msg#</b> - [#URL.Msg2#]<br /><br />
		</font>
	</cfoutput>
</cfif>

<CFOUTPUT QUERY="Details">
<a href="CARAdminEdit.cfm?ID=#URL.ID#">Edit</a> Profile<br><br>

<b>Name</b><br>
#Name# (<a href="mailto:#Email#">#Email#</a>)<Br><Br>

<b>Location</b><Br>
#Location#<br><br>
</cfoutput>

<b>CAR Administrator Backup</b><br>
<cfif Backup.recordcount eq 0>
None Listed
<cfelse>
<cfoutput query="Backup">
#Name#
</cfoutput>
</cfif><br><br>

<CFOUTPUT QUERY="Details">
<b>Status</b><br>
#Status#<br><br>

<cfif Status is "In Training">
<b>Trainer</b><br>
<cfif CARTrainer is "">
	None Listed
<cfelse>
	#CARTrainer#
</cfif><br><br>
</cfif>

<b>ISO/IEC Guide 65 Training</b><Br>
<cfif x65 eq "Yes">Yes<cfelse>No</cfif><Br><br>

<b>ISO/IEC 17020 Training</b><Br>
<cfif x17020 eq "Yes">Yes<cfelse>No</cfif><Br><br>

<b>ISO/IEC 17025 Training</b><Br>
<cfif x17025 eq "Yes">Yes<cfelse>No</cfif><Br><br>

<b>ISO/IEC 17065 Training</b><Br>
<cfif x17065 eq "Yes">Yes<cfelse>No</cfif><Br><br>

<b>Corporate CAR Admin</b><br>
<cfif CorpCarAdmin eq "Yes">Yes<cfelse>No</cfif><br><br>

<b>CAR Administrator Trainer</b><br>
<cfif Trainer eq "Yes">Yes<cfelse>No</cfif><br><br>

<b>Designated Corporate Quality Reviewer</b><br>
<cfif DCQR eq "Yes">Yes<cfelse>No</cfif><br><br>

<cfif DCQR eq "Yes">
<b>Designated Areas for Designated Corporate Quality Reviewer</b><br>
	<cfif DCQRArea neq "">
	 #ListChangeDelims(DCQRArea, "<br>")#
	 <cfelse>
	  None Selected
	 </cfif><br><br>
</cfif>

<b>Expertise</b><br>
<cfif Expertise is "">
	None Listed<br><Br>
<cfelse>
	<cfset Dump = #replace(Expertise, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br /><br />", "All")#>
	#Dump2#
</cfif>

<b>Training</b><br>
<cfif Training is "">
	None Listed<br>
<cfelse>
	<cfset Dump = #replace(Training, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br />", "All")#>
	#Dump2#
</cfif><br />

<b>CAR Admin Date</b><br>
<cfif dateadded is "">
Prior to July 29, 2008. See note below.
<cfelse>
#dateformat(dateadded, 'mmmm dd, yyyy')# <cfif dateadded lte "07/29/2008">(See Note Below)</cfif>
</cfif><br><br>

<cfif dateadded lte "07/29/2008" or dateadded is "">
<u>Note</u> - Those who were already CAR Administrators prior to July 29, 2008 were grandfathered as CAR Administrators and continue to serve in that capacity.  They will attend the required CAR Administrator training by March 31, 2009 to be requalified as CAR Administrators.<Br><br>
</cfif>
</CFOUTPUT>

<CFQUERY BLOCKFACTOR="100" NAME="Files" DataSource="Corporate">
SELECT * FROM CARAdminFiles
WHERE CARAdminID = #URL.ID#
AND Remove <> 'Yes'
ORDER BY DateAdded, ID
</cfquery>

<cflock scope="Session" timeout="5">
<cfif IsDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.AccessLevel is "SU">
	<cfoutput>
	<b>CAR Admin Performance</b> - <a href="CARAdminFiles.cfm?ID=#URL.ID#">Add Files</a><br>
	</cfoutput>
	<cfif Files.RecordCount gt 0>
		<cfoutput query="Files">
		 :: (#dateformat(DateAdded, "mm/dd/yyyy")#) <cfif len(filelabel)>#filelabel#<cfelse>#filename#</cfif> - <a href="CARAdmin/#filename#">View</a>
        <cfif remove NEQ "Yes">
			:: <a href="CARAdminFilesRemove.cfm?CARAdminID=#URL.ID#&ID=#ID#">Remove</a>
        </cfif><Br />
		</cfoutput>
	<cfelse>
	Currently there are no files.
	</cfif>
</cfif>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->