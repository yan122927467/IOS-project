//
//  Home.swift
//  Todolist
//
//  Created by 闫子龙 on 2020/1/6.
//  Copyright © 2020 闫子龙. All rights reserved.
//

import SwiftUI


var editingMode:Bool = false//用户正想要编辑已存在的代办事项，false就是添加新的待办事项
var editingTodo:Todo = emptyTodo//用户正在编辑的待办事项是什么。。存备份
var editingIndex: Int = 0//编辑的第几个待办事项
var detailsShouldUptateTitle : Bool = false//是否更新


class Main: ObservableObject {
    @Published var todos:[Todo] = []
    @Published var detailsShowing: Bool = false
    @Published var detailsTitle:String = ""
    @Published var detialDueDate:Date = Date()
    //待办事项排序
    func sort(){
        self.todos.sort(by: { $0.dueDate.timeIntervalSince1970<$1.dueDate.timeIntervalSince1970})//排序大小
        for i in 0 ..< todos.count{
            self.todos[i].i = i
        }
    }

}

struct Home: View {
    //加入待办事项列标
    @ObservedObject var main : Main
    var body: some View {
        ZStack{
            TodoList(main:main)
                .blur(radius: main.detailsShowing ? 10 : 0)//毛玻璃特效
        Button(action:{
            editingMode = false
            editingTodo = emptyTodo
            detailsShouldUptateTitle = true
            self.main.detailsTitle = ""
            self.main.detialDueDate = Date()
            self.main.detailsShowing = true
        }) {
        btnAdd()
        }.offset(x:UIScreen.main.bounds.width/2-60,y:UIScreen.main.bounds.height/2-80)
            .blur(radius: main.detailsShowing ? 10 : 0)
            TodoDetails(main: main)
                .offset(x:0,y:main.detailsShowing ? 0 : UIScreen.main.bounds.height)
    }
  }
}

struct btnAdd:View {
    var size : CGFloat = 65.0
    var body: some View{
        ZStack{
            Group{
                Circle()
                .fill(Color("btnAdd-bg"))
            }.frame(width :self.size,height: self.size).shadow(color : Color("btnAdd-shadow"),radius: 10)
            Group{
                Image(systemName:"plus.circle.fill")
                .resizable()
                    .frame(width:self.size,height: self.size)
                .foregroundColor(Color("theme"))
            }
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(main:Main())
    }
}
