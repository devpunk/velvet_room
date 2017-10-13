import UIKit

class VSaveDataListCell:UICollectionViewCell
{
    private(set) weak var controller:CSaveData?
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.gray
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: internal
    
    func config(controller:CSaveData)
    {
        self.controller = controller
    }
}
