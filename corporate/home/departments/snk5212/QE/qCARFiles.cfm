<!--- Find out if any documents exist. ID = 0 is a test record, so it is not counted --->
<CFQUERY DataSource="Corporate" Name="Total">
SELECT MAX(ID) as MaxID From CARFiles
</cfquery>

<CFQUERY DataSource="Corporate" Name="TotalPublic">
SELECT *
FROM CARFiles, CARFilesCategory
WHERE CARFilesCategory.CategorySecure = 'No'
AND CARFiles.CategoryID = CARFilesCategory.CategoryID
</cfquery>

<!--- if anything other than the test record exists, proceed --->
<cfif Total.MaxID eq 0>
	No Documents Exist.
<cfelseif TotalPublic.RecordCount eq 0>
	No Documents Exist.
<cfelseif Total.MaxID GT 0 AND TotalPublic.RecordCount GT 0>

<!--- set the Category Holder variable blank --->
<cfset CatHolder = ""> 

<!--- Select a list of the categories assigned to existing files, not including ID = 0, a test record --->
<CFQUERY DataSource="Corporate" Name="Categories">
SELECT DISTINCT CategoryID FROM CARFiles
WHERE CategoryID > 0
ORDER BY CategoryID
</Cfquery>

<!--- loop over the Categories --->
<cfloop query="Categories">
	<!--- Select a list of DocNumbers for each Category - disclude 0, which is a test record --->
	<CFQUERY DataSource="Corporate" Name="DocNo">
	SELECT DISTINCT DocNumber
	FROM CARFiles
	WHERE DocNumber > 0 
    AND CategoryID = #CategoryID#
	AND Status IS NULL
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
		SELECT CategoryName, CategorySecure
		FROM CARFilesCategory
		WHERE CategoryID = #Categories.CategoryID#
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
			<td align="center"><a href="QEFiles/Doc#DocNumber#Current.#FileType#">#FileLabel#</a> (#FileType#)</td>
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
</cfloop>

</table>

</cfif>