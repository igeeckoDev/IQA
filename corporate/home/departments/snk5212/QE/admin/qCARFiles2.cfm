<!--- Find out if any documents exist. ID = 0 is a test record, so it is not counted --->
<CFQUERY DataSource="Corporate" Name="Total">
SELECT MAX(ID) as MaxID From CARFiles
</cfquery>

<!--- if anything other than the test record exists, proceed --->
<cfif Total.MaxID gt 0>

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
	WHERE DocNumber > 0 AND
	CategoryID = #CategoryID#
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
		SELECT ID, CategoryID, FileLabel, RevDate, RevAuthor, FileType, DocNumber
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
		<cfIf CatHolder is NOT ""><br></cfif>
		<b>#CatOutput.CategoryName#</b><br> 
		</cfif>
		 :: <a href="../QEFiles/Doc#DocNumber#Current.#FileType#">#FileLabel#</a> [Current Rev #Test.MaxRevNo#, #dateformat(RevDate, "mm/dd/yyyy")#, #RevAuthor#]<br>

		<!--- Set Category Holder as the current Category Name --->
		<cfset CatHolder = CatOutput.CategoryName> 
		</CFOUTPUT>
	
	</cfloop>
</cfloop>

<cfelse>
	No Documents Exist.
</cfif>