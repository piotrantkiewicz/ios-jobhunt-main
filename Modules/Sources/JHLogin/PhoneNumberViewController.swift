import UIKit
import PhoneNumberKit
import SnapKit
import DesignKit

enum PhoneNumberStrings: String {
    case title = "Log In"
    case subtitle = "Enter your phone number to \ncontinue"
    case continueButton = "Continue"
}

public class PhoneNumberViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var textField: PhoneNumberTextField!
    private weak var continueBtn: UIButton!
    
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
        stackView.spacing = 24
        
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
    }
    
    private func setupSubtitle() {
        let label = UILabel()
        label.textColor = .subtitleText
        label.text = PhoneNumberStrings.subtitle.rawValue
        label.font = .subtitle
        label.numberOfLines = 0
        label.textAlignment = .center
        
        stackView.addArrangedSubview(label)
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
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(335)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        
        self.continueBtn = button
    }
}

extension PhoneNumberViewController {
    
    @objc func didTapContinue() {
        print("Button tapped")
    }
}
