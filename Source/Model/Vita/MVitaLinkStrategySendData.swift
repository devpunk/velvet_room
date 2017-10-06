import Foundation

class MVitaLinkStrategySendData:MVitaLinkStrategyProtocol
{
    private(set) var model:MVitaLink?
    private var bytesSent:Int
    private var data:Data?
    private var status:MVitaLinkStrategySendDataStatusProtocol?
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
        statusType:MVitaLinkStrategySendDataStatusProtocol.Type)
    {
        DispatchQueue.global(
            qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            let status:MVitaLinkStrategySendDataStatusProtocol = statusType.init()
            self?.status = status
        }
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
        changeStatus(
            statusType:MVitaLinkStrategySendDataStatusConfirm.self)
        
        let packetData:Data = packetSubData(
            data:data,
            bytes:remainBytes)
        
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
        let packetData:Data = data.subdata(
            start:bytesSent,
            endNotIncluding:endIndex)
        
        bytesSent += bytes
        
        return packetData
    }
    
    //MARK: internal
    
    final func send(
        data:Data,
        message:MVitaPtpMessageOutProtocol)
    {
        self.data = data
        bytesSent = 0
        
        changeStatus(
            statusType:MVitaLinkStrategySendDataStatusHeader.self)
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
            statusType:MVitaLinkStrategySendDataStatusPacket.self)
        
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
