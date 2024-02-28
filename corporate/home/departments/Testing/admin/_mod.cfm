<cfloop
index="intValue"
from="1"
to="15"
step="1">
 
<!---
Get the result of this Value MOD'ed by 3.
Remember, this will divide 3 into the value
and return the remainder.
--->
<cfoutput>
#intValue# MOD 15 = #(intValue MOD 15)#<br />
</cfoutput>
</cfloop>