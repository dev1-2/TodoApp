import SwiftUI

struct ContentView: View {
    @StateObject private var vm = TodoViewModel()
    @State private var showAdd = false

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.todos) { item in
                    HStack {
                        Button(action: { vm.toggle(item) }) {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(item.isCompleted ? .green : .secondary)
                                .imageScale(.large)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.system(.body, weight: .medium))
                                .strikethrough(item.isCompleted, color: .secondary)
                                .foregroundColor(item.isCompleted ? .secondary : .primary)
                            if let due = item.dueDate {
                                Text(due, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
                .onDelete(perform: vm.remove)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAdd = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddTodoView { title, date in
                    vm.add(title: title, dueDate: date)
                    showAdd = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
