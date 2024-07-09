import Cocoa

protocol Building{
    var numRooms: Int {get set}
    var cost: Int{get}
    var agentName: String {get}
    
    func summary()
}

extension Building{
    func summary() {
        print("This building has \(numRooms) rooms, costs ₹\(cost) and it was sold by \(agentName)")
    }
    var numFloors: Int { //note Extensions to protocols cannot contain set properties. The get portion of computed property must return some value here
        get{
            return 4
        }
    }
}

struct House: Building{
    var numRooms: Int
    var cost: Int
    var agentName: String
    
    //Note: No need to write override keyword if you want to redefine a function that is in the extension of the protocol
    func summary() {
        print("This house is legendary. You don't need to know any further details.")
    }
}

struct Office: Building{
    var numRooms: Int
    var cost: Int
    var agentName: String
}

//creating instances
let house1 = House(numRooms: 5, cost: 3_06_00_000, agentName: "Kharbanda")
house1.numFloors
house1.summary()

let office1 = Office(numRooms: 100, cost: 1000000000, agentName: "xyz")
office1.summary()
