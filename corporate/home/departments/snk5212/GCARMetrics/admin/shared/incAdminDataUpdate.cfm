<cfif isDefined("URL.complete") AND URL.Complete gt 0>
	<cfoutput>
    	<span class="warning"><b>Item #url.complete# has been completed</b></span>
        <br /><br />
    </cfoutput>
</cfif>

<b>Steps to Update Data</b><br />
0 :: <u>Do this before attempting Step 1</u> Import Data from xls file using 'Excel To Oracle' (table = GCAR_Metrics_NewImport)<br />

1 ::
<cfif url.complete gte 1>
	<span class="warning"><b>Complete</b></span> -
<cfelse>
	<a href="dbaRemoveCARHistory.cfm">Remove CARHistory field (and 3 other fields) from GCAR_Metrics_NewImport</a>
</cfif><br />

2 ::
<cfif url.complete gte 2>
	<span class="warning"><b>Complete</b></span> - Update GCAR_Metrics_New with data from GCAR_Metrics_NewImport **
<cfelse>
	<a href="dbaCopyData.cfm">Update GCAR_Metrics_New with data from GCAR_Metrics_NewImport</a> **
</cfif><br />

<!---
NOTE - (October 15, 2012): Query no longers works via ColdFusion<br />
Run the following query in Tora:<br />
INSERT INTO GCAR_METRICS_NEW SELECT FROM GCAR_METRICS_NEWIMPORT;<br /><br />
--->

3 ::
<cfif url.complete gte 3>
	<span class="warning"><b>Complete</b></span> - Drop GCAR_Metrics_NewImport
<cfelse>
	<a href="dbaDropTable.cfm?Table=GCAR_Metrics_NewImport">Drop GCAR_Metrics_NewImport</a>
</cfif><br />

4 ::
<cfif url.complete gte 4>
	<span class="warning"><b>Complete</b></span> - Check for Duplicate CARs
<cfelse>
	<a href="dbaDuplicateCARs.cfm">Check for Duplicate CARs</a>
</cfif><br />

5 :: No Longer Used (Update 2008 Fields)<br>
<!---
<cfif url.complete gte 5>
	<span class="warning"><b>Complete</b></span> - Update 2008 Fields
<cfelse>
	<a href="dbaUpdate2008fields.cfm">Update 2008 Fields</a>
</cfif><br />
--->

6 ::
<cfif url.complete gte 6>
	<span class="warning"><b>Complete</b></span> - Update Null values to None Listed
<cfelse>
	<a href="dbaNullsToNoneListed.cfm">Update Null values to None Listed</a>
</cfif><br />

7 ::
<cfif url.complete gte 7>
	<span class="warning"><b>Complete</b></span> - Name and Ampersand Fixes
<cfelse>
	<a href="dbaFixes.cfm">Name and Ampersand Fixes</a>
</cfif><br />

8 ::
<cfif url.complete gte 8>
	<span class="warning"><b>Complete</b></span> - Program Fix - Combine All, N/A, None
<cfelse>
	<a href="dbaProgramFix.cfm">Program Fix - Combine All, N/A, None</a>
</cfif><br />


9 ::
<cfif url.complete gte 9>
	<span class="warning"><b>Complete</b></span> - Trim Fields
<cfelse>
	<a href="dbaTrimFields.cfm">Trim Fields</a>
</cfif><br />

10 ::
<cfif url.complete gte 10>
	<span class="warning"><b>Complete</b></span> - Drop GCAR_Metrics_Old Table
<cfelse>
	<a href="dbaDropTable.cfm?Table=GCAR_Metrics_Old">Drop GCAR_Metrics_Old Table</a>
</cfif><br />

11 ::
<cfif url.complete gte 11>
	<span class="warning"><b>Complete</b></span> - Table Maintenance
<cfelse>
	<a href="dbaRenameTables.cfm">Table Maintenance</a>
</cfif><br />
&nbsp; &nbsp; &nbsp; - Drop Index and Constraint from the current GCAR_Metrics table<br />
&nbsp; &nbsp; &nbsp; - Rename GCAR_Metrics to GCAR_Metrics_Old<br />
&nbsp; &nbsp; &nbsp; - Rename GCAR_Metrics_New to GCAR_Metrics<br />
&nbsp; &nbsp; &nbsp; - Add Index and Constraint to the new GCAR_Metrics table<br />
&nbsp; &nbsp; &nbsp; - Create GCAR_Metrics_New structure from GCAR_Metrics_Template<br />

12 ::
<cfif url.complete gte 12>
	<span class="warning"><b>Complete</b></span> - Set "Last Update" Date
<cfelse>
	<a href="dbaSetLastUpdate.cfm">Set "Last Update" Date</a>
</cfif><br />

13: <b>All steps completed</b><br /><br />

** This has to be done because using Excel to Oracle to upload data into GCAR_Metrics_NewImport changes the data types while importing. To get around this, running an update sql on GCAR_Metrics_New with the data from GCAR_Metrics_NewImport will let us use the appropriate data types.<br /><br />

<b>Information</b><br />
:: <a href="dbaMaxLength.cfm">Max Length of each field in GCAR_Metrics and GCAR_Metrics_New Table</a><br />
:: <a href="dbaDuplicateCARs.cfm">Check for Duplicate CARs</a><br />