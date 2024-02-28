<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "View/Upload - Field Service Yearly Audit Plan">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
	<script language="JavaScript" src="#SiteDir#SiteShared/js/validate.js"></script>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" name="FS" DataSource="Corporate">
SELECT *
FROM FSPlan
ORDER BY Year_
</CFQUERY>

<br>
<cfoutput query="FS">
#Year_# Plan :: <a href="#IQARootDir#FSPLan/#File_#">View</a><br>
</cfoutput><Br>

<cfif isdefined("url.msg") AND isDefined("URL.ID") AND isDefined("URL.Year")>
	<cfif url.msg is "Uploaded">
		<cfoutput>
			<b><font color="red">#URL.Year# FS Plan Uploaded</font></b><br><br>
		</cfoutput>
	</cfif>
</cfif>
	
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="FS" ACTION="FSPlan_Upload.cfm">
Plan Year:<br>
<SELECT NAME="e_Year" displayname="Year">
		<option value="">Select Year Below
		<option value="">---
<cfloop index="i" to="#nextYear#" from="2009">
		<cfoutput><OPTION VALUE="#i#">#i#</cfoutput>
</cfloop>
</SELECT><br><br>

Upload Field Service Audit Plan:<br>
<INPUT NAME="e_File" SIZE=50 TYPE="FILE" displayname="Plan File">

<br><br>
<INPUT TYPE="Submit" value="Upload Plan">
</FORM>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
