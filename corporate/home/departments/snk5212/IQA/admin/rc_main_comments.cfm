<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY Datasource="Corporate" Name="Check">
SELECT * FROM RC_Comments
</CFQUERY>

<cfset S1 = #ReplaceNoCase(Form.Comments,chr(13),"<br>", "ALL")#>
<cfset S2 = #ReplaceNoCase(S1,chr(39),"&rsquo;", "ALL")#>
<cfset S3 = #ReplaceNoCase(S2,chr(34),"&quot;", "ALL")#>

<cfif Check.recordcount is 0>
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="FirstEntry">
INSERT INTO RC_Comments(ID, Year, Quarter, Comments)
VALUES (1, #Form.Year#, #Form.Quarter#, '#S3#')
</CFQUERY>
</cfif>

<CFQUERY Datasource="Corporate" Name="CheckExist"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT *
 FROM RC_Comments
 WHERE YEAR_=#Form.Year# AND  Quarter = #Form.Quarter#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif CheckExist.recordcount is 0>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query">
SELECT MAX(ID) + 1 AS newid FROM RC_Comments
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Query2">
INSERT INTO RC_Comments(ID, Year, Quarter, Comments)
VALUES (#Query.newid#, #Form.Year#, #Form.Quarter#, '#S3#')
</CFQUERY>

<cfelse>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Update">
UPDATE RC_Comments
SET

Comments='#S3#'

WHERE ID = #CheckExist.ID#
</CFQUERY>

</cfif>

<cflocation url="rc_main_view.cfm?Year=#form.year#&quarter=#form.quarter#" addtoken="no">