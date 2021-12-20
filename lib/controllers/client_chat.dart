import 'dart:convert';
import 'dart:io';

class ClientChat {
  final Socket socket;

  Socket get getServerSocket => socket;

  ClientChat(this.socket) {
    socket.listen(dataHandler,
        onError: errorHandler, onDone: doneHandler, cancelOnError: false);
  }

  void dataHandler(data) {
    print('Server Message ${utf8.decode(data)}');
  }

  void errorHandler(error, StackTrace trace) {
    socket.close();
  }

  void doneHandler() {
    socket.close();
  }

  void write(String message) {
    socket.add(utf8.encode(message));
  }
}
