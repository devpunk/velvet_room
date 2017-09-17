import Foundation

extension MConnectingSocket
{
    //MARK: private
    
    private func asyncStart()
    {
        guard
        
            let modelTcp:MConnectingSocketTcp = factoryTcp()
        
        else
        {
            failedTcpSocket()
            
            return
        }
        
        guard
        
            let modelUdp:MConnectingSocketUdp = factoryUdp()
        
        else
        {
            modelTcp.cancel()
            failedUdpSocket()
            
            return
        }
        
        self.modelTcp = modelTcp
        self.modelUdp = modelUdp
    }
    
    private func failedTcpSocket()
    {
        let message:String = String.localizedModel(
            key:"MConnectingSocket_failedTcpSocket")
        model?.foundError(errorMessage:message)
    }
    
    private func failedUdpSocket()
    {
        let message:String = String.localizedModel(
            key:"MConnectingSocket_failedUdpSocket")
        model?.foundError(errorMessage:message)
    }
    
    //MARK: internal
    
    func start()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncStart()
        }
    }
}
