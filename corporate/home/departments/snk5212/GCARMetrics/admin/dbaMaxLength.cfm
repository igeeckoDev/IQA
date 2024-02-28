<CFQUERY BLOCKFACTOR="100" NAME="Columns" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
select * FROM GCAR_Metrics
WHERE 1=2
</CFQUERY>

<cfset arrColumns = listToArray(Columns.ColumnList, ",", true)>

<table>
<tr>
<td>
Table: GCAR_Metrics

<table border="1">
<cfloop index="i" from="1" to="#arrayLen(arrColumns)#">
    <CFQUERY BLOCKFACTOR="100" NAME="MaxLength" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    select max(length(#evaluate("arrColumns[#i#]")#)) as Length from GCAR_Metrics
    </CFQUERY>
    
    <cfoutput>
    	<tr>
        	<td>
            	#evaluate("arrColumns[#i#]")#
            </td>
            <td>
            	#MaxLength.Length#
            </td>
		</tr>
	</cfoutput>
</cfloop>
</table>

</td>
<td>
Table: GCAR_Metrics_New

<CFQUERY BLOCKFACTOR="100" NAME="Columns" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
select * FROM GCAR_Metrics_New
WHERE 1=2
</CFQUERY>

<cfset arrColumns = listToArray(Columns.ColumnList, ",", true)>

<table border="1">
<cfloop index="i" from="1" to="#arrayLen(arrColumns)#">
    <CFQUERY BLOCKFACTOR="100" NAME="MaxLength" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    select max(length(#evaluate("arrColumns[#i#]")#)) as Length from GCAR_Metrics_New
    </CFQUERY>
    
    <cfoutput>
    	<tr>
        	<td>
            	#evaluate("arrColumns[#i#]")#
            </td>
            <td>
            	#MaxLength.Length#
            </td>
		</tr>
	</cfoutput>
</cfloop>
</table>

</td>
</tr>
</table>