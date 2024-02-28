<cfset getAxis1 = querynew("")>
<cfset queryaddcolumn (getAxis1, "X", "CF_SQL_integer", ListToArray("1"))>
<cfset queryaddcolumn (getAxis1, "Y", "cf_sql_varchar", ListToArray("5"))>

<cfset getAxis2 = querynew("")>
<cfset queryaddcolumn (getAxis2, "X", "CF_SQL_integer", ListToArray("2"))>
<cfset queryaddcolumn (getAxis2, "Y", "cf_sql_varchar", ListToArray("4"))>

<cfset getAxis3 = querynew("")>
<cfset queryaddcolumn (getAxis3, "X", "CF_SQL_integer", ListToArray("3"))>
<cfset queryaddcolumn (getAxis3, "Y", "cf_sql_varchar", ListToArray("3"))>

<cfset getAxis4 = querynew("")>
<cfset queryaddcolumn (getAxis4, "X", "CF_SQL_integer", ListToArray("4"))>
<cfset queryaddcolumn (getAxis4, "Y", "cf_sql_varchar", ListToArray("2"))>

<cfset getAxis5 = querynew("")>
<cfset queryaddcolumn (getAxis5, "X", "CF_SQL_integer", ListToArray("5"))>
<cfset queryaddcolumn (getAxis5, "Y", "cf_sql_varchar", ListToArray("1"))>

<cfset getAxis6 = querynew("")>
<cfset queryaddcolumn (getAxis6, "X", "CF_SQL_integer", ListToArray("3"))>
<cfset queryaddcolumn (getAxis6, "Y", "cf_sql_varchar", ListToArray("3"))>


<!--- the bit above creates a static query for testing. You'd probably be using an actual query...something like
<cfquery name="getAxis" datasource="myDSN">
Select X, Y from mytbl where someid = #form.someid#
</cfquery>
--->

<cfchart format="jpg"
xaxistitle="X Axis / Approach"
yaxistitle="Y Axis / Effectiveness">

<cfchartseries type="scatter" query="getAxis1" itemcolumn="X" valuecolumn="Y">
<cfchartseries type="scatter" query="getAxis2" itemcolumn="X" valuecolumn="Y">
</cfchart>