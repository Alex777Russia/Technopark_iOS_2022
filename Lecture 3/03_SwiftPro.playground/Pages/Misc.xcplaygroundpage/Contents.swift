//: [Previous](@previous)


//: ## Приведение типов

//let stringVariable42 = "42"
//print(stringVariable42 is String)
//print(Int(stringVariable42))
////print(stringVariable42 as Int)
//
//let intVariable42 = 42
//print(intVariable42 is String)
//print(intVariable42 as Double)
//print(String(intVariable42))
////print(intVariable42 as String)
////print(intVariable42 as Int)



//try catch

// Custom errors


//: [Next](@next)







//: Почему так происходит? Давайте разбираться
struct A {
    var a: Int = 10
}

//let a = A()
var a = A()
print("\(a.a)")
a.a = 20
print("\(a.a)")


class A1 {
    var a: Int = 30
}

let a1 = A1()
print(a1.a)
a1.a = 40
print(a1.a)


func testFunc(a: inout A) {
    print(a.a)
    a.a = 50
}

testFunc(a: &a)
print(a.a)


func testFunc(a: A1) {
    print(a.a)
    a.a = 60
}

testFunc(a: a1)
print(a1.a)
//: кроме поля, меняется и само значение a, то есть *делается новый экземпляр структуры*
