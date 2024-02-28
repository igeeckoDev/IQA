<!--- get and read the CSV-TXT file ---> 
<cffile action="read" file="#GCARMetricsPath#import\GCAR_Metrics_Program_Regions.csv" variable="csvfile">
<!--- loop through the CSV-TXT file on line breaks and insert into database ---> 
<cfloop index="index" list="#csvfile#" delimiters="#chr(10)##chr(13)#"> 
    <cfquery name="importCSV" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#"> 
         INSERT INTO GCAR_Metrics_Program_Regions(ID, CARProgramAffected, Region) 
         VALUES 
                  ('#listgetAt('#index#',1, ',')#', 
                   '#listgetAt('#index#',2, ',')#', 
                   '#listgetAt('#index#',3, ',')#'
                  ) 
   </cfquery> 
</cfloop>

<!--- use a simple database query to check the results of the import - dumping query to screen ---> 
<cfquery name="rscsvdemo" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#"> 
         SELECT * FROM GCAR_Metrics_Program_Regions 
</cfquery> 

<cfdump var="#rscsvdemo#">