//: [Previous](@previous)
//: # ARC (automatic reference counting)
//: ### Swift использует automatic reference counting (автоматический подсчет ссылок) для отслеживания и управления памятью вашего приложения. В большинстве случаев это означает, что управление памятью "просто работает" в Swift и вам не нужно думать о самостоятельном управлении памятью. ARC автоматически освобождает память, которая использовалась экземплярами класса, когда эти экземпляры больше нам не нужны.
//: ### Однако, в некоторых случаях ARC нужно помогать для правильного управления памятью.

//: ## Работа ARC
//: ### Каждый раз, когда вы создаете экземпляр класса, ARC выделяет фрагмент памяти для хранения информации этого экземпляра. Этот фрагмент памяти содержит информацию о типе экземпляра, о его значении и любых свойствах хранения, связанных с ним.
//: ### Когда экземпляр больше не нужен, ARC освобождает память, использованную под этот экземпляр.
//: ### Для того, чтобы понимать когда экземпляр больше не нужен, ARC ведет учет количества свойств, констант, переменных, которые ссылаются на каждый экземпляр класса. ARC не освободит экземпляр, если есть хотя бы одна активная ссылка.
//: ### Каждый раз как вы присваиваете экземпляр свойству, константе или переменной создается strong reference (сильная ссылка) с этим экземпляром. Такая связь называется “сильной”, так как она крепко держится за этот экземпляр и не позволяет ему освободится до тех пор, пока остаются сильные связи.
class SomeGuy {
    let name: String

    init(name: String) {
        self.name = name
        print("\(name) инициализируется")
    }

    deinit {
        print("\(name) деинициализируется")
    }
}

var reference1: SomeGuy?
var reference2: SomeGuy?
var reference3: SomeGuy?
reference1 = SomeGuy(name: "John Appleseed")
reference2 = reference1
reference3 = reference1
//: Так это хранится в памяти

//: ![Memory 1](Memory1.png)

//: Удалим сильные ссылки на экземляр класса
reference1 = nil
reference2 = nil
reference3 = nil


//: ## Сильные циклы
class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) {
        self.name = name
        print("\(name) инициализируется")
    }

    deinit {
        print("\(name) освобождается")
    }
}

class Apartment {
    let unit: String
    var tenant: Person?

    init(unit: String) {
        self.unit = unit
        print("\(unit) инициализируется")
    }

    deinit {
        print("Апартаменты \(unit) освобождаются")
    }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

//: ![Memory 2](Memory2.png)

john!.apartment = unit4A
unit4A!.tenant = john

//: ![Memory 3](Memory3.png)

print("strong reference cycle")
john = nil
unit4A = nil
print("strong reference cycle")

//: К сожалению, соединяя таким образом, образуется цикл сильных ссылок между экземплярами. Экземпляр Person имеет сильную ссылку на экземпляр Apartment, экземпляр Apartment имеет сильную ссылку на экземпляр Person. Таким образом, когда вы разрушаете сильные ссылки, принадлежащие переменным john и unit4A, их количество все равно не падает до нуля, и экземпляры не освобождаются:

//: ![Memory 4](Memory4.png)

//: Нужно использовать weak (слабые ссылки). Слабые ссылки не удерживаются за экземпляр, на который они указывают, так что ARC не берет их во внимание, когда считает ссылки экземпляра.

//: ![Memory 5](Memory5.png)


//: john = nil


//: ![Memory 6](Memory6.png)


//: unit4A = nil

//: ![Memory 7](Memory7.png)


//: ## Unowned (бесхозные ссылки)
//: ### Как и слабые ссылки, бесхозные ссылки также не имеют сильной связи с экземпляром, на который они указывают. В отличии от слабых ссылок, бесхозные ссылки всегда имеют значение. Из-за этого бесхозные ссылки имеют неопциональный тип.
class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) деинициализируется")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Карта #\(number) деинициализируется")
    }
}

var customer: Customer?
var card: CreditCard?

customer = Customer(name: "John Appleseed")
card = CreditCard(number: 1234567890123456, customer: customer!)
customer!.card = card!
customer = nil
card = nil
//: ### Используйте бесхозные ссылки только в том случае, если вы абсолютно уверены в том, что ссылка всегда будет указывать на экземпляр. Если вы попытаетесь получить доступ к бесхозной ссылке после того, как экземпляр, на который она ссылается освобожден, то выскочит runtime ошибка.



//: ## Cписок захвата в замыканиях
//: ### Сильные ссылки так же могут образовываться, когда вы присваиваете замыкание свойству экземпляра класса, и тело замыкания захватывает экземпляр.
//: ### Этот цикл возникает из-за того, что замыкания, как и классы, являются ссылочными типами.
class HTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = { // [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name),\(text) освобождаются")
    }
}
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil

//: ![Memory 8](Memory8.png)

//: [Next](@next)
