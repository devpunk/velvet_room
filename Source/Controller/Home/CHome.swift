import Foundation

final class CHome:Controller<ArchHome>
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        parentController?.view.isUserInteractionEnabled = false
        model.loadSession()
        
        let database:Database? = Database(bundle:nil)
        database?.fetch
            { (directory:[DVitaItemDirectory]) in
            
                directory.first?.export(completion: { (data:Data?) in
                    
                    guard
                    
                    let string:String = String(data:data!, encoding:String.Encoding.utf8)
                    
                    else
                    {
                        return
                    }
                    
                    print(string)
                })
        }
        
        database?.fetch
        { (elements:[DVitaItemElement]) in
            
            for element in elements
            {
                if element.fileExtension == MVitaItemInExtension.sfo
                {
                    guard
                    
                        let storagePath:URL = MVitaLink.storagePath(
                            element:element)
                    
                    else
                    {
                        continue
                    }
                    
                    self.parseSfo(location:storagePath)
                }
            }
        }
    }
    
    //MARK: internal
    
    func parseSfo(location:URL)
    {
        let data:Data
        
        do
        {
            try data = Data(
                contentsOf:location,
                options:Data.ReadingOptions.mappedIfSafe)
        }
        catch
        {
            return
        }
        
        
        print("data size\(data.count)")
        
        guard
        
            let arrayHeader:[UInt32] = data.arrayFromBytes(elements:20)
        
        else
        {
            return
        }
        
        let keyTable:UInt32 = arrayHeader[3]
        let dataTable:UInt32 = arrayHeader[4]
        let entryCount:UInt32 = arrayHeader[5]
        
        
        
        
        
    }
    
    func sessionLoaded()
    {
        parentController?.view.isUserInteractionEnabled = true
    }
}
