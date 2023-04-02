//: [Previous](@previous)
//: # Протоколы и расширения

//: ## Расширения
//: ### Расширения добавляют новую функциональность существующему типу класса, структуры или перечисления.
class SomeClass {
    let a: Int = 10
    
    func doSomething() {
        print(a)
    }
}

extension SomeClass {
//    let b: Int = 20 // error: extensions must not contain stored properties
//    var c: Int = 30
    
    var d: Int {
        40
    }
    
    func doSomethingElse() {
        print(d, a)
    }
}

let someClass = SomeClass()
someClass.doSomething()
someClass.doSomethingElse()
print(someClass.d)
//: Расщирения могут быть к стандартным типам
extension Int {
    mutating func sq() {
        self = self * self
    }
}

var someInteger: Int = 10
someInteger.sq()
print(someInteger)
//: ## Протоколы
//: ### Протокол определяет образец методов, свойств. Протокол не предоставляет реализацию, он только описывает как реализация должна выглядеть. Реализация может быть прописана в классе, структуре или перечислении.
//: Синтаксис протокола
protocol SomeUsefullProtocol {
    // определение протокола…
}

class SomeUsefullClass: SomeUsefullProtocol {
    // определение класса…
}
//: Требование свойств и методов
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    
    func someMethod()
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

class SomeAnotherClass: SomeProtocol, AnotherProtocol {
    var mustBeSettable: Int = 10
    let doesNotNeedToBeSettable: Int = 100
    static var someTypeProperty: Int = 1000
    
    func someMethod() {
        print(mustBeSettable, doesNotNeedToBeSettable, Self.someTypeProperty)
    }
}
//: Требование инициализаторов
protocol SomeProtocolWithInit {
    init(someParameter: Int)
}

class SomeClassWithRequiredInit: SomeProtocolWithInit {
    required init(someParameter: Int) {
        // реализация инициализатора…
    }
}
//: Добавление реализации протокола через расширение
protocol SomeProtocolForExtension {
    var someVariable: Int { get }
    
    func someMethod()
}

class SomeClassWithExtension {
    // Код не связанный с протоколом
}

extension SomeClassWithExtension: SomeProtocolForExtension {
    var someVariable: Int {
        10
    }
    
    func someMethod() {
        print(someVariable)
    }
}

let someClassWithExtension = SomeClassWithExtension()
someClassWithExtension.someMethod()
//: Наследование протокола
protocol SomeProtocolForInheriting: SomeProtocolForExtension {
}

class SomeClassForInheriting: SomeProtocolForInheriting {
    var someVariable: Int {
        10
    }
    
    func someMethod() {
        print(someVariable)
    }
}
let someClassForInheriting = SomeClassForInheriting()
someClassForInheriting.someMethod()
//: Дефолтная реализация
protocol SomeProtocolWithDefaultRealization {
    func doSomething()
}

extension SomeProtocolWithDefaultRealization {
    func doSomething() {
        print("!")
    }
}

class SomeClassWithDefaultRealization: SomeProtocolWithDefaultRealization {
    // используется дефолтная реализация
}

let someClassWithDefaultRealization = SomeClassWithDefaultRealization()
someClassWithDefaultRealization.doSomething()
//: ## Примеры
//: Сначала рассмотрим пример без использования протоколов и расширений
class ShapeTest {
    func area() -> Double {
        return 0.0
    }
}

class CircleTest: ShapeTest {
    private let radius: Double
    
    init(with radius: Double = 1.0) {
        self.radius = radius
    }
    
    override func area() -> Double { // необходимо ключевое слово override
        return Double.pi * radius * radius
    }
}

class RectTest: ShapeTest {
    private let width: Double
    private let height: Double
    
    init(width: Double = 1.0, height: Double = 1.0) {
        self.height = height
        self.width = width
    }
    
    override func area() -> Double {
        return width * height
    }
}

class SquareTest: RectTest {
    init(side: Double = 1.0) {
        super.init(width: side, height: side)
    }
}

let circleTest: ShapeTest = CircleTest(with: 1.0)
print(circleTest.area())

