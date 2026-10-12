import SwiftUI

@main
struct NaturalEnglishApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "keyboard")
                .font(.system(size: 48))
                .foregroundStyle(.green)
            Text("LinguaKey")
                .font(.largeTitle.bold())
            Text("中英聊天输入法 · 测试版")
                .font(.headline)
            Text("安装后，请到 设置 → 通用 → 键盘 → 键盘 → 添加新键盘，启用 LinguaKey。")
                .multilineTextAlignment(.center)
            Text("当前版本仅支持少量离线短句，不会将输入内容上传网络。")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(25)
    }
}
