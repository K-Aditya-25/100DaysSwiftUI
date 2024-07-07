/*
Checkpoint 6: Based on Structs
create a struct to store information about a car, including its model, number of seats, and current gear, then add a method to change gears up or down. Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly? Should the gear-changing method validate its input somehow?
 */

 /*
 Assumptions:
Every Instance of a car comes with a preloaded gear 0, i.e., Neutral
Maximum gears in a car = 5, higher gears won't be allowed
Reverse Gear = -1, lower gears won't be allowed
  */



import Cocoa

struct Car{
    let model: String
    let numberSeats: Int
    private(set) var gear: Int = 0
    
    init(model: String, seats: Int){
        self.model = model
        self.numberSeats = seats
    }
    
    mutating func upshift(){
        if gear == 5{
            print("Gear Value exceeding \(gear). Operation denied")
            return
        }
        self.gear += 1
        print("Current Gear: \(gear)")
    }
    
    mutating func downshift(){
        if gear == -1{
            print("Cannot lower the gear below \(gear) (Reverse). Operation denied")
            return
        }
        self.gear -= 1
        print("Current Gear: \(gear)")
    }
}


var car1 = Car(model: "Ford Endeavour", seats: 7)

print(car1.gear)

car1.downshift()

car1.downshift()
print(car1.gear)

car1.upshift()
car1.upshift()
car1.upshift()
car1.upshift()
car1.upshift()
car1.upshift()

car1.upshift()
print(car1.gear)
