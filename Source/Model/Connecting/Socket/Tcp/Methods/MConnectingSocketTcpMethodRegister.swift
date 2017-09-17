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
        let pinTitle:String = socket.configuration.broadcast.pinTitle
        let stringComponents:[String] = received.components(
            separatedBy:
            socket.configuration.lineSeparator)
        
        for component:String in stringComponents
        {
            guard
            
                component.contains(pinTitle)
            
            else
            {
                continue
            }
            
            let pinComponents:[String] = component.components(
                separatedBy:pinTitle)
            let pinCode:String? = pinComponents.last
            
            return pinCode
        }
        
        return nil
    }
    
    //MARK: internal
    
    func strategy(model:MConnectingSocketTcp)
    {
        guard
        
            let socket:MConnectingSocket = model.model,
            let receivedPin:String = parsePin(
                socket:socket),
            let modelPin:MConnectingPin = model.model?.model?.modelPin,
            modelPin.validatePin(pinString:receivedPin)
            
        else
        {
            model.strategyReplyPinError()
            
            return
        }
        
        model.strategyReplyOk()
    }
}
