import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_example/model/meal.dart';
import 'package:riverpod_example/model/todo.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// simple provider
final helloProvider = Provider((ref) => 'Hello World Provider');



// state provider
final stateProvider = StateProvider<int>((ref) {
  int count = 0;
  return count;

  // return 0
});



// future provider
final futureProvider = FutureProvider<MealModel>((ref) async {
  final dio = Dio();
  final response = await dio.get('https://www.themealdb.com/api/json/v1/1/random.php');
  print(response);
  return MealModel.fromJson(response.data['meals'][0]);
});



// stream provider
// create a basic provider / websocket
final webSocketProvider = Provider.family<WebSocketChannel, String>((ref, coinName){
  final webSocket = IOWebSocketChannel.connect('wss://ws.coincap.io/prices?assets=$coinName');
  return webSocket;
});

// create stream provider
// ref for using other provider inside a provider
final bitCoinProvider = StreamProvider.family<Map<String, double>, String>((ref, coinName) {
  final webSocket = ref.watch(webSocketProvider(coinName));
  return webSocket.stream.map((event) {
    final Map<String, dynamic> data = json.decode(event);
    return data.map((key, value) => MapEntry(key, double.parse(value.toString())));
  });
});


// notify provider
// create notifier
class TodoNotifier extends Notifier<List<TodoModel>>{

  // initial state
  @override
  List<TodoModel> build() {
    return [];
  }

  // add function
  void addTodo(TodoModel todoModel){
    // ...state = current state / previous state
    // spread operator
    state = [...state, todoModel];
  }

  // remove function
  void removeTodo(int index){
    state = state.where((element) => state.indexOf(element) != index).toList();
  }

  // toggle function
  void toggleTodo(int index){
    state = [
      for(int i=0; i<state.length; i++)
        if(i == index)
          state[i].copyWith(isCompleted: !state[i].isCompleted)
        else
          state[i]
    ];
  }
}

// create notifier provider
final todoNotifierProvider = NotifierProvider<TodoNotifier, List<TodoModel>>(() =>TodoNotifier());