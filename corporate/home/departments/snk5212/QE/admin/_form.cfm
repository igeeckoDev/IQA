<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#CARDir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<cfform name="addAlert" action="_sub.cfm" method="POST" enctype="multipart/form-data">

	<b>Description</B>:<br>
	<textarea WRAP="PHYSICAL" ROWS="20" COLS="60" NAME="Description">Text</textarea><br><br>

<input type="submit" value="Submit">

</cfform>