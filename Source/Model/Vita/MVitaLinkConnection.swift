import Foundation

extension MVitaLink
{
    //MARK: internal
    
    func connectCommand()
    {
        strategyConnectCommand()
        linkCommand.connect()
    }
    
    func connectEvent()
    {
        strategyConnectEvent()
        linkEvent.connect()
    }
    
    func requestCommand()
    {
        let message:MVitaPtpMessageOutRequestCommand = MVitaPtpMessageOutRequestCommand()
        
        linkCommand.socket.write(
            message.data,
            withTimeout:0,
            tag:0)
        linkCommand.socket.readData(
            withTimeout:0,
            tag:0)
    }
}
