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
        let packetData:Data = data.subdata(
            start:bytesSent,
            endNotIncluding:endIndex)
        
        bytesSent += bytes
        
        return packetData
    }
    
    private func wrapData(data:Data)
    {
        let size:UInt32 = UInt32(data.count)
        var dataWrapped:Data = Data()
        dataWrapped.append(value:size)
        dataWrapped.append(data)
        
        self.data = dataWrapped
    }
    
    //MARK: internal
    
    final func loadData(
        resourceName:String,
        resourceExtension:String) -> Data?
    {
        guard
            
            let url:URL = Bundle.main.url(
                forResource:resourceName,
                withExtension:resourceExtension)
            
        else
        {
            return nil
        }
        
        let data:Data
        
        do
        {
            try data = Data(
                contentsOf:url,
                options:Data.ReadingOptions())
        }
        catch
        {
            return nil
        }
        
        return data
    }
    
    final func send(
        data:Data,
        code:UInt16)
    {
        wrapData(data:data)
        
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
