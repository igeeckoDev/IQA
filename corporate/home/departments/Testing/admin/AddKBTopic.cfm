<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KB">
SELECT * FROM KBTopics
ORDER BY KBTopics
</CFQUERY>

<!--- Start of Page File --->
<cfset subTitle = "Quality Engineering Knowledge Base">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
						
<cfinclude template="KBMenu.cfm">				  
						  
<br><br>						  

<b>Knowledge Base Main Topics</b>
<br><br>						  
<CFOUTPUT Query="KB"> 
- #KBTopics#<br>
</CFOUTPUT>

<br>
<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="AddKB" action="AddKB_update.cfm">

Add a new Main Topic:<br>
<input name="KBTopics" type="Text" size="70" value="">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</form>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->