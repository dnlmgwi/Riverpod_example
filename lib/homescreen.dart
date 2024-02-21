import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/model/meal.dart';
import 'package:riverpod_example/model/todo.dart';
import 'provider/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // simple provider
    final providerValue = ref.watch(helloProvider);

    // state provider
    final stateProviderValue = ref.watch(stateProvider);

    // future provider
    AsyncValue<MealModel> futureProviderValue = ref.watch(futureProvider);

    // stream provider
    // bitcoin,ethereum,monero,litecoin
    final streamProviderValue = ref.watch(bitCoinProvider('bitcoin'));

    // notifier provider
    List<TodoModel> notifierProviderValue = ref.watch(todoNotifierProvider);

    return  Scaffold(
      appBar: AppBar(title: const Text('Riverpod'),),
      body: Column(
        children: [
          Text('Basic Provider : $providerValue'),
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                ref.read(stateProvider.notifier).state++;
              }, child: const Icon(Icons.add)),
              Text('State Provider Value : $stateProviderValue'),
              ElevatedButton(onPressed: (){
                ref.read(stateProvider.notifier).state--;
              }, child: const Icon(Icons.remove)),
            ],
          ),
          ElevatedButton(onPressed: (){
            ref.read(stateProvider.notifier).state = 0;
          }, child: const Icon(Icons.refresh)),
          const Divider(
            thickness: 2,
          ),
         const Text('Future Provider with pull to refresh'),
          SizedBox(
            height: 100,
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(futureProvider.future),
              child: futureProviderValue.when(data: (meal){
                return ListView(
                  children: [
                    Text(meal.idMeal),
                    Text(meal.strArea),
                    Text(meal.strCategory),
                    Text(meal.strMeal),
                  ],
                );
              }, error: (error, stackTrace){
                return Center(
                  child: Text(error.toString()),
                );
              }, loading: () => const CircularProgressIndicator()),
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          streamProviderValue.when(data: (data){
            final currency = data.keys.first;
            final price = data[currency];
            return Column(
              children: [
               const Text('Stream Provider'),
                Text(currency),
                Text('USD ${price.toString()}' ),
              ],
            );
          }, error: (error, stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          }, loading: () => const CircularProgressIndicator(),),
          const Divider(
            thickness: 2,
          ),
          const Text('Notify Provider'),
          ElevatedButton(onPressed: (){
            final todoModel =  TodoModel(title: getRandomString(3), isCompleted: false);
            ref.read(todoNotifierProvider.notifier).addTodo(todoModel);
          }, child: const Icon(Icons.add)),
          SizedBox(
            height: 150,
            child: ListView.builder(
                itemCount: notifierProviderValue.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notifierProviderValue[index].title),
                    leading: Checkbox(value: notifierProviderValue[index].isCompleted, onChanged: (value){
                      ref.read(todoNotifierProvider.notifier).toggleTodo(index);
                    }),
                    trailing: Visibility(
                        visible: notifierProviderValue[index].isCompleted,
                        child: IconButton(onPressed: (){
                          ref.read(todoNotifierProvider.notifier).removeTodo(index);
                        }, icon: const Icon(Icons.delete))),
                  );
                }
            ),
          )
        ],
      ),

    );
  }


}