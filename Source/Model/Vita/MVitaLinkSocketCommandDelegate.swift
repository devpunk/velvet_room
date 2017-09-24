import Foundation
import CocoaAsyncSocket

final class MVitaLinkSocketCommandDelegate:MVitaLinkPtpDelegate
{
    weak var model:MVitaLinkCommand?
    
    override func received(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        model?.model?.strategy?.commandReceived(
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
            
            self?.model?.model?.strategy?.commandConnected()
        }
    }
    
    func socketDidDisconnect(
        _ sock:GCDAsyncSocket,
        withError err:Error?)
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model?.model?.strategy?.commandDisconnected()
        }
    }
    
    func socket(
        _ sock:GCDAsyncSocket,
        didWriteDataWithTag tag:Int)
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.model?.model?.strategy?.commandWrite()
        }
    }
}
