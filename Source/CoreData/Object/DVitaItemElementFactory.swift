import Foundation

extension DVitaItemElement
{
    //MARK: internal
    
    func config(itemElement:MVitaItemInElement)
    {
        super.config(item:itemElement)
        
        if let name:String = itemElement.name
        {
            self.name = name
        }
        else
        {
            self.name = String()
        }
        
        fileExtension = itemElement.fileExtension
    }
}
