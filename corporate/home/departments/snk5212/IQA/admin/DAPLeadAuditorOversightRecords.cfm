<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Request.SiteTitle# - DAP Lead Auditor Oversight Records">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isDefined("url.uploaded") AND isDefined("url.Rev") AND isDefined("url.DocName")>
	<cfoutput>
    <font color="red"><b>#URL.DocName# [RevNo #URL.Rev#] has been uploaded</b></font>
    </cfoutput><br /><br />
</cfif>

<cflock scope="Session" timeout="5">
	<cfif isDefined("Session.Auth.IsLoggedIn")>
		<cfif SESSION.Auth.Accesslevel eq "IQAAuditor">
			<cfif SESSION.Auth.Accesslevel eq "IQAAuditor">
				<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
		        SELECT ID, Qualified, Status
		        FROM AuditorList
		        WHERE Auditor = '#SESSION.Auth.Name#'
		        </cfquery>
			</cfif>
		</cfif>

		<cfif SESSION.Auth.AccessLevel eq "SU"
			OR SESSION.Auth.AccessLevel eq "DAP Qualifier"
			OR SESSION.Auth.AccessLevel eq "Admin"
			OR SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Qualified CONTAINS "DAP Qualifier"
			OR SESSION.Auth.AccessLevel eq "RQM" AND SESSION.Auth.Username eq "Scala"
			OR SESSION.Auth.AccessLevel eq "RQM" AND SESSION.Auth.Username eq "Thelen"
			OR SESSION.Auth.Username eq "Robinson">
				<a href="CARFilesNewFile.cfm?CategoryID=19"><b>Add</b></a> a <b>new</b> record<br><br>
		</cfif>
	</cfif>
</cflock>

<!--- Find out if any documents exist. ID = 0 is a test record, so it is not counted --->
<CFQUERY DataSource="Corporate" Name="Total">
SELECT * FROM CARFiles
WHERE CategoryID = 19
</cfquery>

<!--- set the Category Holder variable blank --->
<cfset CatHolder = "">

<!--- Select a list of the categories assigned to existing files, not including ID = 0, a test record --->
<CFQUERY DataSource="Corporate" Name="Categories">
SELECT DISTINCT CARFiles.CategoryID, CARFilesCategory.CategoryName
FROM CARFiles, CARFilesCategory
WHERE
(CARFiles.CategoryID > 0 AND CARFiles.CategoryID <> 7 AND CARFiles.CategoryID <> 5)
AND CARFiles.CategoryID = CARFilesCategory.CategoryID
AND CARFilesCategory.CategoryID = 19
ORDER BY CARFilesCategory.CategoryName
</Cfquery>

