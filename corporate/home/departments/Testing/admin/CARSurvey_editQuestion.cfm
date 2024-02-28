<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "<a href='CARSurvey_Distribution.cfm'>CAR Survey</a> - Edit Question">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="Questions" Datasource="UL06046">
SELECT
	ID, Question
FROM
CARSurvey_Questions
WHERE
	ID = #URL.ID#
ORDER BY
	ID
</CFQUERY>

<cfoutput query="Questions">
<b>#ID#</b> : #Question#<br /><Br />

<cfform method ="post" id="myform" name="myform" action="CARSurvey_updateQuestion.cfm?ID=#URL.ID#">
	<textarea name="Question" type="text" rows="6" cols="40">#Question#</textarea>
    <br><br>

    <input type="submit" value="Save Changes">
	<input type="reset" value="Reset Form"><br /><br />
</cfform>

</cfoutput>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->