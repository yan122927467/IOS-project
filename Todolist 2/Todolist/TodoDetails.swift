//
//  TodoDetails.swift
//  Todolist
//
//  Created by 闫子龙 on 2020/1/8.
//  Copyright © 2020 闫子龙. All rights reserved.
//

import SwiftUI

struct TodoDetails: View {
    @ObservedObject var main : Main
    var body: some View {
        VStack{
            Spacer().frame(height:20)
            HStack{
                Button(action:{
                    UIApplication.shared.keyWindow?.endEditing(true)
                    self.main.detailsShowing = false
                }){
                    Text("取消").padding()
                }
                Spacer()
                Button(action:{
                    UIApplication.shared.keyWindow?.endEditing(true)
                    if editingMode{
                        self.main.todos[editingIndex].title = self.main.detailsTitle
                        self.main.todos[editingIndex].dueDate = self.main.detialDueDate
                    }else{
                        let newTodo = Todo(title: self.main.detailsTitle, dueDate: self.main.detialDueDate)
                        self.main.todos.append(newTodo)//添加新建的
                    }
                    self.main.sort()
                    do{
                        let archivedData = try NSKeyedArchiver.archivedData(withRootObject: self.main.todos, requiringSecureCoding: false)//保存方法
                        UserDefaults.standard.set(archivedData, forKey: "todos")
                    }catch{
                        print("error")
                    }
                    self.main.detailsShowing = false
                }){
                    Text(editingMode ? "完成":"添加").padding()
                }.disabled(main.detailsTitle == "")
            }
            SATextField(tag:0,text :editingTodo.title,placeholder: "你要干啥？",changeHandler: {
                (newString) in
                self.main.detailsTitle = newString
            }){
            }
        .padding(8)
            .foregroundColor(.white)
            DatePicker(selection: $main.detialDueDate,displayedComponents: .date, label:{() ->EmptyView in })
            .padding()
            Spacer()
        }
    .padding()
    .background(Color("todoDetails-bg"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct TodoDetails_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetails(main : Main())
    }
}
