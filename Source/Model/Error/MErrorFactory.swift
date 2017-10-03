import Foundation

extension MError
{
    //MARK: private
    
    private static func factory(key:String) -> MError
    {
        let message:String = String.localizedModel(
            key:key)
        let error:Error = Error(
            localizedDescription:message)
        
        return error
    }
    
    //MARK: internal
    
    static func factoryDataNotFound() -> MError
    {
        let error:Error = factory(key:"MError_dataNotFound")
        
        return error
    }
}
