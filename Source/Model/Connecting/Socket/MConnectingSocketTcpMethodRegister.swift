import Foundation

final class MConnectingSocketTcpMethodRegister:MConnectingSocketTcpMethodProtocol
{
    private var received:String
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.register
    
    init(received:String)
    {
        self.received = received
    }
    
    //MARK: private
    
    private func parsePin(
        socket:MConnectingSocket) -> String?
    {
        let compo1 = received.components(
            separatedBy:socket.configuration.lineSeparator)
        
        for com in compo1
        {
            if com.contains("pin-code")
            {
                let compo2 = com.components(separatedBy:"pin-code:")
                
                return compo2[1]
            }
        }
        
        return nil
    }
    
    //MARK: internal
    
    func strategy(model:MConnectingSocketTcp)
    {
        guard
        
            let socket:MConnectingSocket = model.model,
            let receivedPin:String = parsePin(
                socket:socket)
        else
        {
            model.strategyReplyPinError()
            
            return
        }
    }
}
