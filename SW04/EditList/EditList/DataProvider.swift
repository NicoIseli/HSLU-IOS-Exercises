class DataProvider {
    
    var memberPersons: [Person] = []
   
    private init(memberPersons: [Person]){
        for person in memberPersons{
            self.memberPersons.append(person)
        }
    }
    
    class func createDataProvider() -> DataProvider{
        let dataProvider : DataProvider = DataProvider(memberPersons: Person.createPersons())
        return dataProvider
    }
}
