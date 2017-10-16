import Foundation

extension MError
{
    //MARK: private
    
    private static func factory(key:String) -> MError
    {
        let message:String = String.localizedModel(
            key:key)
        let error:MError = MError(
            localizedDescription:message)
        
        return error
    }
    
    //MARK: internal
    
    static func factoryDataNotFound() -> MError
    {
        let error:MError = factory(key:"MError_dataNotFound")
        
        return error
    }
}
