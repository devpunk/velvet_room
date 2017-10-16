import Foundation

extension MConnecting
{
    //MARK: internal
    
    func statusLoading()
    {
        status = MConnectingStatusLoading()
    }
    
    func statusPin()
    {
        status = MConnectingStatusPin()
    }
    
    func statusTimeout()
    {
        status = MConnectingStatusTimeout()
    }
    
    func statusError(errorMessage:String)
    {
        status = MConnectingStatusError(
            errorMessage:errorMessage)
    }
}
