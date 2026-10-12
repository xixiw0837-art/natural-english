import UIKit

final class KeyboardViewController: UIInputViewController, UITextViewDelegate {
    private let input = UITextView()
    private let output = UILabel()
    private let status = UILabel()
    private let engine = PhraseTranslator()
    private var tone = 0
    private let tones = ["自然", "友好", "礼貌"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.13, alpha: 1)
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 7
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 310)
        ])

        let header = UILabel()
        header.text = "自然英文  ·  中文 → English"
        header.textColor = .white
        header.font = .boldSystemFont(ofSize: 15)
        stack.addArrangedSubview(header)

        input.backgroundColor = UIColor(white: 0.18, alpha: 1)
        input.textColor = .white
        input.font = .systemFont(ofSize: 16)
        input.layer.cornerRadius = 9
        input.delegate = self
        input.heightAnchor.constraint(equalToConstant: 66).isActive = true
        input.text = ""
        stack.addArrangedSubview(input)

        let toneRow = UIStackView()
        toneRow.distribution = .fillEqually
        toneRow.spacing = 5
        for (index, name) in tones.enumerated() {
            let button = makeButton(name)
            button.tag = index
            button.addTarget(self, action: #selector(changeTone(_:)), for: .touchUpInside)
            toneRow.addArrangedSubview(button)
        }
        stack.addArrangedSubview(toneRow)

        output.numberOfLines = 3
        output.textColor = UIColor(red: 0.79, green: 0.95, blue: 0.48, alpha: 1)
        output.font = .systemFont(ofSize: 15)
        output.text = "输入中文后，点击「转换」"
        output.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        stack.addArrangedSubview(output)

        let actions = UIStackView()
        actions.distribution = .fillEqually
        actions.spacing = 6
        let convert = makeButton("转换")
        convert.addTarget(self, action: #selector(convertText), for: .touchUpInside)
        let insert = makeButton("插入英文")
        insert.addTarget(self, action: #selector(insertText), for: .touchUpInside)
        let delete = makeButton("⌫ 删除")
        delete.addTarget(self, action: #selector(deleteText), for: .touchUpInside)
        for b in [convert, insert, delete] { actions.addArrangedSubview(b) }
        stack.addArrangedSubview(actions)

        let bottom = UIStackView()
        bottom.spacing = 6
        let globe = makeButton("🌐 切换键盘")
        globe.addTarget(self, action: #selector(nextKeyboard), for: .touchUpInside)
        let space = makeButton("空格")
        space.addTarget(self, action: #selector(insertSpace), for: .touchUpInside)
        bottom.addArrangedSubview(globe)
        bottom.addArrangedSubview(space)
        stack.addArrangedSubview(bottom)

        status.textColor = .lightGray
        status.font = .systemFont(ofSize: 11)
        status.numberOfLines = 2
        status.text = "离线短句演示版 · 未匹配的中文不会伪装成翻译"
        stack.addArrangedSubview(status)
    }

    private func makeButton(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(white: 0.24, alpha: 1)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 37).isActive = true
        return button
    }

    func textViewDidChange(_ textView: UITextView) {
        output.text = engine.translate(textView.text, tone: tone) ?? "暂不支持这句话"
    }

    @objc private func changeTone(_ sender: UIButton) {
        tone = sender.tag
        textViewDidChange(input)
    }

    @objc private func convertText() { textViewDidChange(input) }

    @objc private func insertText() {
        guard let result = engine.translate(input.text, tone: tone) else {
            status.text = "没有匹配的离线翻译，请换一句试试"
            return
        }
        textDocumentProxy.insertText(result)
        status.text = "已插入英文"
    }

    @objc private func deleteText() { textDocumentProxy.deleteBackward() }
    @objc private func insertSpace() { textDocumentProxy.insertText(" ") }
    @objc private func nextKeyboard() { advanceToNextInputMode() }
}
