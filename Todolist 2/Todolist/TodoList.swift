//
//  TodoList.swift
//  Todolist
//
//  Created by 闫子龙 on 2020/1/7.
//  Copyright © 2020 闫子龙. All rights reserved.
//

import SwiftUI
//待办事项
var exampleTodos: [Todo] = [
    Todo(title: "擦地", dueDate: Date()),
    Todo(title: "洗锅", dueDate: Date().addingTimeInterval(2000000)),
    Todo(title: "看美剧", dueDate: Date()),
    Todo(title: "做app", dueDate: Date()),
    Todo(title: "作业", dueDate: Date())
]
struct TodoList: View {
    @ObservedObject var main : Main
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(main.todos){todo in
                    VStack{
                        if todo.i == 0 || formatter.string(from: self.main.todos[todo.i].dueDate) != formatter.string(from: self.main.todos[todo.i - 1].dueDate){
                            HStack{
                                Spacer().frame(width:30)
                                Text(date2Word(date:self.main.todos[todo.i].dueDate))
                                Spacer()
                            }
                        }
                        HStack{
                            Spacer().frame(width:20)
                            TodoItem(main: self.main,todoIndex:  .constant(todo.i))
                                .cornerRadius(10.0)
                                .clipped()//认为以上是一个整体
                                .shadow(color: Color("todoItemShadow"), radius: 5)
                            Spacer().frame(width:25)
                        }
                        Spacer().frame(height:20)
                    }
                }
                Spacer().frame(height:150)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("待办事项")).foregroundColor(Color("theme"))
            .onAppear{
                if let data = UserDefaults.standard.object(forKey: "todos") as? Data{
                    let todolist = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Todo] ?? []
                    for todo in todolist{
                        if !todo.checked {
                            self.main.todos.append(todo)
                        }
                    }
                    self.main.sort()
                }else{
                    self.main.todos = exampleTodos
                    self.main.sort()
                }
            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(main : Main())
    }
}
