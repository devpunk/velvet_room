import Foundation

final class MVitaLinkStrategySendItemsCount:
    MVitaLinkStrategyProtocol,
    MVitaLinkStrategyDatabaseProtocol,
    MVitaLinkStrategyEventProtocol
{
    private(set) var model:MVitaLink?
    private weak var database:Database?
    private var event:MVitaPtpMessageInEvent?
    private let kCountNotSupported:Int = 0
    
    init(model:MVitaLink)
    {
        self.model = model
    }
    
    //MARK: protocol
    
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
    
    private func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategySendItemsCount_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    private func success()
    {
        guard
            
            let event:MVitaPtpMessageInEvent = self.event
            
        else
        {
            failed()
            
            return
        }
        
        model?.sendResultSuccess(
            event:event,
            parameters:[])
    }
    
    //MARK: database protocol
    
    func config(database:Database)
    {
        self.database = database
    }
    
    //MARK: event protocol
    
    func config(event:MVitaPtpMessageInEvent)
    {
        self.event = event
        
        guard
        
            let catetegory:MVitaItemCategory = factoryCategory(
                event:event)
        
        else
        {
            failed()
            
            return
        }
        
        guard
        
            catetegory == MVitaItemCategory.savedData
        
        else
        {
            send(
                event:event,
                count:kCountNotSupported)
            
            return
        }
        
        sendSavedDataCount(event:event)
    }
    
    //MARK: private
    
    private func sendSavedDataCount(
        event:MVitaPtpMessageInEvent)
    {
        guard
        
            let database:Database = self.database
        
        else
        {
            failed()
            
            return
        }
        
        database.fetch
        { [weak self] (identifiers:[DVitaIdentifier]) in
            
            let count:Int = identifiers.count
            
            self?.send(
                event:event,
                count:count)
        }
    }
    
    private func factoryCategory(
        event:MVitaPtpMessageInEvent) -> MVitaItemCategory?
    {
        guard
        
            let rawCategory:UInt32 = event.parameters.first
        
        else
        {
            return nil
        }
        
        let category:MVitaItemCategory = MVitaItemCategory.factoryCategory(
            rawCategory:rawCategory)
        
        return category
    }
    
    private func send(
        event:MVitaPtpMessageInEvent,
        count:Int)
    {        
        let message:MVitaPtpMessageOutSendItemsCount = MVitaPtpMessageOutSendItemsCount(
            event:event,
            count:count)
        model?.linkCommand.writeMessage(
            message:message)
    }
}
