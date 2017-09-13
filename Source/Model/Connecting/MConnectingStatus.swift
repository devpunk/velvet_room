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
}
