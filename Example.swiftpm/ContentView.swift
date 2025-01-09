import SwiftUI

struct ContentView: View {
    let users = ["Alice", "Bob", "Charlie", "David", "Eve"]

    var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    Text(user)
                }
            }
            .navigationTitle("Users")
        }
    }
}

struct UserDetailView: View {
    var user: String

    var body: some View {
        VStack {
            Text("User: \(user)")
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle(user)
        .navigationBarTitleDisplayMode(.inline)
    }
}
