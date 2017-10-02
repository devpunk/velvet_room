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
            
                MVitaXmlItemMetaData.factoryMetaData(items:[directory.first!], completion: { (data:Data?) in
                    
                    guard
                        
                        let string:String = String(data:data!, encoding:String.Encoding.utf8)
                        
                        else
                    {
                        return
                    }
                    
                    print(string)
                    
                    
                })
                
        }
        
//        database?.fetch
//            { (items:[DVitaIdentifier]) in
//            
//                for item in items
//                {
//                    print(item)
//                    print(item.items?.count)
//                }
//        }
        
//        database?.fetch
//        { (elements:[DVitaItemElement]) in
//
//            for element in elements
//            {
//                if element.fileExtension == MVitaItemInExtension.sfo
//                {
//                    guard
//
//                        let storagePath:URL = MVitaLink.storagePath(
//                            element:element)
//
//                    else
//                    {
//                        continue
//                    }
//
//                    self.parseSfo2(location:storagePath)
//                }
//            }
//        }
    }
    
    //MARK: internal
    
    func parseSfo2(location:URL)
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
        
        let msfo = MSfo.factorySfo(data:data)
        print(msfo)
    }
    
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
        
            let arrayHeader:[UInt32] = data.arrayFromBytes(elements:5)
        
        else
        {
            return
        }
        
        let keyTable:UInt32 = arrayHeader[2]
        let dataTable:UInt32 = arrayHeader[3]
        let entryCount:Int = Int(arrayHeader[4])
        var entries:[entry] = []
        var newData:Data = data.subdata(start:20)
        
        for _:Int in 0 ..< entryCount
        {
            let e:entry = entry.factoryEntry(data:newData)
            newData = newData.subdata(start:sizeOfEntry)
            
            entries.append(e)
        }
        
        for e:entry in entries
        {
            let offset:Int = Int(keyTable) + Int(e.keyOffset)
            let subdata:Data = data.subdata(start:offset)
            let arraySubdata:[UInt8] = subdata.arrayFromBytes(elements:subdata.count)!
            var stringData:Data = Data()
            
            for arrayItem:UInt8 in arraySubdata
            {
                if arrayItem == 0
                {
                    break
                }
                else
                {
                    stringData.append(arrayItem)
                }
            }
            
            guard
            
                let string:String = String.init(data:stringData, encoding:String.Encoding.ascii)
            
            else
            {
                print("failed")
                continue
            }
            
            debugPrint(string)
            
            let newOffset:Int = Int(dataTable) + Int(e.dataOffset)
            let endIndex:Int = Int(e.paramLength) + newOffset
            let newSubdata:Data = data.subdata(start:newOffset, endNotIncluding:endIndex)
            
            print("offset:\(newOffset) end:\(endIndex)")
            
            switch e.paramFormat
            {
            case formatUint32:
                
                
                let value:UInt32 = newSubdata.valueFromBytes()!
                
                print("format int: \(value)")
                
                break
                
            default:
                
                let string:String = String.init(data:newSubdata, encoding:String.Encoding.ascii)!
                print("format string")
                debugPrint(string)
                
                break
            }
            
            print("\n")
        }
        
    }
    
    func sessionLoaded()
    {
        parentController?.view.isUserInteractionEnabled = true
    }
    
    let sizeOfEntry:Int = 16
    let formatSystemGenerated:UInt16 = 1024
    let formatString:UInt16 = 1026
    let formatUint32:UInt16 = 1028
}

struct entry
{
    let keyOffset:UInt16
    let paramFormat:UInt16
    let paramLength:UInt32
    let paramMaxLength:UInt32
    let dataOffset:UInt32
    
    static func factoryEntry(data:Data) -> entry
    {
        let keyOffset:UInt16 = data.valueFromBytes()!
        var subData:Data = data.subdata(start:2)
        
        let paramFormat:UInt16 = subData.valueFromBytes()!
        subData = subData.subdata(start:2)
        
        let paramLength:UInt32 = subData.valueFromBytes()!
        subData = subData.subdata(start:4)
        
        let paramMaxLength:UInt32 = subData.valueFromBytes()!
        subData = subData.subdata(start:4)
        
        let dataOffset:UInt32 = subData.valueFromBytes()!
        subData = subData.subdata(start:4)
        
        let e:entry = entry(
            keyOffset:keyOffset,
            paramFormat:paramFormat,
            paramLength:paramLength,
            paramMaxLength:paramMaxLength,
            dataOffset:dataOffset)
        
        return e
    }
}
