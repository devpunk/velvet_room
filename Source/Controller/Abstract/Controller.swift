import UIKit

class Controller<V:ViewMain, M:Model<V>>:UIViewController
{
    let model:M
    
    var parentController:ControllerParent?
    {
        get
        {
            guard
                
                let parent:ControllerParent = self.parent as? ControllerParent
                
            else
            {
                return nil
            }
            
            return parent
        }
    }
    
    init()
    {
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var shouldAutorotate:Bool
    {
        get
        {
            return true
        }
    }
    
    override func loadView()
    {
        let view:V = V(controller:self)
        model.view = view
        self.view = view
    }
    
    override func viewWillAppear(_ animated:Bool)
    {
        super.viewWillAppear(animated)
        
        parent?.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return UIStatusBarStyle.default
    }
    
    override var prefersStatusBarHidden:Bool
    {
        return false
    }
}
