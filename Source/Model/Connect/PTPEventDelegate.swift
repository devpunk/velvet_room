import Foundation
import CocoaAsyncSocket

class PTPEventDelegate:NSObject, GCDAsyncSocketDelegate
{
    weak var connected:MConnectConnected?
    var dataReceived:Data?
    var carriedData:Data?
    
    func carryData(data:Data)
    {
        if carriedData == nil
        {
            carriedData = Data()
        }
        
        carriedData?.append(data)
    }
    
    func mergeData(data:Data) -> Data
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
    
    func start()
    {
        print("-----------------  start event")
        
        DispatchQueue.main.async
        {
//            Timer.scheduledTimer(timeInterval:0.1, target:self, selector:#selector(self.doRead), userInfo:nil, repeats:true)
            
            self.doRead()
        }
    }
    
    @objc func doRead()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            self.readWait()
        }
    }
    
    func readWait()
    {
        connected?.readEvent()
    }
    
    
    
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        dataRead(data:data, sock:sock)
    }
    
    func dataRead(data:Data, sock: GCDAsyncSocket)
    {
        var readAgain:Bool = true
        print("event received:\(data.count)")
        let mergedData:Data = mergeData(data:data)
        
        guard
            
            let header:PTPHeader = PTPHeader(data:mergedData)
            
        else
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.carriedData = nil
                self.connected?.readEvent()
            }
            
            return
        }
        
        guard
            
            header.size <= mergedData.count
        
        else
        {
            print("carry data")
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            {
                self.carryData(data:mergedData)
                self.connected?.readEvent()
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
      
        print("event header \(header.size) \(header.type)")
        
        if header.type == 8 //PTPIP_EVENT
        {
            print("------- event")
        }
        else
        {
            connected?.eventRead()
        }
    }
}
