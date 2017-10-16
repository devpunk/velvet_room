import Foundation

extension MConnected
{
    //MARK: internal
    
    func statusOn()
    {
        status = MConnectedStatusOn()
    }
    
    func statusError(errorMessage:String)
    {
        status = MConnectedStatusError(
            errorMessage:errorMessage)
    }
}
