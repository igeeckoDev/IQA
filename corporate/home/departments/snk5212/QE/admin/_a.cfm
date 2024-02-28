<CFQUERY BLOCKFACTOR="100" DataSource="Corporate" NAME="IQAOffices"> 
SELECT DBMS_LOB.SUBSTR(Other2, 300) CLOB_Data FROM IQAtblOffices
WHERE Exist = 'Yes'
ORDER BY OfficeName
</CFQUERY>

<cfdump var="#IQAOffices#">