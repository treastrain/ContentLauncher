import SwiftUI

struct LauncherContentView: View {
    var body: some View {
        NavigationView {
            List {
                LabeledContent {
                    Text(.now, style: .time)
                } label: {
                    Text("Server time")
                }
                
                Button {
                    exit(0)
                } label: {
                    Text("Exit app")
                }
            }
            .navigationTitle("Debug Tools")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
