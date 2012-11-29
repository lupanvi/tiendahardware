$(document).ready(function () {

  

    $('input[datatype=numeric]').keypress(function (event) {
        if (event.keyCode < 47 || event.keyCode > 58) { event.preventDefault(); }
    });

});






