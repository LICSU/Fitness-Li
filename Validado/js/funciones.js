




//----------------------------------- Modal -----------------
function MostrarModalExito(message) {

    $('#lblMsjModalExito').html(message);
    $('#modalExito').modal('show');
    return true;
}

function MostrarModalInformacion(message) {

    $('#lblMsjModalInformacion').html(message);
    $('#modalInformacion').modal('show');
    return true;
}


function MostrarModalError(message) {
    $('#lblMsjModalError').html(message);
    $('#modalError').modal('show');
    return true;
}