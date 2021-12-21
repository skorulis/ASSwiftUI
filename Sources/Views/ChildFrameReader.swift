import SwiftUI

public struct ChildFrameReader<Content: View>: View {
    @Binding var frame: CGRect
    let space: CoordinateSpace
    let content: () -> Content
    
    
    public init(frame: Binding<CGRect>,
                space: CoordinateSpace,
                content: @escaping () -> Content
    ) {
        _frame = frame
        self.space = space
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            content()
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: FramePreferenceKey.self, value: proxy.frame(in: space))
                    }
                )
        }
        .onPreferenceChange(FramePreferenceKey.self) { preferences in
            self.frame = preferences
        }
    }
}

struct FramePreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: Value = .zero

    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}
