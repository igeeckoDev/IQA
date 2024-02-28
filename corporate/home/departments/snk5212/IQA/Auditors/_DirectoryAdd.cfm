<!---
<cfloop index=i from=239 to=400>
	<cfset currentDirectory = GetDirectoryFromPath(GetCurrentTemplatePath()) & #i#>
	<cfoutput>
	#currentDirectory#<br>
	</cfoutput>
	<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfloop>
--->