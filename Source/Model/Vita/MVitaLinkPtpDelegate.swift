import Foundation
import CocoaAsyncSocket

class MVitaLinkPtpDelegate:
    NSObject,
    GCDAsyncSocketDelegate
{
    private var carriedData:Data?
    
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
        var readAgain:Bool = true
        let mergedData:Data = mergeData(data:data)

        guard
            
            let header:PTPHeader = PTPHeader(data:mergedData),
            header.size <= mergedData.count
            
            else
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                {
                    self.carryData(data:mergedData)
                    self.connected?.readCommand()
            }
            
            return
        }
        
        if header.size < mergedData.count
        {
            readAgain = false
            
            defer
            {
                DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
                    {
                        let sub:Data = mergedData.subdata(in:Int(header.size) ..< mergedData.count)
                        print("subdata: \(sub.count)")
                        self.dataRead(data:sub, sock:sock)
                }
            }
        }
        
        let dataUnheader:Data = mergedData.subdata(in:8 ..< Int(header.size))
    }
    
    private func asyncRead(socket:GCDAsyncSocket)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            socket.readData(
                withTimeout:0,
                tag:0)
        }
    }
    
    //MARK: delegate
    
    final func socket(
        _ sock:GCDAsyncSocket,
        didRead data:Data,
        withTag tag:Int)
    {
        read(socket:sock, data:data)
    }
}
