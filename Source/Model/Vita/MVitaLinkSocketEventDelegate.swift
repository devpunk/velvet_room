import Foundation
import CocoaAsyncSocket

final class MVitaLinkSocketEventDelegate:MVitaLinkPtpDelegate
{
    weak var model:MVitaLinkSocketEvent?
    
    override func received(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        model?.model?.strategy?.eventReceived(
            header:header,
            data:data)
    }
    
    //MARK: delegate
    
    func socket(
        _ sock:GCDAsyncSocket,
        didConnectToHost host:String,
        port:UInt16)
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model?.model?.strategy?.eventConnected()
        }
    }
    
    func socketDidDisconnect(
        _ sock:GCDAsyncSocket,
        withError err:Error?)
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model?.model?.strategy?.eventDisconnected()
        }
    }
    
    func socket(
        _ sock:GCDAsyncSocket,
        didWriteDataWithTag tag:Int)
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model?.model?.strategy?.eventWrite()
        }
    }
}
