import UIKit

extension ViewParent:UIGestureRecognizerDelegate
{
    //MARK: selectors
    
    func actionPanRecognized(sender panGesture:UIPanGestureRecognizer)
    {
        let location:CGPoint = panGesture.location(in:self)
        let xPos:CGFloat = location.x
        
        switch panGesture.state
        {
        case UIGestureRecognizerState.began,
             UIGestureRecognizerState.possible:
            
            if xPos < kMaxXPanning
            {
                self.panningX = xPos
            }
            
            break
            
        case UIGestureRecognizerState.changed:
            
            if let panningX:CGFloat = self.panningX
            {
                var deltaX:CGFloat = xPos - panningX
                
                if deltaX > kMaxXDelta
                {
                    panRecognizer.isEnabled = false
                }
                else
                {
                    if deltaX < 0
                    {
                        deltaX = 0
                    }
                    
                    guard
                        
                        let topView:ViewMain = subviews.last as? ViewMain
                        
                        else
                    {
                        return
                    }
                    
                    topView.layoutLeft.constant = deltaX
                }
            }
            
            break
            
        case UIGestureRecognizerState.cancelled,
             UIGestureRecognizerState.ended,
             UIGestureRecognizerState.failed:
            
            if let panningX:CGFloat = self.panningX
            {
                let deltaX:CGFloat = xPos - panningX
                
                if deltaX > kMinXDelta
                {
                    gesturePop()
                }
                else
                {
                    gestureRestore()
                }
            }
            
            panningX = nil
            
            break
        }
    }
    
    //MARK: private
    
    private func gesturePop()
    {
        panRecognizer.isEnabled = true
        controller.pop(horizontal:ControllerParent.Horizontal.right)
    }
    
    private func gestureRestore()
    {
        panRecognizer.isEnabled = true
        
        guard
            
            let topView:ViewProtocol = subviews.last as? ViewProtocol
            
        else
        {
            return
        }
        
        topView.layoutLeft.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration)
        {
            self.layoutIfNeeded()
        }
    }
    
    //MARK: internal
    
    func factoryGesture()
    {
        let panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(
            target:self,
            action:#selector(actionPanRecognized(sender:)))
        panRecognizer.delegate = self
        self.panRecognizer = panRecognizer
        
        addGestureRecognizer(panRecognizer)
    }
    
    //MARK: gestureRecognizerDelegate
    
    override func gestureRecognizerShouldBegin(
        _ gestureRecognizer:UIGestureRecognizer) -> Bool
    {
        guard
            
            let view:ViewProtocol = subviews.last as? ViewProtocol
            
        else
        {
            return false
        }
        
        let panBack:Bool = view.panBack
        
        return panBack
    }
}
