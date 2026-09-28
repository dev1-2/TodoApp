import SwiftUI

struct AddTodoView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var hasDue: Bool = false
    @State private var dueDate: Date = Date()

    var onSave: (String, Date?) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Was möchtest du tun?", text: $title)
                }

                Section {
                    Toggle("Mit Erinnerung planen", isOn: $hasDue)
                    if hasDue {
                        DatePicker("Datum", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                    }
                }
            }
            .navigationTitle("Neue Aufgabe")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { presentationMode.wrappedValue.dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        let date = hasDue ? dueDate : nil
                        onSave(title.trimmingCharacters(in: .whitespacesAndNewlines), date)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView { _, _ in }
    }
}
