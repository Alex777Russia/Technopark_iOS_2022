//: [Previous](@previous)
/*: # Поговорим про ООП
 
 ## Что это
 
 WIKI: Методология программирования, основанная на представлении программы в виде совокупности объектов, каждый из которых является экземпляром определённого класса, а классы образуют иерархию наследования
 
 ## Основные понятия
 
 ### Наследование
 
 Для быстрой и безопасной организации родственных понятий: чтобы было достаточно на каждом иерархическом шаге учитывать только изменения, не дублируя всё остальное, учтённое на предыдущих шагах
 
 ### Инкапсуляция
 
 Свойство системы, позволяющее объединить данные и методы, работающие с ними, в классе.
 
 ### Полиморфизм
 
 Свойство системы, позволяющее использовать объекты с одинаковым интерфейсом без информации о типе и внутренней структуре объекта
*/

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


//let raven: Bird = Bird(wings: "Black sharp wings", color: "Black")
//raven.fly()

let swift: Bird = Bird(wings: "Small wings", color: "Gray")
swift.fly()

class Raven: Bird {
    private let skill: String
    
    init(skill: String) {
        self.skill = skill
        super.init(wings: "Black sharp wings", color: "Black")
    }
    
    func doSkill() {
        print(self.getSkillString())
    }
    
    private func getSkillString() -> String {
        return "Raven can \(skill)"
    }
}

let raven: Raven = Raven(skill: "Jump over human arm")
raven.fly()
//raven.skill = "Some trash data"
raven.doSkill()


func sayBirdToFly(bird: Bird) {
    bird.fly()
}

sayBirdToFly(bird: swift)
sayBirdToFly(bird: raven)

let raven2 = raven
let raven3 = Raven(skill: "Jump over human arm")

print(swift === raven)
print(raven === raven2)
print(raven === raven3)


//: [Next](@next)
