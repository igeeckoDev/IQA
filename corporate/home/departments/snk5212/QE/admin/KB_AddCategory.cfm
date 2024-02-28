<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset subTitle = "Quality Engineering Knowledge Base - Add Category">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- / --->

<cfif IsDefined("Form.KBTopics")>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="check"> 
SELECT * FROM KBTopics
WHERE KBtopics = '#form.kbtopics#'
</cfquery>

<cfif check.recordcount neq 0>
	<font color="Red">Category already exists.</font>
<cfelse>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBTopicsID"> 
SELECT MAX(ID) + 1 AS newid FROM KBTopics
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KBTopicsIDAdd"> 
INSERT INTO KBTopics(ID)
VALUES (#KBTopicsID.newid#)
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="AddKB"> 
UPDATE KBTopics
SET 
KBTopics='#Form.KBTopics#'
WHERE ID=#KBTopicsID.newid#
</CFQUERY>
</cfif>

	<cflocation url="KB_AddCategory.cfm?msg=#form.KBTopics# has been added" addtoken="No">

</cfif>

<cfif isDefined("URL.MSG")>
	<cfoutput>
    	<font color="red">#url.msg#</font>
    </cfoutput><br /><br />
</cfif>

<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="KB"> 
SELECT * FROM KBTopics
ORDER BY KBTopics
</CFQUERY>

<b>Knowledge Base Categories</b>
<br><br>						  
<CFOUTPUT Query="KB"> 
- #KBTopics#<br>
</CFOUTPUT><br>

<cfform name="AddKB" action="#CGI.SCRIPT_NAME#" method="post">

Add Category:<br>
<cfinput name="KBTopics" type="Text" size="70" value="" required="yes" message="Please add a category name">
<br><br>

<input name="submit" type="submit" value="Submit"> 
</cfform>

<!--- Footer, End of Page HTML --->

<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">

<!--- / --->