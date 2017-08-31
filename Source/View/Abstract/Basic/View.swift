import UIKit

class View<V:ViewMain, M:Model<V>, C:Controller<V, M>>:UIView
{
    private(set) weak var controller:C!
    
    required init(controller:C)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
