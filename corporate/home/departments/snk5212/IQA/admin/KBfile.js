<script language="JavaScript">		
function checkfile() {
  var ext = document.Audit.File.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
    if ((document.Audit.File.value.length!=0) || (document.Audit.File.value!=null)) {
	 if(ext != 'pdf') {
      if(ext != 'doc') {
	    if(ext != 'ppt') {
		 if(ext != 'xls') {
		  if(ext != 'zip') {
    alert('You selected a .'+ext+
          ' file; please select a doc, pdf, ppt, zip, xls file instead!');
    return false; 
		  }
		 }
		}
	   }
	  }	
else
return true;
document.Audit.submit();
}
</script>