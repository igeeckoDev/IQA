<!--- Find out if any documents exist. ID = 0 is a test record, so it is not counted --->
<CFQUERY DataSource="Corporate" Name="Total">
SELECT * FROM CARFiles
WHERE CategoryID = #CatID#
</cfquery>

<!--- if anything other than the test record exists, proceed --->
<cfif Total.recordcount gt 0>

<!--- set the Category Holder variable blank --->
<cfset CatHolder = ""> 

<!--- Select a list of the categories assigned to existing files, not including ID = 0, a test record --->
<CFQUERY DataSource="Corporate" Name="Categories">
SELECT DISTINCT CARFiles.CategoryID, CARFilesCategory.CategoryName 
FROM CARFiles, CARFilesCategory
WHERE CARFiles.CategoryID = #CatID#
AND CARFiles.CategoryID = CARFilesCategory.CategoryID
ORDER BY CARFilesCategory.CategoryName
</Cfquery>

<!--- loop over the Categories --->
<cfloop query="Categories">
	<!--- Select a list of DocNumbers for each Category - disclude 0, which is a test record --->
	<CFQUERY DataSource="Corporate" Name="DocNo">
	SELECT DISTINCT DocNumber, FileLabel
	FROM CARFiles
	WHERE DocNumber > 0 AND
	CategoryID = #CategoryID#
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
		SELECT ID, CategoryID, FileLabel, RevDate, RevAuthor, FileType, DocNumber, PlanType
		FROM CARFiles
		WHERE DocNumber = #DocNumber# AND
		RevNo = #test.MaxRevNo#
        ORDER BY FileLabel
		</cfquery>
	
		<!--- Select the Category Name based on the Category ID being used in the cfloop query=Categories --->
		<CFQUERY DataSource="Corporate" Name="CatOutput">
		SELECT CategoryName, CategorySecure, CategoryID
		FROM CARFilesCategory
		WHERE CategoryID = #Categories.CategoryID#
		</cfquery>
        
		<!--- Output Document Information --->
		<CFOUTPUT Query="output">
		<cfif CatOutput.CategoryID eq CatID>        
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
                <td align="center">New Revision</td>
			</tr>
		</cfif>
		<tr class="blog-content">
			<td align="center"><a href="../../QE/QEFiles/Doc#DocNumber#Current.#FileType#">#FileLabel#</a> (#FileType#)</td>
			<td align="center">#Test.MaxRevNo#</td>
			<td align="center">#dateformat(RevDate, "mm/dd/yyyy")#</td>
			<td align="center">#RevAuthor#</td>
			<td align="center"><a href="CARFilesUpload.cfm?DocNumber=#DocNumber#">Upload</a></td>
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

<cfelse>
	No Documents Exist.
</cfif>