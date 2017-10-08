import Foundation

final class CHome:Controller<ArchHome>
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        parentController?.view.isUserInteractionEnabled = false
        model.loadSession()
    }
    
    //MARK: internal
    
    func sessionLoaded()
    {
        parentController?.view.isUserInteractionEnabled = true
        model.loadSaveData()
    }
}
