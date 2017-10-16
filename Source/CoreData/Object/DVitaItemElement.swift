import Foundation

extension DVitaItemElement
{
    var fileExtension:MVitaItemInExtension
    {
        get
        {
            guard
            
                let rawFileExtension:String = self.rawFileExtension,
                let fileExt:MVitaItemInExtension = MVitaItemInExtension(
                    rawValue:rawFileExtension)
            
            else
            {
                return MVitaItemInExtension.unknown
            }
            
            return fileExt
        }
        
        set(newValue)
        {
            let rawFileExtension:String = newValue.rawValue
            self.rawFileExtension = rawFileExtension
        }
    }
}
