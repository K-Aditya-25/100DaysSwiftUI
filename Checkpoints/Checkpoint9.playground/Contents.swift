/*
 Checkpoint 9:
 Your challenge is this: write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100.

 If that sounds easy, it’s because I haven’t explained the catch yet: I want you to write your function in a single line of code. No, that doesn’t mean you should just write lots of code then remove all the line breaks – you should be able to write this whole thing in one line of code.
 */

import Cocoa

//Assuming that the function body has to be of one line
func getRandom(from numbers: [Int]?) -> Int{
    numbers?.randomElement() ?? Int.random(in: 1...100)
}


//Another implementation (Ignoring the one line constraint
/*
func getRandom(from numbers: [Int]?) -> Int{
    guard let num = numbers?.randomElement() else{
        return Int.random(in: 1...100)
    }
    return num
}
*/

let num1 = getRandom(from: nil)
num1

let num2 =  getRandom(from: [1,2,3,4,5,6,7,8,9,10])
num2
