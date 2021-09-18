//
//  LoginViewController.swift
//  Weather
//
//  Created by Михаил Чертов on 07.08.2021.
//

import UIKit


class LoginViewController: UIViewController {
    
    //MARK: - Outlet
    
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var passwordTitle: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var logginButton: UIButton! {
        didSet {
            self.logginButton.layer.cornerRadius = 7
        }
    }
    @IBOutlet weak var authButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureEmptyForKeyboard()
        animation()
        tapGestureForAnimation()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        if !checkResult {
            showLoginError()
        }
        return checkResult
    }
    
    //MARK: - Method
    
    private func checkUserData() -> Bool {
        guard let login = loginInput.text,
              let password = passwordInput.text else { return false }
        if login == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    private  func showLoginError() {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Введены не верные данные",
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK",
                                        style: .cancel,
                                        handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    // TapGestureForAnimation
    
    private func tapGestureForAnimation() {
        _ = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
    }
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         dampingRatio: 0.5,
                                                         animations: {
                                                            self.authButton.transform = CGAffineTransform(translationX: 0, y: 150)
                                                         })
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 100
        case .ended:
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.addAnimations {
                self.authButton.transform = .identity
            }
            interactiveAnimator.startAnimation()
        default:
            return
        }
    }
    
    //MARK: - Animation
    
    private func animation() {
        animateTitlesAppearing()
        animateTitleAppearing()
        animateAppearingTextField()
        animateFieldsAppearing()
        animateTransformTextField()
        animateAuthButton()
    }
    
    // Анимация для Логин И Пассворд
    private func animateTitlesAppearing() {
        let offset = view.bounds.width
        loginTitle.transform = CGAffineTransform(translationX: -offset, y: 0)
        passwordTitle.transform = CGAffineTransform(translationX: offset, y: 0)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.loginTitle.transform = .identity
                        self.passwordTitle.transform = .identity
                       },
                       completion: nil)
    }
    
    // Анимация для Лэйбла
    private func animateTitleAppearing() {
        self.titleView.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height/2)
        
        let animator = UIViewPropertyAnimator(duration: 1,
                                              dampingRatio: 0.5) {
            self.titleView.transform = .identity
        }
        animator.startAnimation(afterDelay: 1)
        
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.titleView.transform = .identity
                       },
                       completion: nil)
    }
    
    // Анимация для полей ввода
    private func animateFieldsAppearing() {
        let fadeInAnimate = CABasicAnimation(keyPath: "opacity")
        fadeInAnimate.fromValue = 0
        fadeInAnimate.toValue = 1
        fadeInAnimate.duration = 1
        fadeInAnimate.beginTime = CACurrentMediaTime() + 1
        fadeInAnimate.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimate.fillMode = CAMediaTimingFillMode.backwards
        self.loginInput.layer.add(fadeInAnimate, forKey: nil)
        self.passwordInput.layer.add(fadeInAnimate, forKey: nil)
    }
    
    private func animateAppearingTextField() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 150
        scaleAnimation.mass = 2
        
        let animationsGroup = CAAnimationGroup()
        animationsGroup.duration = 1
        animationsGroup.beginTime = CACurrentMediaTime() + 1
        animationsGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animationsGroup.fillMode = CAMediaTimingFillMode.backwards
        animationsGroup.animations = [fadeInAnimation, scaleAnimation]
        
        self.loginTitle.layer.add(animationsGroup, forKey: nil)
        self.passwordTitle.layer.add(animationsGroup, forKey: nil)
        
    }
    
    private func animateTransformTextField() {
        let offSet = abs(self.loginTitle.frame.midY - self.passwordTitle.frame.midY)
        self.loginTitle.transform = CGAffineTransform(translationX: 0, y: offSet)
        self.passwordTitle.transform = CGAffineTransform(translationX: 0, y: -offSet)
        
        UIView.animateKeyframes(withDuration: 1,
                                delay: 1,
                                options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.5) {
                self.loginTitle.transform = CGAffineTransform(translationX: 150, y: 50)
                self.passwordTitle.transform = CGAffineTransform(translationX: -150, y: -50)
            }
                                    UIView.addKeyframe(withRelativeStartTime: 0.5,
                                                       relativeDuration: 0.5) {
                                        self.loginTitle.transform = .identity
                                        self.passwordTitle.transform = .identity
                                    }
                                }
    }
    
    //Анимация кнопки Входа
    private func animateAuthButton() {
        let animate = CASpringAnimation(keyPath: "transform.scale")
        animate.fromValue = 0
        animate.toValue = 1
        animate.stiffness = 200
        animate.mass = 2
        animate.duration = 2
        animate.beginTime = CACurrentMediaTime() + 1
        animate.fillMode = CAMediaTimingFillMode.backwards
        self.logginButton.layer.add(animate, forKey: nil)
        
    }

    //MARK: - Action
    
    @IBAction func loginButton(_ sender: Any) { }
    
}
