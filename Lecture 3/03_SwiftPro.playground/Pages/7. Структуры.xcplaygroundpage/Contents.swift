//: [Previous](@previous)
/*:
 # Структуры
 ### Кроме классов в swift есть структуры. Они почти как классы, но не совсем классы.
*/
//: Все структуры имеют автоматически генерированный "поэлементный инициализатор"
struct User {
    let name: String
    var password: String
    var rating = 100
}

var user = User(name: "Artur", password: "secretPassword1234")
print(user)
user.rating += 1 // если user будет let, то здесь будет ошибка (в отличии от классов)
print(user.rating)
//: Чтобы поменять поле структуры внутри её метода, метод нужно отметить специальным модификатором `mutating`
struct B {
    var b: Int

    mutating func setB(_ value: Int) {
        b = value
    }
}

//let b = B(b: 10) // change 'let' to 'var' to make it mutable
var b = B(b: 10)
print("b: \(b.b)")
b.setB(100)
print("b: \(b.b)")
//: Структуры нельзя наследовать
//struct C: B {} // error: inheritance from non-protocol type 'B'
//: Но они могут реализовывать протоколы
protocol AProtoсol {
    func a()
}

struct SomeStruct: AProtoсol {
    func a() {
       print("!")
    }
}
//: По тому, что вы видели выше, вы уже поняли, что структуры ведут себя немного иначе, чем классы. Давайте ещё раз посмотрим на то, в чём разница.
protocol Valued {
    var value: Int { get set }
}

protocol ValueHolder {
    var value: Valued { get }
}

struct ValuedStruct: Valued {
    var value: Int = 10
}

class ValuedClass: Valued {
    var value: Int = 10
}

class Holder: ValueHolder {
    var value: Valued
    
    init(with value: Valued) {
        self.value = value
    }
}

var vs = ValuedStruct()
let vsh1 = Holder(with: vs)
print("vs: \(vs.value) vsh1: \(vsh1.value.value)")
vs.value = 20
print("vs: \(vs.value) vsh1: \(vsh1.value.value)")

var vc = ValuedClass()
let vch1 = Holder(with: vc)
print("vc: \(vc.value) vch1: \(vch1.value.value)")
vc.value = 20
print("vc: \(vc.value) vch1: \(vch1.value.value)")

//: Классы передаются _по ссылке_, а структуры – _по значению_

//: [Next](@next)
