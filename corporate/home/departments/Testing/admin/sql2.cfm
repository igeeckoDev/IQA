<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "SQL Console w/ Output - Use Select (CFDUMP Output)">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<FORM METHOD="POST" ENCTYPE="multipart/form-data" name="SQL" ACTION="SQL2_submit.cfm">

Select Schema: Corporate <input type="radio" name="Schema" value="Corporate" checked> 
UL0646 <input type="radio" name="Schema" value="UL06046"><br><Br>

<textarea WRAP="PHYSICAL" ROWS="4" COLS="60" NAME="SQL" Value=""></textarea>
<br><br>
<INPUT TYPE="Submit" value="Submit">
</form>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->