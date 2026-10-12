import Foundation

struct PhraseTranslator {
    private let dictionary: [String: [String]] = [
        "你好": ["Hey!", "Hey there!", "Hello!"],
        "谢谢": ["Thanks!", "Thank you so much!", "Thank you."],
        "晚安": ["Night!", "Sleep well!", "Good night."],
        "听起来不错": ["Sounds good!", "That sounds great!", "That sounds good to me."],
        "没事不用担心": ["No worries!", "Don't worry about it!", "No problem at all."],
        "我刚看到你的消息": ["Just saw your message.", "Hey, I just saw your message!", "I've just seen your message."],
        "你最近怎么样": ["How've you been?", "How have you been doing?", "How have you been?"],
        "我今天有点忙晚点回复你": ["I'm a bit busy today. I'll text you later.", "A little busy today, but I'll get back to you soon!", "I'm a little busy today. I'll reply later."],
        "有机会我们一起去吧": ["We should go together sometime!", "Let's go together sometime!", "Perhaps we could go together sometime."]
    ]
    func translate(_ text: String, tone: Int) -> String? {
        let key = text.trimmingCharacters(in: .whitespacesAndNewlines)
            .filter { !"，。！？,.!? 　".contains($0) }
        guard let options = dictionary[key] else { return nil }
        return options[max(0, min(tone, options.count - 1))]
    }
}
