<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "#URL.Year#-#URL.ID#-IQA - Pathnotes Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif isdefined("url.msg")>
<br>
<cfoutput><font color="red">#url.msg#</font></cfoutput><br>
</cfif>

<!--- included for Form Validation --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

<cfoutput>
<a href="auditdetails.cfm?id=#url.id#&year=#url.year#">Return to Audit Details</a><br><br />
  
<form id="myform" name="myform" action="PathNotes_Upload_Submit.cfm?ID=#URL.ID#&Year=#URL.Year#" enctype="multipart/form-data" method="post">

Pathnotes File to Upload: (PDF Only)<br />
<input type="File" size="50" name="File" data-bvalidator="extension[pdf],required" data-bvalidator-msg="Please select file of type .pdf"><br><br />

<input type="submit" value="Upload Pathnotes File">
<input type="reset" value="Reset Form">
</form>
</cfoutput>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->