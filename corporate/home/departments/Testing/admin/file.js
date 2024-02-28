function check() {
  var ext = document.Audit.File.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.File.value.length!=0) || (document.Audit.File.value!=null)) {
	 if(ext != 'pdf') {
      if(ext != 'doc') {
	   if(ext != 'zip') {
    alert('You selected a .'+ext+' file; please select a doc, pdf, or zip file!');
    return false; 
	  }
	  }
	 }
	}	
else
return true;
document.Audit.submit();
}