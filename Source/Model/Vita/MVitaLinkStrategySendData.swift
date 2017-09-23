import Foundation

class MVitaLinkStrategySendData:MVitaLinkStrategyProtocol
{
    private(set) var model:MVitaLink?
    private var bytesSent:Int
    private var data:Data?
    private var status:MVitaLinkStrategySendDataStatusProtocol?
    private let kNullEnd:String = "\0"
    private let kMaxBlockSize:Int = 32756
    
    required init(model:MVitaLink)
    {
        self.model = model
        bytesSent = 0
    }
    
    //MARK: protocol
    
    func commandWrite()
    {
        status?.commandWrite(strategy:self)
    }
    
    func commandReceived(
        header:MVitaPtpMessageInHeader,
        data:Data)
    {
        print("header:\(header.size) \(header.type)")
        
        guard
            
            let confirm:MVitaPtpMessageInConfirm = MVitaPtpMessageInConfirm(
                header:header,
                data:data),
            header.type == MVitaPtpType.commandAccepted,
            confirm.code == MVitaPtpCommand.success
            
        else
        {
            failed()
            
            return
        }
        
        success()
    }
    
    //MARK: private
    
    private func changeStatus(
        status:MVitaLinkStrategySendDataStatusProtocol.Type)
    {
        self.status = status.init()
    }
    
    private func packet(data:Data)
    {
        let packetData:Data = packetSubData(
            data:data,
            bytes:kMaxBlockSize)
        
        let message:MVitaPtpMessageOutPacket = MVitaPtpMessageOutPacket(
            packetData:packetData)
        model?.linkCommand.writeMessage(
            message:message)
    }
    
    private func packetEnd(
        data:Data,
        remainBytes:Int)
    {
        let packetData:Data = packetSubData(
            data:data,
            bytes:remainBytes)
        
        print("sub \(packetData.count) total: \(self.data!.count)")
        
        changeStatus(
            status:MVitaLinkStrategySendDataStatusConfirm.self)
        
        let message:MVitaPtpMessageOutPacketEnd = MVitaPtpMessageOutPacketEnd(
            packetData:packetData)
        model?.linkCommand.writeMessage(
            message:message)
    }
    
    private func packetSubData(
        data:Data,
        bytes:Int) -> Data
    {
        let endIndex:Int = bytesSent + bytes
        let packetRange:Range<Data.Index> = Range<Data.Index>(
            bytesSent ..< endIndex)
        let packetData:Data = data.subdata(
            in:packetRange)
        
        bytesSent += bytes
        
        return packetData
    }
    
    private func wrapData(data:Data) -> Data
    {
        let size:UInt32 = UInt32(data.count)
        print("wrapping size \(size)")
        var dataWrapped:Data = Data()
        dataWrapped.append(value:size)
        dataWrapped.append(data)
//        dataWrapped.append(value:kNullEnd)
        
        return dataWrapped
    }
    
    //MARK: internal
    
    final func send(
        data:Data,
        code:UInt16)
    {
        let xmlString:String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><initiatorInfo platformType=\"PC\" platformSubtype=\"Unknown\" osVersion=\"0.0\" version=\"3.55.764345\" protocolVersion=\"01900010\" name=\"Content Manager Assistant\" applicationType=\"5\" />\0"
        
        let xmlData:Data = xmlString.data(using:String.Encoding.ascii, allowLossyConversion:false)!
        
        self.data = wrapData(data:xmlData)
        
        print("wrapped size:\(self.data?.count)")
        
        changeStatus(
            status:MVitaLinkStrategySendDataStatusHeader.self)
        
        let message:MVitaPtpMessageOutSendData = MVitaPtpMessageOutSendData(
            code:code)
        model?.linkCommand.writeMessage(
            message:message)
    }
    
    final func packetStart()
    {
        guard
            
            let dataSize:Int = data?.count
        
        else
        {
            return
        }
        
        changeStatus(
            status:MVitaLinkStrategySendDataStatusPacket.self)
        
        let message:MVitaPtpMessageOutPacketStart = MVitaPtpMessageOutPacketStart(
            dataSize:dataSize)
        model?.linkCommand.writeMessage(
            message:message)
    }
    
    final func packet()
    {
        guard
            
            let data:Data = self.data
            
        else
        {
            return
        }
        
        let remainBytes:Int = data.count - bytesSent
        
        if remainBytes > kMaxBlockSize
        {
            packet(data:data)
        }
        else
        {
            packetEnd(
                data:data,
                remainBytes:remainBytes)
        }
    }
    
    func failed() { }
    func success() { }
}
