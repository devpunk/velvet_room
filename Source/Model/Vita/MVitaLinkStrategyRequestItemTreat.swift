import Foundation

final class MVitaLinkStrategyRequestItemTreat:MVitaLinkStrategyRequestDataEvent
{
    private weak var currentItem:MVitaItemIn?
    private var rootItemIn:MVitaItemIn?
    private var status:MVitaLinkStrategyRequestItemTreatProtocol?
    
    required init(model:MVitaLink)
    {
        super.init(model:model)
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatStart.self)
    }
    
    override func failed()
    {
        let message:String = String.localizedModel(
            key:"MVitaLinkStrategyRequestItemTreat_messageFailed")
        model?.errorCloseConnection(
            message:message)
    }
    
    override func success()
    {
        status?.success(strategy:self)
    }
    
    //MARK: private

    private func changeStatus(
        statusType:MVitaLinkStrategyRequestItemTreatProtocol.Type)
    {
        restart()
        
        let status:MVitaLinkStrategyRequestItemTreatProtocol = statusType.init()
        self.status = status
    }
    
    private func requestItemElements()
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            failed()
            
            return
        }
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatElements.self)
        model?.linkCommand.requestItemElements(
            itemTreat:itemTreat)
    }
    
    private func requestItemFileSize()
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            failed()
            
            return
        }
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatSize.self)
        model?.linkCommand.requestItemFileSize(
            itemTreat:itemTreat)
    }
    
    private func requestItem(
        rawElement:UInt32)
    {
        guard
        
            let parentTreat:MVitaItemTreat = currentItem?.treat
        
        else
        {
            return
        }
        
        let itemTreat:MVitaItemTreat = MVitaItemTreat.factoryTreat(
            parentTreat:parentTreat,
            treatId:rawElement)
        
        requestItemFormat(itemTreat:itemTreat)
    }
    
    private func createNewItem(
        itemTreat:MVitaItemTreat)
    {
        let newItem:MVitaItemIn = MVitaItemIn(
            treat:itemTreat,
            parent:currentItem)
        currentItem?.addElement(element:newItem)
        currentItem = newItem
        
        if rootItemIn == nil
        {
            rootItemIn = currentItem
        }
    }
    
    private func nextElement()
    {
        guard
        
            let rawElement:UInt32 = currentItem?.rawElements?.popLast()
        
        else
        {
            currentItemFinished()
            
            return
        }
        
        requestItem(rawElement:rawElement)
    }
    
    private func currentItemFinished()
    {
        guard
        
            let parent:MVitaItemIn = currentItem?.parent
        
        else
        {
            allItemsFinished()
            
            return
        }
        
        currentItem = parent
        nextElement()
    }
    
    private func allItemsFinished()
    {
        print("finished all items")
    }
    
    //MARK: internal
    
    func requestItemFormat(
        itemTreat:MVitaItemTreat)
    {
        createNewItem(itemTreat:itemTreat)
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatFormat.self)
        model?.linkCommand.requestItemFormat(
            itemTreat:itemTreat)
    }
    
    func requestFileName(
        itemFormat:MVitaItemFormat)
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
        
        else
        {
            failed()
            
            return
        }
        
        currentItem?.format = itemFormat
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatFileName.self)
        model?.linkCommand.requestItemFileName(
            itemTreat:itemTreat)
    }
    
    func requestDateModified(
        itemFileName:String)
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            failed()
            
            return
        }
        
        currentItem?.name = itemFileName
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatDateModified.self)
        model?.linkCommand.requestItemDateModified(
            itemTreat:itemTreat)
    }
    
    func requestItemContent(
        itemDateModified:Date)
    {
        currentItem?.dateModified = itemDateModified
        
        guard
            
            let format:MVitaItemFormat = currentItem?.format
            
        else
        {
            failed()
            
            return
        }
        
        switch format
        {
        case MVitaItemFormat.folder:
            
            requestItemElements()
            
            break
            
        case MVitaItemFormat.file,
             MVitaItemFormat.unknown:
            
            requestItemFileSize()
            
            break
        }
    }
    
    func requestItemData(
        itemSize:UInt64)
    {
        guard
            
            let itemTreat:MVitaItemTreat = currentItem?.treat
            
        else
        {
            failed()
            
            return
        }
        
        currentItem?.size = itemSize
        
        changeStatus(
            statusType:MVitaLinkStrategyRequestItemTreatData.self)
        model?.linkCommand.requestItemData(
            itemTreat:itemTreat)
    }
    
    func itemElementsReceived(
        itemElements:[UInt32])
    {
        currentItem?.rawElements = itemElements
        nextElement()
    }
    
    func itemDataReceived(
        itemData:Data)
    {
        currentItem?.data = itemData
        nextElement()
    }
}
