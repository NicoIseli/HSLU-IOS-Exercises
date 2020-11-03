class Person{
    
    var firstName: String
    var lastName: String
    var plz: Int
    
    init(firstName: String, lastName: String, plz: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.plz = plz
    }
    
    
    class func createPersons() -> [Person] {
        var persons: [Person] = [
            Person(firstName: "Alex", lastName: "Altherr", plz: 1111),
            Person(firstName: "Bruno", lastName: "Bodner", plz: 1111),
            Person(firstName: "Claude", lastName: "Chlaus", plz: 1111),
            Person(firstName: "Daniel", lastName: "Dorn", plz: 1111),
            Person(firstName: "Emil", lastName: "Emmenegger", plz: 1111),
            Person(firstName: "Franz", lastName: "Frutiger", plz: 1111),
            Person(firstName: "Gerhard", lastName: "Grau", plz: 1111)
        ]
        
        return persons
    }
}
