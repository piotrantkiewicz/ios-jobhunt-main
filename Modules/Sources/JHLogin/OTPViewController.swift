import UIKit
import PhoneNumberKit
import SnapKit
import DesignKit

enum OTPStrings: String {
    case title = "Enter the OTP code"
    case subtitle = "To confirm the account, enter the 6-digit code \nwe sent to "
    case submitButton = "Submit"
    case receiveLabel = "Didn’t get a code?"
    case resendLabel = "Resend code"
}

public class OTPViewController: UIViewController, UITextFieldDelegate {
    
    private weak var stackView: UIStackView!
    private weak var continueBtn: UIButton!
    private var textFields: [UITextField] = []
    
    var phoneNumber: String = ""
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension OTPViewController {
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

extension OTPViewController {
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        setupStackView()
        setupTitle()
        setupSubtitle()
        setupOTPTextFields()
        setupResendCodeLabels()
        setupSubmitButton()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        self.stackView = stackView
    }
    
    private func setupTitle() {
        let label = UILabel()
        label.textColor = .primary
        label.text = OTPStrings.title.rawValue
        label.font = .otpTitle
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupSubtitle() {
        let subtitleText = OTPStrings.subtitle.rawValue
        let fullText = subtitleText + phoneNumber
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let subtitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.subtitle,
            .foregroundColor: UIColor.subtitleText
        ]
        
        let phoneNumberAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.otp,
            .foregroundColor: UIColor.accent
        ]
        
        attributedString.addAttributes(subtitleAttributes, range: NSRange(location: 0, length: subtitleText.count))
        attributedString.addAttributes(phoneNumberAttributes, range: NSRange(location: subtitleText.count, length: phoneNumber.count))
        
        let label = UILabel()
        label.attributedText = attributedString
        label.numberOfLines = 0
        
        stackView.addArrangedSubview(label)
    }
    
    private func setupOTPTextFields() {
        
        var fields = [UITextField]()
        
        let fieldsStackView = UIStackView()
        fieldsStackView.axis = .horizontal
        fieldsStackView.distribution = .equalSpacing
        fieldsStackView.alignment = .center
        
        for index in 0...5 {
            let background = UIView()
            background.backgroundColor = .textField
            background.layer.cornerRadius = 12
            background.layer.masksToBounds = true
            background.layer.borderWidth = 2
            background.layer.borderColor = UIColor.clear.cgColor
            
            let textField = UITextField()
            textField.textAlignment = .center
            textField.textColor = .primary
            textField.tintColor = .accent
            textField.font = .otpTextField
            textField.keyboardType = .numberPad
            textField.delegate = self
            textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
            textField.tag = 100 + index
            
            background.addSubview(textField)
            
            background.snp.makeConstraints { make in
                make.height.equalTo(48)
                make.width.equalTo(48)
            }
            
            textField.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            fieldsStackView.addArrangedSubview(background)
            fields.append(textField)
        }
        
        stackView.addArrangedSubview(fieldsStackView)
        
        stackView.setCustomSpacing(16, after: fieldsStackView)
        
        textFields = fields
    }
    
    private func setupResendCodeLabels() {
        let codeStackView = UIStackView()
        codeStackView.axis = .horizontal
        codeStackView.distribution = .equalSpacing
        
        let receiveLabel = UILabel()
        receiveLabel.text = OTPStrings.receiveLabel.rawValue
        receiveLabel.textColor = .subtitleText
        receiveLabel.font = .subtitle
        
        let resendLabel = UILabel()
        resendLabel.text = OTPStrings.resendLabel.rawValue
        resendLabel.textColor = .accent
        resendLabel.font = .otp
        
        codeStackView.addArrangedSubview(receiveLabel)
        codeStackView.addArrangedSubview(resendLabel)
        
        stackView.addArrangedSubview(codeStackView)
    }
    
    private func setupSubmitButton() {
        let button = UIButton()
        button.backgroundColor = .accent
        button.titleLabel?.font = .button
        button.setTitle(OTPStrings.submitButton.rawValue, for: .normal)
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapSubmitBtn), for: .touchUpInside)
        
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

extension OTPViewController {
    
    @objc func didChangeText(textField: UITextField) {
        let index = textField.tag - 100
        
        let nextIndex = index + 1
        
        guard nextIndex < textFields.count else {
//            didTapContinue()
//            continueBtn.alpha = 1.0
            return
        }
        
        textFields[nextIndex].becomeFirstResponder()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.layer.backgroundColor = UIColor.white.cgColor
        textField.superview?.layer.borderColor = UIColor.accent.cgColor
        textField.superview?.layer.shadowColor = UIColor.dropShadow.cgColor
        textField.superview?.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.superview?.layer.shadowOpacity = 1.0
        textField.superview?.layer.shadowRadius = 4.0
        textField.superview?.layer.masksToBounds = false
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.layer.backgroundColor = UIColor.textField.cgColor
        textField.superview?.layer.borderColor = UIColor.clear.cgColor
        textField.superview?.layer.shadowColor = UIColor.clear.cgColor
    }
    
    @objc func didTapSubmitBtn() {
        
        print("submit button tapped")
    }
}
