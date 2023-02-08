//: [Previous](@previous)
//: # Уровни доступа
//: ### Swift предлагает пять различных уровней доступа для объектов вашего кода. Эти уровни доступа относительны исходному файлу, в котором определен объект, и так же они относительны модулю*, которому принадлежит исходный файл.
//: ### *Модуль представляет из себя единый блок распределения кода - фреймворк или приложение, которое построено и поставляется в качестве единого блока и которое может быть импортировано другим модулем с ключевым словом import.
//: ### Существует 5 уровней доступа в Swift: open, public, internal, fileprivate, private

//: Open. Самый высокий уровень доступа (наименее строгий)
// First.framework – A.swift

open class A {}


// First.framework – B.swift

class B: A {} // ok


// Second.framework – C.swift

import First

internal class C: A {} // ok
// First.framework – A.swift
//: Public. То же самое что и open, но с некоторыми отличиями. Наследование и переопредение только в модуле, где они определены.
// First.framework – B.swift

public class B {} // ok

// Second.framework – D.swift

import First

internal class D: B {} // error: B cannot be subclassed
//: Internal. Позволяет использовать объекты внутри модуля. Вне модуля доступа нет.
// First.framework – A.swift

internal class A {}

// First.framework – B.swift

A() // ok


// Second.framework – C.swift

import First

A() // error: A is unavailable
//: Fileprivate. Позволяет использовать объект в пределах его исходного файла.
// First.framework – A.swift

internal struct A {
    fileprivate static let x: Int
}

A.x // ok


// First.framework – B.swift

A.x // error: x is not available
//: Private. Позволяет использовать сущность только в пределах области ее реализации.
// First.framework – A.swift

class A {
    private let x: Int = 10
}

a = A()
a.x // error: x is unavailable
//: [Next](@next)
