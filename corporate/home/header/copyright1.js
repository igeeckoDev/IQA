<SCRIPT LANGUAGE="JavaScript">

RightNow = new Date();
var TheYear = RightNow.getYear()

if (TheYear >= 100 && TheYear <= 1999)
{TheYear=TheYear + 1900}
else
{TheYear=TheYear}
document.write("The year is " + TheYear + ". ")

</Script> 

