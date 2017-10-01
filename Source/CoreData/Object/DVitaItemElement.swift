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
    
    //MARK: internal
    
    func create(
        name:String,
        localName:String,
        dateCreated:Date,
        dateModified:Date,
        size:UInt64,
        fileExtension:MVitaItemInExtension,
        directory:DVitaItemDirectory)
    {
        self.fileExtension = fileExtension
        self.directory = directory
        
        create(
            name:name,
            localName:localName,
            dateCreated:dateCreated,
            dateModified:dateModified,
            size:size,
            format:MVitaItemFormat.element)
    }
}