let rectTest: ShapeTest = RectTest(width: 1.0, height: 3.0)
print(rectTest.area())

let squareTest: ShapeTest = SquareTest(side: 2.0)
print(squareTest.area())

//ссылаются ли две константы или переменные на один и тот же экземпляр класса
print(squareTest === rectTest)
/*:
 С наследованием есть одна проблема: монжо иметь только одного родителя. А как быть в случае, если мы хотим описать несколько типов поведения и комбинировать их в своих классах?
 
 Здесь на помощь приходят _протоколы_, которые специфицируют _контракт_ класса. При этом класс может реализовывать несколько протоколов одновременно.
 
 Давайте переделаем предыдущий пример с фигурами с помощью протокола и посмотрим, как его можно расширить.
*/
protocol AreaCalculatable {
    func area() -> Double
}

class Circle: AreaCalculatable {
    private let radius: Double
    
    init(with radius: Double = 1.0) {
        self.radius = radius
    }
    
    func area() -> Double {
        return Double.pi * radius * radius
    }
}

class Rect: AreaCalculatable {
    private let width: Double
    private let height: Double
    
    init(width: Double = 1.0, height: Double = 1.0) {
        self.height = height
        self.width = width
    }
    
    func area() -> Double {
        return width * height
    }
}

class Square: Rect {
    init(side: Double = 1.0) {
        super.init(width: side, height: side)
    }
}

let circle = Circle(with: 1.0)
print(circle.area())

let rect = Rect(width: 1.0, height: 3.0)
print(rect.area())

let square = Square(side: 2.0)
print(square.area())
/*:
 Пока особо ничего не поменяось, кроме того, что убралось `override` и пропало пустое тело метода `area` в базовом классе.
 
 Давайте тепеь представим, что мы хотим считать не только площадь, но и объём цилиндра с таким основанием и какой-то высотой.
*/
protocol Cylinder {
    func volume(height: Double) -> Double
}

extension Circle: Cylinder {
    func volume(height: Double) -> Double {
        return area() * height
    }
}

extension Rect: Cylinder {
    func volume(height: Double)  -> Double {
        return area() * height
    }
}

print(circle.volume(height: 3.0))
print(rect.volume(height: 3.0))
print(square.volume(height: 3.0))
/*:
 Вроде всё ок, но можно сделать ещё лучше. Мы можем задавать релизацию метода протокола по-умолчанию. Причем только для определённых типов
 */
protocol Cylinder2 {
    func volume2(height: Double) -> Double
}

extension Cylinder2 where Self: AreaCalculatable {
    func volume2(height: Double) -> Double {
        return height*area()
    }
}

extension Circle: Cylinder2 {
    
}

extension Rect: Cylinder2 {
    
}

print(circle.volume2(height: 3.0))
print(rect.volume2(height: 3.0))
print(square.volume2(height: 3.0))
//: Также протоколы можно использовать как типы
func printArea(shape: AreaCalculatable) {
    print("Some usefull description for area: \(shape.area())")
}

printArea(shape: circle)
printArea(shape: rect)
printArea(shape: square)

//: ## Задачи

//: #1
//protocol A {
//    func doSomething()
//}
//
//protocol B {
//    func doSomething()
//}
//
//class C: A, B {
//    func doSomething() {
//        print("doSomething")
//    }
//}
//
//let c = C()
//c.doSomething()

//: #2
//protocol A {
//    func doSomething()
//}
//
//protocol B {
//    func doSomething()
//}
//
//class C {}
//
//extension C: A {
//    func doSomething() {
//        print("doSomething")
//    }
//}
//
//extension C: B {
//    func doSomething() {
//        print("doSomething")
//    }
//}
//
//let c = C()
//c.doSomething()

//: #3
//protocol A {
//    func doSomething()
//}
//
//extension A {
//    func doSomething() {
//        print("doSomething A")
//    }
//}
//
//protocol B {
//    func doSomething()
//}
//
//extension B {
//    func doSomething() {
//        print("doSomething B")
//    }
//}
//
//class C: A, B {}
//
//let c = C()
//c.doSomething()

//: [Next](@next)
