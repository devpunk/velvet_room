import Foundation

extension MVitaItemInDirectory
{
    //MARK: internal
    
    func mergeChildrenSize()
    {
        var totalSize:UInt64 = self.size
        
        for element:MVitaItemInElement in elements
        {
            totalSize += element.size
        }
        
        self.size = size
    }
}
