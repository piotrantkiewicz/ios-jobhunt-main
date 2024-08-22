import UIKit
import SnapKit

public final class ProfileEditViewModel {
    
    var selectedImage: UIImage?
    var companyName: String = ""
}

public final class ProfileEditViewController: UIViewController {
    
    enum Row: Int, CaseIterable {
        case profilePicture
        case companyName
        case companyLocation
    }
    
    private weak var tableView: UITableView!
    private weak var saveChangesBtn: UIButton!
    
    let viewModel = ProfileEditViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        setupNavigationTitle()
        setupHideKeyboardGesture()
        subscribeToKeyboard()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileEditPictureCell.self, forCellReuseIdentifier: ProfileEditPictureCell.identifier)
        tableView.register(ProfileTextFieldCell.self, forCellReuseIdentifier: ProfileTextFieldCell.identifier)
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Edit profile"
        titleLabel.font = .title4
        titleLabel.textColor = .primary
        navigationItem.titleView = titleLabel
    }
}

extension ProfileEditViewController {
    private func setupUI() {
        configureNavigationItem()
        setupTableView()
        setupSaveChangesBtn()
    }
    
    private func configureNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        self.tableView = tableView
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
    }
    
    private func setupSaveChangesBtn() {
        let button = UIButton()
        button.titleLabel?.font = .button
        button.backgroundColor = .accent
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.setTitleColor(.white, for: .selected)
        button.setTitle(ProfileEditStrings.saveChangesBtn.rawValue, for: .normal)
        button.addTarget(self, action: #selector(didTapSaveChangesBtn), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        self.saveChangesBtn = button
    }
    
    @objc
    private func didTapSaveChangesBtn() {
        print("didTapSaveChangesBtn")
    }
}

extension ProfileEditViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Row.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch row {
            
        case .profilePicture:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEditPictureCell.identifier, for: indexPath) as? ProfileEditPictureCell else { return UITableViewCell() }
            
            cell.configure(with: viewModel.selectedImage)
            
            cell.didTap = { [weak self] in
                self?.didTapProfilePicture()
            }
            
            return cell
            
        case .companyName:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextFieldCell.identifier, for: indexPath) as? ProfileTextFieldCell else { return UITableViewCell() }
            
            cell.textField.delegate = self
            
            cell.configure(with: .companyName())
            
            return cell
            
        case .companyLocation:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextFieldCell.identifier, for: indexPath) as? ProfileTextFieldCell else { return UITableViewCell() }
            
            cell.textField.delegate = self
            
            cell.configure(with: .companyLocation())
            
            return cell
        }
    }
}

extension ProfileTextFieldCell.Model {
    
    static func companyName(text: String? = nil) -> Self {
        Self(
            placeholder: ProfileEditStrings.companyNamePlaceholder.rawValue,
            header: ProfileEditStrings.companyNameLbl.rawValue,
            text: text
        )
    }
    
    static func companyLocation(text: String? = nil) -> Self {
        Self(
            placeholder: ProfileEditStrings.companyLocationPlaceholder.rawValue,
            header: ProfileEditStrings.companyLocationLbl.rawValue,
            text: text
        )
    }

}

extension ProfileEditViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Row(rawValue: indexPath.row)! {
        case .profilePicture:
            return 156
        case .companyName:
            return 140
        case .companyLocation:
            return 140
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Row(rawValue: indexPath.row) {
        case .profilePicture:
            didTapProfilePicture()
        default:
            break
        }
    }
}

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func didTapProfilePicture() {
        let alert = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { [weak self] _ in
            self?.showImagePicker(with: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            self?.showImagePicker(with: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    private func showImagePicker(with sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            viewModel.selectedImage = selectedImage
            
            tableView.reloadRows(
                at: [
                    IndexPath(row: Row.profilePicture.rawValue, section: 0)
                ],
                with: .automatic
            )
        }
        picker.dismiss(animated: true)
    }
}

extension ProfileEditViewController: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.companyName = textField.text ?? ""
    }
}

extension ProfileEditViewController {
    private func setupHideKeyboardGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func subscribeToKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let isKeyboardHidden = endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        let bottomMargin = isKeyboardHidden ? 0 : -endFrame.height - 16
        
        tableView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(bottomMargin)
        }
        
        saveChangesBtn.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(bottomMargin - 20 + (isKeyboardHidden ? 0 : view.safeAreaInsets.bottom))
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}










