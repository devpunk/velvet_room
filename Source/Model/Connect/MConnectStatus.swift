import Foundation

extension MConnect
{
    //MARK: internal
    
    func statusStandby()
    {
        status = MConnectStatusStandby()
    }
    
    func statusLoading()
    {
        status = MConnectStatusLoading()
    }
    
    func statusConnected()
    {
        status = MConnectStatusConnected()
    }
}
