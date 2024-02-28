<!--- Find out if any documents exist. ID = 0 is a test record, so it is not counted --->
<CFQUERY DataSource="Corporate" Name="Total">
SELECT * FROM CARFiles
<cfif isDefined("URL.CategoryID")>
WHERE CategoryID = #URL.CategoryID#
</cfif>
</cfquery>

<!--- if anything other than the test record exists, proceed --->
<cfif Total.recordcount gt 0>

<!--- set the Category Holder variable blank --->
<cfset CatHolder = ""> 

	<!--- Select a list of DocNumbers for each Category - disclude 0, which is a test record --->
	<CFQUERY DataSource="Corporate" Name="DocNo">
	SELECT DISTINCT DocNumber
	FROM CARFiles
	WHERE DocNumber > 0 AND
	CategoryID = #URL.CategoryID#
	ORDER BY DocNumber
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
		SELECT ID, CategoryID, FileLabel, RevDate, RevAuthor, FileType, DocNumber, PlanType
		FROM CARFiles
		WHERE DocNumber = #DocNumber# AND
		RevNo = #test.MaxRevNo#
		</cfquery>
	
		<!--- Select the Category Name based on the Category ID being used in the cfloop query=Categories --->
		<CFQUERY DataSource="Corporate" Name="CatOutput">
		SELECT CategoryName, CategorySecure, CategoryID
		FROM CARFilesCategory
		WHERE CategoryID = #URL.CategoryID#
		</cfquery>

		<!--- Output Document Information --->
		<CFOUTPUT Query="output">
		<cfif CatOutput.CategorySecure is "No">        
		<cfif CatHolder IS NOT CatOutput.CategoryName>
		<cfIf CatHolder is NOT "">
			</table><br><br>
		</cfif>
		<b><u>#CatOutput.CategoryName#</u></b>
		<table class="blog-content" border="1" width="600">
			<tr class="blog-title">
				<td align="center">File/Link</td>
				<td align="center">Current Rev</td>
				<td align="center">Upload Date</td>
				<td align="center">Author</td>
				<cfif CatOutput.CategoryName eq "IQA Audit Plans">
					<td align="center">Audit Plan Type</td>
				</cfif>
			</tr>
		</cfif>
		<tr class="blog-content">
			<td align="center"><a href="../QE/QEFiles/Doc#DocNumber#Current.#FileType#">#FileLabel#</a> (#FileType#)</td>
			<td align="center">#Test.MaxRevNo#</td>
			<td align="center">#dateformat(RevDate, "mm/dd/yyyy")#</td>
			<td align="center">#RevAuthor#</td>
				<cfif CatOutput.CategoryName eq "IQA Audit Plans">
					<td align="center">#PlanType#</td>
				</cfif>
		</tr>
		<!--- Set Category Holder as the current Category Name --->
		<cfset CatHolder = CatOutput.CategoryName> 
		</td>
		</tr>
        </cfif>
		</CFOUTPUT>
	
</cfloop>

</table>

<cfelse>
	No Documents Exist.
</cfif>

<cfif isDefined("URL.CategoryID")>
	<cfif URL.CategoryID eq "Plans">
	<Br>
	<CFQUERY BLOCKFACTOR="100" name="FS" DataSource="Corporate">
	SELECT *
	FROM FSPlan
	ORDER BY Year_
	</CFQUERY>

	<b><u>Field Service Audit Plans</u></b><Br>

	<cfoutput query="FS">
	#Year_# Plan :: <a href="#IQARootDir#FSPLan/#File_#">View</a><br>
	</cfoutput><Br>
	</cfif>
</cfif>