//: [Previous](@previous)
//: # Методы
//: ### Методы - это функции, которые связаны с определенным типом. Классы, структуры и перечисления - все они могут определять методы.

//: Методы экземпляра. Являются функциями, которые принадлежат экземплярам конкретного класса, структуры или перечисления. перечисления.
class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment()
print(counter.count)
counter.increment(by: 5)
print(counter.count)
counter.reset()
print(counter.count)
//: Свойство self. Используется для ссылки на текущий экземпляр, внутри методов этого экземпляра.
class CounterWithSelf {
    var count = 0
    func increment() {
        self.count += 1 // здесь self использовать не обязательно, лучше его опустить
    }
}

class Point {
    var x = 0.0
    var y = 0.0
    
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x // здесь self использовать необходимо, тк надо конкретно указать какой x мы имеем в виду
    }
}
//: Методы типа. Аналогично свойствам типа.
class SomeClass {
    static var someVariable = 10
    
    static func someTypeMethod() {
        someVariable = 20
    }
    
    func someObjectMethod() {
        Self.someVariable = 30 // можно использовать Self или SomeClass
    }
}

print(SomeClass.someVariable)
SomeClass.someTypeMethod()
print(SomeClass.someVariable)

let someClass = SomeClass()
someClass.someObjectMethod()
print(SomeClass.someVariable)


//: [Next](@next)
