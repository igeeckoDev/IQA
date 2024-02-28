<!--- Start of Page File --->
<cfset subTitle = "Frequently Asked Questions - Edit">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="FAQ" Datasource="Corporate"> 
SELECT * FROM IQADB_FAQ "FAQ" 
WHERE ID = #URL.ID#
</CFQUERY>

<cfoutput>
    <script 
        language="javascript" 
        type="text/javascript" 
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>
    
    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<CFOUTPUT QUERY="FAQ">
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="FAQ" ACTION="faq_update.cfm?ID=#ID#">

<span class="blog-title">#Q#</span><Br>
<span class="blog-content">#A#</span><br><br>

<b>Question</b><br>
<input type="text" name="Q" Value="#Q#" size="70"><br><br>

<b>Answer</b><br>
<textarea wrap="soft" type="text" name="A" cols="70" rows="10">#A#</textarea><br><br>

<INPUT TYPE="Submit" value="Save and Continue">
</FORM>	
</CFOUTPUT>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->