<!--- loop over the Categories --->
<cfloop query="Categories">
	<!--- Select a list of DocNumbers for each Category - disclude 0, which is a test record --->
	<CFQUERY DataSource="Corporate" Name="DocNo">
	SELECT DISTINCT DocNumber, FileLabel
	FROM CARFiles
	WHERE DocNumber > 0
	AND CategoryID = #CategoryID#
	<Cfif CategoryID eq 19>
	AND Status IS NULL
	</cfif>
    ORDER BY FileLabel
	</cfquery>

	<!--- Loop over DocNo Query to obtain Max Rev Number of each DocNo --->
	<cfloop query="DocNo">
		<CFQUERY DataSource="Corporate" Name="test">
		SELECT MAX(RevNo) as MaxRevNo
		FROM CARFiles
		WHERE DocNumber = #DocNumber#
		</cfquery>

		<!--- Grab Document information for specified DocNo and RevNo --->
		<CFQUERY DataSource="Corporate" Name="output">
		SELECT ID, CategoryID, FileLabel, RevDate, RevAuthor, FileType, DocNumber, PlanType, Status
		FROM CARFiles
		WHERE DocNumber = #DocNumber# AND
		RevNo = #test.MaxRevNo#
		</cfquery>

		<!--- Select the Category Name based on the Category ID being used in the cfloop query=Categories --->
		<CFQUERY DataSource="Corporate" Name="CatOutput">
		SELECT CategoryName
		FROM CARFilesCategory
		WHERE CategoryID = #Categories.CategoryID#
		</cfquery>

		<!--- Output Document Information --->
		<CFOUTPUT Query="output">
		<cfif CatHolder IS NOT CatOutput.CategoryName>
		<cfIf CatHolder is NOT "">
			</table><br><br>
		</cfif>

		<b><u>#CatOutput.CategoryName#</u></b>
		<table border="1" width="600">
			<tr>
				<th align="center">File/Link</th>
				<th align="center">Current Rev</th>
				<th align="center">Rev Date</th>
				<th align="center">Author</th>
                <cflock scope="Session" timeout="5">
					<cfif isDefined("Session.Auth.IsLoggedIn")>
						<cfif SESSION.Auth.AccessLevel eq "SU"
							OR SESSION.Auth.AccessLevel eq "DAP Qualifier"
							OR SESSION.Auth.AccessLevel eq "Admin"
							OR SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Qualified CONTAINS "DAP Qualifier"
							OR SESSION.Auth.AccessLevel eq "RQM" AND SESSION.Auth.Username eq "Scala"
							OR SESSION.Auth.AccessLevel eq "RQM" AND SESSION.Auth.Username eq "Thelen"
							OR SESSION.Auth.Username eq "Robinson">
				                <th align="center">Upload New Revision</th>
			            </cfif>
			        </cfif>
				</cflock>
                <!---<th align="center">Status</td>--->
			</tr>
		</cfif>
			<tr>
				<td align="center">
				<cflock scope="Session" timeout="5">
					<Cfif FileLabel eq "Training Form" OR FileLabel eq "Training Form - Approvals">
						<a href="../../QE/QEFiles/Doc#DocNumber#Current.#FileType#">#FileLabel#</a> (#FileType#)
					<Cfelse>
						<cfif isDefined("Session.Auth.IsLoggedIn")>
							<cfif SESSION.Auth.AccessLevel eq "SU"
								OR SESSION.Auth.AccessLevel eq "DAP Qualifier"
								OR SESSION.Auth.AccessLevel eq "Admin"
								OR SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Qualified CONTAINS "DAP Qualifier"
								OR SESSION.Auth.AccessLevel eq "RQM" AND SESSION.Auth.Username eq "Scala"
								OR SESSION.Auth.AccessLevel eq "RQM" AND SESSION.Auth.Username eq "Thelen"
								OR SESSION.Auth.Username eq "Robinson">
									<a href="../../QE/QEFiles/Doc#DocNumber#Current.#FileType#?">#FileLabel#</a> (#FileType#)
							<cfelse>
								#FileLabel#
							</cfif>
						</cfif>
					</cfif>
				</cflock>
				</td>
				<td align="center">#Test.MaxRevNo#</td>
				<td align="center">#dateformat(RevDate, "mm/dd/yyyy")#</td>
				<td align="center">#RevAuthor#</td>
				<cflock scope="Session" timeout="5">
					<cfif isDefined("Session.Auth.IsLoggedIn")>
							<cfif SESSION.Auth.AccessLevel eq "SU"
								OR SESSION.Auth.AccessLevel eq "DAP Qualifier"
								OR SESSION.Auth.AccessLevel eq "Admin"
								OR SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Qualified CONTAINS "DAP Qualifier"
								OR SESSION.Auth.AccessLevel eq "RQM" AND SESSION.Auth.Username eq "Scala"
								OR SESSION.Auth.AccessLevel eq "RQM" AND SESSION.Auth.Username eq "Thelen"
								OR SESSION.Auth.Username eq "Robinson">
								<td align="center">
									<a href="CARFilesUpload.cfm?DocNumber=#DocNumber#">Upload / View Rev History</a>
								</td>
						</cfif>
					</cfif>
				</cflock>
            	<!---<td align="center"><cfif status eq "removed"><font class="warning"><b>REMOVED FROM PUBLIC VIEW</b></font><cfelse>Active</cfif>--->
				<cfif CatOutput.CategoryName eq "IQA Audit Plans">
					<td align="center"><cfif len(PlanType)>#PlanType#<cfelse>--</cfif></td>
				</cfif>
			</tr>
		<!--- Set Category Holder as the current Category Name --->
		<cfset CatHolder = CatOutput.CategoryName>
		</tr>
		</CFOUTPUT>
	</cfloop>
</cfloop>
</table><br>

<b>Oversight Forms</b><br>
<u>DAP Lead Auditor Oversight Form</u><br>
<a href="http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/00-OP-F0405/00-OP-F0405.docx">00-OP-F0405</a><br><br>
<!---<a href="00-OP-F0405/00-OP-F0405.docx">00-OP-F0405 - DAP Lead Auditor Oversight Form</a> (new Rev)<br><br>--->

<u>IECEE CTF Stage 3, Stage 4, AND CBTL Lead Assessor Candidate Application Form</u><br>
<a href="http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/00-IC-F0867/00-IC-F0867.docx">00-IC-F0867</a><br><br>

<b>Qualifier Instructions, Tools, Calls</b> (QE Office 365)<br>
<a href="https://ul.sharepoint.com/sites/quality/539/Shared Documents/Forms/AllItems.aspx?RootFolder=%2Fsites%2Fquality%2F539%2FShared%20Documents%2FDAP%20Performance%20Management%2FDAP%20Oversight%2FQualifier%20Information%20and%20Tools&FolderCTID=0x012000F8973DC62364B544A6CE5E28E450DDF6&View=%7B7EF74934%2D7955%2D485F%2DBAAF%2DF6AA5B8B95BB%7D" target="_blank">View</a><br><br>

<b>Instructions</b><br><br>

:: If the Candidate Lead Auditor (Candidate) has a record listed in the "DAP Lead Auditor Oversight Records" table, click their name in the "File/Link" column to open the file. This will open the existing record. In order to upload a revised record, select the "Upload / View Rev History" link.<br><br>

:: If the Candidate's record is full, please create a new form from the "DAP Lead Auditor Oversight Form" linked above. The form should be uploaded as "[Candidate's Name] - 2", or higher number if there are already multiple records. Use the "Add a new record" link above to upload the record.<br><br>

:: If the Candidate does NOT have a record in the "DAP Lead Auditor Oversight Records" table, please create a new form from the link above and use the "Add a new record" link above to upload the record.<br><Br>

<b>Please save the file to your computer while making edits.</b><br><br>

<b>Note</b> - Please close your browser and close MS Word before attempting to open a document if you recently opened the previous version. Sometimes the system opens the previous revision of the document if you recently opened the file and uploaded a new revision.<br><br>

<b>Access to this page</b><br>
Auditors must have "DAP Qualifier" in their IQA auditor profile to view this page.<br><br>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->