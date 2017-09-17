import Foundation

final class MConnectingSocketTcpMethodRegisterCancel:MConnectingSocketTcpMethodProtocol
{
    let type:MConnectingSocketTcpMethodType = MConnectingSocketTcpMethodType.registerCancel
    
    init(received:String)
    {
    }
    
    //MARK: internal
    
    func strategy(model:MConnectingSocketTcp)
    {
        let message:String = String.localizedModel(
            key:"MConnectingSocketTcpMethodRegisterCancel_message")
        model.model?.model?.foundError(errorMessage:message)
    }
}
