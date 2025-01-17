import UIKit
import PhoneNumberKit
import SnapKit
import DesignKit
import JHAuth

enum PhoneNumberStrings: String {
    case title = "Log In"
    case subtitle = "Enter your phone number to \ncontinue"
    case continueButton = "Continue"
}

public final class PhoneNumberViewModel {
    
    let authService: AuthService
    
    public init(authService: AuthService) {
        self.authService = authService
    }
    
    public func requestOTP(with phoneNumber: String) async throws{
        try await authService.requestOTP(forPhoneNumber: phoneNumber)
    }
}

public class PhoneNumberViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var textField: PhoneNumberTextField!
    private weak var continueBtn: UIButton!
    
    public var viewModel: PhoneNumberViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension PhoneNumberViewController {
    private func configureKeyboard() {
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
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let animationCurveRawNumber = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNumber?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        let isKeyboardHidden = endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        let topMargin = isKeyboardHidden ? -40 : -endFrame.height + view.safeAreaInsets.bottom - 20
        
        continueBtn.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(topMargin)
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: animationCurve) {
            self.view.layoutIfNeeded()
        }
    }
}

extension PhoneNumberViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        setupStackView()
        setupIcon()
        setupTitle()
        setupSubtitle()
        setupTextField()
        setupContinueButton()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-14)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.stackView = stackView
    }
    
    private func setupIcon() {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(resource: .logo)
        
        stackView.addArrangedSubview(icon)
        
        stackView.setCustomSpacing(24, after: icon)
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(64)
        }
    }
    
    private func setupTitle() {
        let label = UILabel()
        label.textColor = .black
        label.text = PhoneNumberStrings.title.rawValue
        label.font = .title
        label.textAlignment = .center
        
        stackView.addArrangedSubview(label)
        
        stackView.setCustomSpacing(8, after: label)
    }
    
    private func setupSubtitle() {
        let label = UILabel()
        label.textColor = .subtitleText
        label.text = PhoneNumberStrings.subtitle.rawValue
        label.font = .subtitle
        label.numberOfLines = 0
        label.textAlignment = .center
        
        stackView.addArrangedSubview(label)
        
        stackView.setCustomSpacing(20, after: label)
    }
    
    private func setupTextField() {
        let textFieldBackground = UIView()
        textFieldBackground.backgroundColor = .secondary
        textFieldBackground.layer.cornerRadius = 16
        textFieldBackground.layer.masksToBounds = true
        
        stackView.addArrangedSubview(textFieldBackground)
        
        textFieldBackground.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        let textField = PhoneNumberTextField()
        
        textField.font = .textField
        textField.textColor = .primary
        textField.textAlignment = .left
        textField.withExamplePlaceholder = true
        
        textFieldBackground.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
        
        self.textField = textField
    }
    
    private func setupContinueButton() {
        let button = UIButton()
        button.backgroundColor = .accent
        button.titleLabel?.font = .button
        button.setTitle(PhoneNumberStrings.continueButton.rawValue, for: .normal)
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapContinueBtn), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        
        self.continueBtn = button
    }
}

extension PhoneNumberViewController {
    
    @objc func didTapContinueBtn() {
        
        guard
            textField.isValidNumber,
            let phoneNumber = textField.text else { return }
        
        Task { [weak self] in
            do {
                try await self?.viewModel.requestOTP(with: phoneNumber)
                
                self?.presentOTP()
            } catch {
                self?.showError(error.localizedDescription)
            }
        }
    }

    private func presentOTP() {
        let viewController = OTPViewController()
        viewController.viewModel = OTPViewModel(authService: viewModel.authService)
        viewController.phoneNumber = textField.text ?? ""
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UIViewController {
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}
