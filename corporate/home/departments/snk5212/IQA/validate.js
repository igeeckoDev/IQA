function jsLeft(strInput, intPlaces) { 
     var strOutput = ''; 
      
     for(var i=0; i<intPlaces; i++) { 
          strOutput = strOutput + strInput.charAt(i); 
     } 
      
     return strOutput; 
} 

function isblank(str) { 
var i; 
var c; 
 
     for(i=0; i < str.length; i++) { 
          c = str.charAt(i); 
          if ((c != ' ') && (c != '\n') && (c != '\t')) return false; 
     } 
     return true; 
}

function number(field){
var valid = "0123456789"
var ok = "yes";
var temp;
for (var i=0; i<field.value.length; i++) {
temp = "" + field.value.substring(i, i+1);
if (valid.indexOf(temp) == "-1") ok = "no";
}
if (ok == "no") {
alert("Invalid entry!  Only numbers are accepted!");
field.focus();
field.select();
   }
}

function numberlist(field){
var valid = "0123456789-,"
var ok = "yes";
var temp;
for (var i=0; i<field.value.length; i++) {
temp = "" + field.value.substring(i, i+1);
if (valid.indexOf(temp) == "-1") ok = "no";
}
if (ok == "no") {
alert("Invalid entry!  Only numbers, commas, and hypens are accepted!");
field.focus();
field.select();
   }
}

function checkFormValues(objForm) {
     var errors, errorfields; 
     f = objForm; 
     errors = ''; 
	 errorfields = ''; 
     for(var i = 0; i < f.length; i++) { 
          var e = f.elements[i];
          if (jsLeft(e.name, 1) == "e") {
               if (e.type == "text" || e.type == "textarea" || e.type == "select-one" || e.type == "file") { 
                    if ((e.value == null)  || (e.value == '') || isblank(e.value)) { 
                         errors += "\n     "+e.displayname+" is required."; 
                         errorfields += '-'+e.name+'-'; 
                         continue; 
                    } 
               } 	    
          } else if (jsLeft(e.name, 1) == "s") { 
               if (e.options[e.selectedIndex].value == 0) { 
                    errors += "\n     "+e.displayname+" is required."; 
                    errorfields += '-'+e.name+'-'; 
                    continue; 
               } 
          } 
	 } 
     if (errors == '') { 
	 document.all('Audit').submit();
          //add any processing here, such as form submit, etc. 
     } else { 
          var strErrorMessage = "The following input errors were detected. Please resolve these errors and resubmit the page.\n\n"; 
          strErrorMessage += errors;           
          alert(strErrorMessage); 
     } 
}
