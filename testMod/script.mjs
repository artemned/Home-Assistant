
//function sendMessage() {
//   var result =
//}



WorkerScript.onMessage = function(message) {
    //Calculate result (may take a while, using a naive algorithm)


    var containRegisters = message.object

    //Send result back to main thread
    WorkerScript.sendMessage( {resultat:containRegisters});
}

