import UIKit

final class CSaveData:Controller<ArchSaveData>
{
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        get
        {
            return UIStatusBarStyle.lightContent
        }
    }
    
    init(item:MHomeSaveDataItem)
    {
        super.init()
        model.item = item
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
