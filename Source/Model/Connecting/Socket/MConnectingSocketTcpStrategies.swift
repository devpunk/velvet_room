import Foundation

extension MConnectingSocketTcp
{
    //MARK: internal
    
    func strategyShowpin()
    {
        model?.model?.createPin()
        strategyReplyOk()
    }
    
    func strategyConnect(device:MVitaDevice)
    {
        self.device = device
        strategyReplyOk()
    }
    
    func strategyReplyOk()
    {
        
    }
    
    func strategyReplyPinError()
    {
        
    }
    
    func strategyReplyConnected()
    {
        
    }
    
    func strategyReplyConnectingError()
    {
        
    }
}
