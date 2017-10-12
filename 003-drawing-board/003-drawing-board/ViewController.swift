import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var saveImageButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var board: DrawingBoard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveImage(_ sender: UIButton) {
        
        let image = self.board.getImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        let alertController = UIAlertController(title: "保存成功", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        self.board.clearBoard()
    }
    
    @IBAction func clearDrawBoard(_ sender: UIButton) {
        self.board.clearBoard()
    }
    
    @IBAction func changeStrokeColor(_ sender: UIButton) {
        board.pathColor = sender.backgroundColor!
    }
}

