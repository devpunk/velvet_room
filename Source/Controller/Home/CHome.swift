import Foundation

final class CHome:Controller<ArchHome>
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        parentController?.view.isUserInteractionEnabled = false
    }
    
    //MARK: internal
    
    func sessionLoaded()
    {
        parentController?.view.isUserInteractionEnabled = true
    }
}
