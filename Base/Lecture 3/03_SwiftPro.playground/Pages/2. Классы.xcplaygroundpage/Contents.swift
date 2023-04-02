//: [Previous](@previous)
//: # Классы
//: ### Классы являются универсальными и гибкими конструкциями, которые станут строительными блоками для кода вашей программы.

//: Синтаксис объявления
class SomeClass {
    // здесь пишется определение класса
}
//: Синтаксис экземляра (объекта класса)
let someClassObject = SomeClass()
//: Переменные класса. Дефолтный инициализатор
class YoulaUser {
    let name: String = "Artur"
    let password: String = "secretPaSSword1234"
    var rating: Int = 100
}

let youlaUser = YoulaUser()
print(youlaUser.name, youlaUser.password, youlaUser.rating)
youlaUser.rating += 1
print(youlaUser.rating)
//: Присваивание свойствам значений во время инициализации
class VKUser {
    let name: String = "Artur"
    let password: String
    var rating: Int
    
    init(password: String, rating: Int) {
        self.password = password
        self.rating = rating
    }
}

var vkUser = VKUser(password: "secretPaSSword1234", rating: 100)
print(vkUser.name, vkUser.password, vkUser.rating)
vkUser.rating += 1
print(vkUser.rating)
//: Деинициализатор
class SomeClassForDeinitTest {
    init() {
        print("INIT")
    }
    
    deinit {
        print("DEINIT")
    }
}

var someClassForDeinitTest: SomeClassForDeinitTest? = SomeClassForDeinitTest()
print("Some work with SomeClassForDeinitTest")
someClassForDeinitTest = nil
//: Методы класса
class VKUserWithFriends {
    let name: String = "Artur"
    let password: String
    var rating: Int
    var friends: [String] = []
    
    init(password: String, rating: Int) {
        self.password = password
        self.rating = rating
        
        print("INIT")
    }
    
    func increaseRating(with value: Int) {
        rating += value
    }
    
    func addFriend(with friend: String) {
        friends.append(friend)
    }
}

let vkUserWithFriends = VKUserWithFriends(password: "secretPaSSword1234", rating: 100)
print(vkUserWithFriends.friends)
vkUserWithFriends.addFriend(with: "Kostya")
print(vkUserWithFriends.friends)
//: Пример применения класса
class Bird {
    let wings: String
    let color: String
    
    init(wings: String, color: String) {
        self.wings = wings
        self.color = color
    }
    
    func fly() {
        print("\(color) bird is flying with \(wings)")
    }
}


let raven: Bird = Bird(wings: "Black sharp wings", color: "Black")
raven.fly()

let swift: Bird = Bird(wings: "Small wings", color: "Gray")
swift.fly()

//: [Next](@next)
