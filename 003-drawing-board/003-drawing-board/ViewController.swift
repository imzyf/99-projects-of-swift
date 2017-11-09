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
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(finishSaveAlert(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func finishSaveAlert(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "The image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func clearDrawBoard(_ sender: UIButton) {
        self.board.clearBoard()
    }
    
    @IBAction func changeStrokeColor(_ sender: UIButton) {
        board.pathColor = sender.backgroundColor!
    }
}

