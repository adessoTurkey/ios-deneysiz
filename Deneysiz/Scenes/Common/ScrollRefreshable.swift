import SwiftUI

@available(iOS 15.0, *)
struct ScrollRefreshable<Content: View>: View {
    
    var content: Content
    var onRefresh: () async -> Void
    
    init(localizedKey: String? = nil, title: String? = nil, @ViewBuilder content: @escaping () -> Content, onRefresh: @escaping () async -> Void) {
        let attributedTitle: String
        if let title = title {
            attributedTitle = title
        } else if let localizedKey = localizedKey {
            attributedTitle = NSLocalizedString(localizedKey, comment: "")
        } else {
            attributedTitle = ""
        }
        self.content = content()
        self.onRefresh = onRefresh
        // Modifying Refresh Control...
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: attributedTitle)
    }
    
    var body: some View {
        List {
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
    }
}
