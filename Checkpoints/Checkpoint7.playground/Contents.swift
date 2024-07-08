/*
 Checkpoint 7
 Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.

 But there’s more:

 The Animal class should have a legs integer property that tracks how many legs the animal has.
 The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
 The Cat class should have a matching speak() method, again with each subclass printing something different.
 The Cat class should have an isTame Boolean property, provided using an initializer.
 */


import Cocoa

class Animal{
    let legs: Int
    init(legs: Int){
        self.legs = legs
    }
}

class Dog: Animal{
    func speak(){
        print("Woof!")
    }
}

class Cat: Animal{
    var isTame: Bool
    func speak(){
        print("Meow!")
    }
    init(legs: Int, tame: Bool){
        self.isTame = tame
        super.init(legs: legs)
        
    }
}

class Corgi: Dog{
    override func speak(){
        print("Woof! I am a Corgi!")
    }
}
class Poodle: Dog{
    override func speak(){
        print("Woof! I am a Poodle!")
    }
}

class Persian: Cat{
    override func speak(){
        print("Meow Meow! I am a Persian Cat!")
    }
}
class Lion: Cat{
    override func speak(){
        print("I roar because I am a Lion!")
    }
}

//Create instances of Classes

let corgi1 = Corgi(legs: 4)
corgi1.speak()
let poodle1 = Poodle(legs: 4)
poodle1.speak()

let lion1 = Lion(legs: 4, tame: false)
lion1.speak()
let persian1 = Persian(legs: 4, tame: true)
persian1.speak()

