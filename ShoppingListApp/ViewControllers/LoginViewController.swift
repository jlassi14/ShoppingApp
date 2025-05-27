import UIKit

final class LoginViewController: UIViewController {

    private let usernameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter username"
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Login"

        let stack = UIStackView(arrangedSubviews: [usernameField, loginButton])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }

    @objc private func handleLogin() {
        guard let username = usernameField.text, !username.isEmpty else { return }
        UserDefaults.standard.set(username, forKey: "loggedUser")

        let vc = ShoppingListViewController(username: username)
        navigationController?.setViewControllers([vc], animated: true)
    }
}
