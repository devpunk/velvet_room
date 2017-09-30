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
    }
    
    //MARK: internal
    
    func sessionLoaded()
    {
        parentController?.view.isUserInteractionEnabled = true
    }
}
