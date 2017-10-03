import Foundation

extension MConnectingSocketTcpMethodType
{
    private static let kMethodMap:[
        MConnectingSocketTcpMethodType:
        MConnectingSocketTcpMethodProtocol.Type] = [
            MConnectingSocketTcpMethodType.showpin:
                MConnectingSocketTcpMethodShowpin.self,
            MConnectingSocketTcpMethodType.register:
                MConnectingSocketTcpMethodRegister.self,
            MConnectingSocketTcpMethodType.registerResult:
                MConnectingSocketTcpMethodRegisterResult.self,
            MConnectingSocketTcpMethodType.registerCancel:
                MConnectingSocketTcpMethodRegisterCancel.self,
            MConnectingSocketTcpMethodType.connect:
                MConnectingSocketTcpMethodConnect.self,
            MConnectingSocketTcpMethodType.standby:
                MConnectingSocketTcpMethodStandby.self]
    
    //MARK: internal
    
    static func factoryMethod(
        name:String,
        received:String) -> MConnectingSocketTcpMethodProtocol?
    {
        guard
        
            let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType(
                rawValue:name),
            let methodType:MConnectingSocketTcpMethodProtocol.Type = kMethodMap[
                type]
        
        else
        {
            return nil
        }
        
        let method:MConnectingSocketTcpMethodProtocol = methodType.init(
            received:received)
        
        return method
    }
}
