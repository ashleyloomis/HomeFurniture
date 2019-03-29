
import UIKit

class FurnitureDetailViewController: UIViewController {
    
    var furniture: Furniture?
    
    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet weak var furnitureTitleLabel: UILabel!
    @IBOutlet weak var furnitureDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    } //end override func
    
    func updateView() {
        guard let furniture = furniture else {return}
        if let imageData = furniture.imageData,
            let image = UIImage(data: imageData) {
            choosePhotoButton.setTitle("", for: .normal)
            choosePhotoButton.setImage(image, for: .normal)
        } else {
            choosePhotoButton.setTitle("Choose Image", for: .normal)
            choosePhotoButton.setImage(nil, for: .normal)
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    } //end func updateView()
    
    
    
    @IBAction func choosePhotoButtonTapped(_ sender: Any) {
        
        //alert controller to allow user to choose image source
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (_) in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)})
            alertController.addAction(cameraAction)
        } //end UIImagePickerController.isSourceTypeAvailable(.camera)
        
        if UIImagePickerController.isSourceTypeAvailable (.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {(_) in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)})
            alertController.addAction(photoLibraryAction)
        } //end UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        
        present(alertController, animated: true, completion: nil)
    } //end func choosePhotoButtonTapped


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.originalImage] as? UIImage else {return}
        
            furniture.imageData = UIImagePNGRepresentation(image)
        
        dismiss(animated: true) {
            self.updateView()
        } //end dismiss
    } //end func imagePickerController


 
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    } //end func imagePickerControllerDidCancel
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        guard let furniture = furniture else {return}
        var items: [Any] = ["\(furniture.name): \(furniture.description)"]
        if let image = choosePhotoButton.backgroundImage(for: .normal) {
            items.append(image)
        }
        
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    } //end func actionButtonTapped
    
} //end class FurnitureDetailViewController
