import 'dart:io';

class ClientChat {
  final Socket socket;

  ClientChat(this.socket) {
    socket.listen(dataHandler,
        onError: errorHandler, onDone: doneHandler, cancelOnError: false);
  }

  void dataHandler(data) {
    print(String.fromCharCodes(data).trim());
  }

  void errorHandler(error, StackTrace trace) {
    socket.close();
  }

  void doneHandler() {
    socket.close();
    // exit(0);
  }

  void write(String message) {
    socket.write(message);
  }
}
