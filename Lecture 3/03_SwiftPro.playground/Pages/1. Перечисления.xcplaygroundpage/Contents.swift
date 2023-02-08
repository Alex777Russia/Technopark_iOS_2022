//: [Previous](@previous)
//: # Перечисления
//: ### Перечисление (enumeration) определяет общий тип для группы связанных значений.
//: Синтаксис перечислений
enum CompassPoint {
    case north
    case south
    case east
    case west
}

var directionToHead = CompassPoint.west
directionToHead = .east
//: Использование перечислений с инструкцией switch
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
//: Ассоциативные значения
enum ActivityWithoutAssociatedValues {
    case bored
    case running
    case talking
    case singing
}

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let currentActivity = Activity.talking(topic: "football")

switch currentActivity {
case .bored:
    print("Stand up and DO SOMETHING")
case .running(let destination):
    print("I ran \(destination)")
case .talking(let topic):
    print("I'am talking about \(topic)")
case .singing:
    print("DU HUST!!!")
}
//: Дефолтные значения
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

let controlCharacter = ASCIIControlCharacter.lineFeed
print("BEGIN \(controlCharacter.rawValue) END")

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPointString: String {
    case north, south, east, west
}

let earthsOrder = Planet.earth.rawValue
let sunsetDirection = CompassPointString.west.rawValue
let possiblePlanet = Planet(rawValue: 7)

//: Итерация по кейсам перечисления
enum MenuItem: CaseIterable {
   case coffee, tea, juice
}

let numberOfChoices = MenuItem.allCases.count
for menuItem in MenuItem.allCases {
    print(menuItem)
}

//: [Next](@next)
