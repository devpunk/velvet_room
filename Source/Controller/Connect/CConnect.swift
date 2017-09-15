import Foundation

final class CConnect:Controller<ArchConnect>
{
    //MARK: internal
    
    func startConnection()
    {
        let controller:CConnecting = CConnecting()
        parentController?.push(
            controller:controller,
            vertical:ControllerParent.Vertical.bottom)
    }
}
