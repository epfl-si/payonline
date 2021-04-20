<!--
var crtlayer = 1;
var cal = new CalendarPopup();

function ShowLayer(layerid) {
    var crtlayername= "Layer"+crtlayer;
    var layername   = "Layer"+layerid;
    window.document.getElementById(crtlayername).style.visibility='hidden';
    window.document.getElementById(layername).style.visibility='visible';
    crtlayer = layerid;
}

function showHelp (helpURL) 
{
  window.open(helpURL,'helpwindow','width=330,height=800,menubar=no,scrollbars=yes');
}

function confirmDelete(lang, delUrl) {
 var txt;
 if (lang == 'fr') {
   txt = 'Souhaitez-vous réellement supprimer cette instance et toutes les données associées?';
 } else {
  txt = 'Are sure you want to delete this instance and all it\'s associated data?';
 }

 if (confirm(txt)) {
   document.form1.del.value=1;
   document.location = delUrl;
 }
}
//-->
