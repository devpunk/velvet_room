import Foundation

final class MConnectingSocketTcpMethodConnect:MConnectingSocketTcpMethodProtocol
{
    private var received:String
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.connect
    
    init(received:String)
    {
        self.received = received
    }
    
    //MARK: internal
    
    func strategy(model:MConnectingSocketTcp)
    {
        guard
        
            let device:MVitaDevice = MVitaDevice.factoryDevice(
                receivedString:received,
                socket:model)
        
        else
        {
            model.strategyReplyConnectingError()
            
            return
        }
        
        model.strategyConnect(device:device)
    }
}
