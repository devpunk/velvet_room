import Foundation

extension MConnecting
{
    //MARK: delegate
    
    func linkError(message:String)
    {
        foundError(errorMessage:message)
    }
}
