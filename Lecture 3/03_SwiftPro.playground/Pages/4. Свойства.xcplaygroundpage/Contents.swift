//: [Previous](@previous)
//: # Свойства
//: ### Свойства связывают значения с определённым классом, структурой или перечислением. Свойства хранения содержат значения константы или переменной как часть экземпляра, в то время как вычисляемые свойства вычисляют значения, а не хранят их.

//: ## Свойства хранения
//: ### Константа или переменная, которая хранится как часть экземпляра определенного класса или структуры.
class YoulaUser {
    let name: String = "Artur"
    let password: String = "secretPaSSword1234"
    var rating: Int = 100
}

//: ## Ленивые свойства хранения
//: ### Cвойство, начальное значение которого не вычисляется до первого использования. Индикатор ленивого свойства - ключевое слово lazy.
class DataImporter {
    /*
     DataImporter - класс для импорта данных из внешних источников
     Считаем, что классу требуется большое количество времени для инициализации
     */
    var fileName = "data.txt"
    // класс DataImporter функционал данных будет описан тут
}
 
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // класс DataManager обеспечит необходимую функциональность тут
}
 
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// экземпляр класса DataImporter для свойства importer еще не создано
//: ## Вычисляемые свойства
//: ### Не хранят значения. Вместо этого они предоставляют геттер и опциональный сеттер для получения и установки других свойств косвенно.
class Cub {
    let side: Double
    
    init(side: Double) {
        self.side = side
    }
    
    var volume: Double { // можно только прочесть
        return side * side * side
    }
}

let cub = Cub(side: 10)
print(cub.volume)
//: Геттеры и сеттеры.
class Square {
    var side: Double
    
    init(side: Double) {
        self.side = side
    }
    
    var perimeter: Double { // можно и прочесть и изменить
        get {
            return side * 4
        }
        set {
            side = newValue / 4
        }
    }
}

let square = Square(side: 10)
print(square.side)
print(square.perimeter)
square.perimeter = 16
print(square.side)
print(square.perimeter)
//: ## Наблюдатели свойства
//: ### Наблюдатели свойства могут наблюдать и отвечать на изменения значения свойства. Наблюдатели свойств вызываются каждый раз, как устанавливается значение свойству.
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("Вот-вот значение будет равно \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Добавлено \(totalSteps - oldValue) шагов")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896
//: ## Свойства типа
//: ### Свойства экземпляров - свойства, которые принадлежат экземпляру конкретного типа. Свойства типов - принадлежат самому типу, а не экземплярам этого типа. Будет всего одна копия этих свойств вне зависимости от количества экземпляров.
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
}
print(SomeClass.storedTypeProperty, SomeClass.computedTypeProperty)


//: [Next](@next)
