import Foundation

class MVitaLinkStrategyReceiveData:MVitaLinkStrategyProtocol
{
    var data:Data
    var payload:Int
    var transactionId:UInt32
    private(set) var model:MVitaLink?
    private let kElementsStart:Int = 2
    
    required init(model:MVitaLink)
    {
        self.model = model
        data = Data()
        payload = 0
        transactionId = 0
    }
    
    //MARK: protocol
    
    func commandReceived(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        switch header.type
        {
        case MVitaPtpType.dataPacketStart:
            
            receivedPacketStart(
                header:header,
                data:data)
            
            break
            
        case MVitaPtpType.dataPacket:
            
            receivedPacket(
                header:header,
                data:data)
            
            break
            
        case MVitaPtpType.dataPacketEnd:
            
            receivedPacketEnd(
                header:header,
                data:data)
            
            break
            
        case MVitaPtpType.commandAccepted:
            
            receivedConfirm(
                header:header,
                data:data)
            
            break
            
        default:
            
            failed()
            
            break
        }
    }
    
    //MARK: private
    
    private func readAgain()
    {
        model?.linkCommand.readData()
    }
    
    private func removeTransaction(data:Data) -> Data?
    {
        guard
            
            let transactionId:UInt32 = data.valueFromBytes(),
            self.transactionId == transactionId
            
        else
        {
            return nil
        }
        
        let transactionSize:Int = MemoryLayout<UInt32>.size
        let subdataRange:Range<Data.Index> = Range<Data.Index>(
            transactionSize ..< data.count)
        let subdata:Data = data.subdata(in:subdataRange)
        
        return subdata
    }
    
    private func receivedPacketStart(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
            
            let arrayData:[UInt32] = data.arrayFromBytes(
                elements:kElementsStart),
            let transactionId:UInt32 = arrayData.first,
            let payloadUnsigned:UInt32 = arrayData.last
            
        else
        {
            failed()
            
            return
        }
        
        self.transactionId = transactionId
        payload = Int(payloadUnsigned)
        
        readAgain()
    }
    
    private func receivedPacket(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
        
            let data:Data = removeTransaction(data:data)
        
        else
        {
            failed()
            
            return
        }
        
        self.data.append(data)
        
        readAgain()
    }
    
    private func receivedPacketEnd(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
            
            let data:Data = removeTransaction(data:data)
            
        else
        {
            failed()
            
            return
        }
        
        self.data.append(data)
        
        guard
        
            self.data.count == payload
        
        else
        {
            failed()
            
            return
        }
        
        readAgain()
    }
    
    private func receivedConfirm(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        guard
            
            let code:UInt16 = data.valueFromBytes()
        
        else
        {
            failed()
            
            return
        }
        
        let subData:Data = data.subdata(in:4..<data.count)
        let tranid:UInt32? = subData.valueFromBytes()
        
        print("tranid \(tranid)")
        
        print("code \(code) data size: \(data.count) header size: \(header.size)")
        
        guard
            
            code == MVitaPtpCommand.success
        
        else
        {
            failed()
            
            return
        }
        
        success()
    }
    
    //MARK: internal
    
    func failed() { }
    func success() { }
}
