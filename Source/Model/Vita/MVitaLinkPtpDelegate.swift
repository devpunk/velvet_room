import Foundation
import CocoaAsyncSocket

class MVitaLinkPtpDelegate:
    NSObject,
    GCDAsyncSocketDelegate
{
    private let queue:DispatchQueue
    private var carriedData:Data?
    
    override init()
    {
        queue = MVitaLinkPtpDelegate.factoryQueue()
        
        super.init()
    }
    
    //MARK: private
    
    private func carryData(data:Data)
    {
        if carriedData == nil
        {
            carriedData = Data()
        }
        
        carriedData?.append(data)
    }
    
    private func mergeData(data:Data) -> Data
    {
        var merged:Data = Data()
        
        if let carriedData:Data = self.carriedData
        {
            merged.append(carriedData)
            self.carriedData = nil
        }
        
        merged.append(data)
        
        return merged
    }
    
    private func read(
        socket:GCDAsyncSocket,
        data:Data)
    {
        let mergedData:Data = mergeData(data:data)

        guard
            
            let header:MVitaPtpMessageInHeader = MVitaPtpMessageIn.factoryHeader(
                data:data),
            mergedData.count >= header.size
            
        else
        {
            carryData(data:data)
            asyncRead(socket:socket)
            
            return
        }
        
        read(
            header:header,
            socket:socket,
            data:mergedData)
        checkSurplus(
            header:header,
            socket:socket,
            data:data)
    }
    
    private func read(
        header:MVitaPtpMessageInHeader,
        socket:GCDAsyncSocket,
        data:Data)
    {
        let unheaderDataRange:Range<Data.Index> = Range<Data.Index>(
            MVitaPtpMessageInHeader.size ..< header.size)
        let unheaderData:Data = data.subdata(
            in:unheaderDataRange)
        
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.received(
                header:header,
                data:unheaderData)
        }
    }
    
    private func checkSurplus(
        header:MVitaPtpMessageInHeader,
        socket:GCDAsyncSocket,
        data:Data)
    {
        guard
            
            data.count > header.size
            
        else
        {
            return
        }
        
        let surplusDataRange:Range<Data.Index> = Range<Data.Index>(
            header.size ..< data.count)
        let surplusData:Data = data.subdata(
            in:surplusDataRange)
        
        read(socket:socket, data:surplusData)
    }
    
    private func asyncRead(socket:GCDAsyncSocket)
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        {
            socket.readData(
                withTimeout:-1,
                tag:0)
        }
    }
    
    //MARK: internal
    
    func received(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
    }
    
    //MARK: delegate
    
    final func socket(
        _ sock:GCDAsyncSocket,
        didRead data:Data,
        withTag tag:Int)
    {
        queue.async
        { [weak self] in
            
            self?.read(
                socket:sock,
                data:data)
        }
    }
}
