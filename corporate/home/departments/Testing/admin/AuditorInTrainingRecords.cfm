<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#Request.SiteTitle# - Auditor In Training Records">
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
		        SELECT ID, Lead
		        FROM AuditorList
		        WHERE Auditor = '#SESSION.Auth.Name#'
		        </cfquery>
			</cfif>
		</cfif>

		<cfif SESSION.Auth.AccessLevel eq "SU"
			OR SESSION.Auth.AccessLevel eq "Admin"
			OR AuditorProfile.Lead eq "Yes">
				<a href="CARFilesNewFile.cfm?CategoryID=14"><b>Add</b></a> a Training Record for someone not listed below<br><br>
		</cfif>
	</cfif>
</cflock>

<cfloop index="i" from="14" to="14">
	<!--- Find out if any documents exist. ID = 0 is a test record, so it is not counted --->
	<CFQUERY DataSource="Corporate" Name="Total">
	SELECT * FROM CARFiles
	WHERE CategoryID = #i#
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
	AND CARFilesCategory.CategoryID = #i#
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
		AND Status IS NULL
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

			<cfif i eq 15><br></cfif>

			<b><u>#CatOutput.CategoryName#</u></b>
			<table border="1" width="600">
				<tr>
					<td align="center">File/Link</td>
					<td align="center">Current Rev</td>
					<td align="center">Rev Date</td>
					<td align="center">Author</td>
	                <cflock scope="Session" timeout="5">
						<cfif isDefined("Session.Auth.IsLoggedIn")>
							<cfif SESSION.Auth.Username eq "Bat-Leah" OR SESSION.Auth.AccessLevel eq "SU">
				                <td align="center">Upload New Revision</td>
				            </cfif>
				        </cfif>
					</cflock>
	                <!---
	                <td align="center">Status</td>
					--->
					<cfif CatOutput.CategoryName eq "IQA Audit Plans">
						<td align="center">Audit Plan Type</td>
					</cfif>
				</tr>
			</cfif>
				<tr>
					<td align="left">
					<cflock scope="Session" timeout="5">
						<Cfif FileLabel eq "Training Form" OR FileLabel eq "Training Form - Approvals">
							<a href="../../QE/QEFiles/Doc#DocNumber#Current.#FileType#">#FileLabel#</a>
						<Cfelse>
							<cfif isDefined("Session.Auth.IsLoggedIn")>
								<cfif SESSION.Auth.AccessLevel eq "SU"
									OR SESSION.Auth.AccessLevel eq "Admin"
									OR AuditorProfile.Lead eq "Yes">
										<a href="../../QE/QEFiles/Doc#DocNumber#Current.#FileType#?">#FileLabel#</a>
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
								OR SESSION.Auth.AccessLevel eq "Admin"
								OR AuditorProfile.Lead eq "Yes">
									<td align="center">
										<cfif FileLabel eq "Training Form">
											<cfif isDefined("Session.Auth.IsLoggedIn")>
												<cfif SESSION.Auth.Username eq "Bat-Leah" OR SESSION.Auth.AccessLevel eq "SU">
													<a href="CARFilesUpload.cfm?DocNumber=#DocNumber#">Upload</a>
												<cfelse>
													--
												</cfif>
											<cfelse>
												--
											</cfif>
										<cfelse>
											<a href="CARFilesUpload.cfm?DocNumber=#DocNumber#">Upload</a>
										</cfif>
									</td>
							</cfif>
						</cfif>
					</cflock>
	            	<!---
	            	<td align="center"><cfif status eq "removed"><font class="warning"><b>REMOVED</b></font><cfelse>Active</cfif>
					--->
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

	<cfif i eq 14>
	<b>Upload Instructions</b><br><br>

	:: If the Trainee already has a training record in the "IQA Auditor In-Training Records" table, click their name in the "File/Link" column. This will open the existing training record.<br><br>
	:: If the Trainee does NOT have a training record in the "IQA Auditor In-Training Records" table, click the "Training Form" link in the "File/Link" column in the table below. This will open a black traning record.<br><Br>

	Please save the file to your computer while making edits.<br><br>

	To Upload the updated training record, find the auditor's name and select the "Upload" link in the "New Revision" column in the "IQA Auditor In-Training Records" table above. You will be asked to select the file to upload, and add any revision notes to document the change. Then, select the "Upload New Revision" button on the bottom of the form to upload the form.<br><br>

	<b>Note</b> - Please close your browser and close MS Word before attempting to open a document if you recently opened the previous version. Sometimes the system opens the previous revision of the document if you recently opened the file and uploaded a new revision.<br><br>
	</cfif>
</cfloop>

<B>Auditor In Training Form - 00-QA-F0870 (DCS)</b><br>
<a href="http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/00-QA-F0870/00-QA-F0870.xlsx">00-QA-F0870</a> - Save to your computer before using the form.<br><br>

If you have any issues with the drop down fields not working in the DCS version above, please follow this link to access the form: <a href="http://intranet.ul.com/en/Tools/DeptsServs/Quality/Documents/00-QA-F0870/00-QA-F0870.xlsx">Global Quality Website - 00-QA-F0870 Backup - Rev 3.0, 4/11/2016</a>.<br><br>

<b>Form Instructions</b><Br>
See page one of 00-QA-F0870 for instructions.<br><br>

<Cfoutput>
For standard specific clauses, please view the <a href="#IQADir#matrix.cfm">IQA Standard Category Matrix</a>.<br><br>
</Cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->