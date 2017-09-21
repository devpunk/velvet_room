import Foundation

extension MConnectingSocketTcpMethodType
{
    private static func factoryMethod(
        type:MConnectingSocketTcpMethodType) -> MConnectingSocketTcpMethodProtocol.Type
    {
        switch type
        {
        case MConnectingSocketTcpMethodType.showpin:
            
            return MConnectingSocketTcpMethodShowpin.self
            
        case MConnectingSocketTcpMethodType.register:
            
            return MConnectingSocketTcpMethodRegister.self
            
        case MConnectingSocketTcpMethodType.registerResult:
            
            return MConnectingSocketTcpMethodRegisterResult.self
            
        case MConnectingSocketTcpMethodType.registerCancel:
            
            return MConnectingSocketTcpMethodRegisterCancel.self
            
        case MConnectingSocketTcpMethodType.connect:
            
            return MConnectingSocketTcpMethodConnect.self
            
        case MConnectingSocketTcpMethodType.standby:
            
            return MConnectingSocketTcpMethodStandby.self
        }
    }
    
    //MARK: internal
    
    static func factoryMethod(string:String) -> MConnectingSocketTcpMethodProtocol?
    {
        guard
        
            let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType(
                rawValue:string)
        
        else
        {
            return nil
        }
        
        let methodType:MConnectingSocketTcpMethodProtocol.Type = factoryMethod(
            type:type)
        let method:MConnectingSocketTcpMethodProtocol = methodType.init(
            received:string)
        
        return method
    }
}
