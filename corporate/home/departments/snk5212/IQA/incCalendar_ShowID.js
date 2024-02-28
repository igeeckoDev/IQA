/* this function shows the pop-up when
 user moves the mouse over the link */
function Show(id)
{
    /* get the mouse left position */
    x = event.clientX + document.body.scrollLeft;
    /* get the mouse top position  */
    y = event.clientY + document.body.scrollTop + 35;
    /* display the pop-up */
    document.getElementById(id).style.display="block";
    /* set the pop-up's left */
    document.getElementById(id).style.left = x;
    /* set the pop-up's top */
    document.getElementById(id).style.top = y;
}
/* this function hides the pop-up when
 user moves the mouse out of the link */
function Hide(id)
{
    /* hide the pop-up */
    document.getElementById(id).style.display="none";
}