<html>
<head>
<title>TinyMCE Test</title>

<cfoutput>
<script 
	language="javascript" 
	type="text/javascript" 
	src="#CARDir#tinymce/jscripts/tiny_mce/tiny_mce.js">
</script>

<script language="javascript" type="text/javascript">
tinyMCE.init({
	mode : "textareas",
	content_css : "#SiteDir#SiteShared/cr_style.css"
});
</script>
</cfoutput>

</head>
<body>
<cfif isDefined("Form.Sent")>
<cfoutput>#form.content#</cfoutput>
<cfelse>
<cfform name="addAlert" action="#CGI.SCRIPT_NAME#" method="POST" enctype="multipart/form-data">
	<textarea name="content" cols="50" rows="15">This is some content that will be editable with TinyMCE.</textarea>
	<input type="hidden" value="Yes" name="sent">
	<input type="submit" value="Save" />
</cfform>
</cfif>
</body>
</html>