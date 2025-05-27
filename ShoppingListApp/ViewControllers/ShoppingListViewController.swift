import UIKit

final class ShoppingListViewController: UIViewController {

    private var items: [ShoppingItem] = []
    private let username: String
    private let persistence = PersistenceManager()

    private let tableView = UITableView()
    private let itemField = UITextField()
    private let categoryField = UITextField()
    private let quantityStepper = UIStepper()
    private let addButton = UIButton(type: .system)
    private let filterSegment = UISegmentedControl(items: ["All", "Fruit", "Veg", "Household"])

    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "\(username)'s List"
        setupUI()
        loadData()
    }

    private func setupUI() {
        itemField.placeholder = "Item"
        itemField.borderStyle = .roundedRect
        categoryField.placeholder = "Category"
        categoryField.borderStyle = .roundedRect
        quantityStepper.minimumValue = 1
        quantityStepper.maximumValue = 99
        quantityStepper.value = 1

        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)

        tableView.register(ShoppingItemCell.self, forCellReuseIdentifier: ShoppingItemCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self

        let inputStack = UIStackView(arrangedSubviews: [itemField, categoryField, quantityStepper, addButton])
        inputStack.axis = .horizontal
        inputStack.spacing = 8
        inputStack.distribution = .fillEqually
        inputStack.translatesAutoresizingMaskIntoConstraints = false

        filterSegment.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
        filterSegment.selectedSegmentIndex = 0

        view.addSubview(inputStack)
        view.addSubview(filterSegment)
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        filterSegment.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            inputStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            inputStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            inputStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            filterSegment.topAnchor.constraint(equalTo: inputStack.bottomAnchor, constant: 8),
            filterSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            filterSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),

            tableView.topAnchor.constraint(equalTo: filterSegment.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func addItem() {
        guard let name = itemField.text, !name.isEmpty,
              let category = categoryField.text, !category.isEmpty else { return }
        let newItem = ShoppingItem(name: name, quantity: Int(quantityStepper.value), category: category)
        items.append(newItem)
        persistence.saveItems(items, for: username)
        tableView.reloadData()
        itemField.text = ""
        categoryField.text = ""
    }

    private func loadData() {
        items = persistence.loadItems(for: username)
    }

    @objc private func filterChanged() {
        tableView.reloadData()
    }
}

extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selected = filterSegment.titleForSegment(at: filterSegment.selectedSegmentIndex)
        if selected == "All" { return items.count }
        return items.filter { $0.category.lowercased() == selected?.lowercased() }.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingItemCell.reuseID, for: indexPath) as? ShoppingItemCell else {
            return UITableViewCell()
        }
        let selected = filterSegment.titleForSegment(at: filterSegment.selectedSegmentIndex)
        let filtered = selected == "All" ? items : items.filter { $0.category.lowercased() == selected?.lowercased() }
        cell.configure(with: filtered[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = filterSegment.titleForSegment(at: filterSegment.selectedSegmentIndex)
        let filteredIndexes = selected == "All" ? items.indices : items.indices.filter { items[$0].category.lowercased() == selected?.lowercased() }
        let realIndex = filteredIndexes[indexPath.row]
        items[realIndex].isCompleted.toggle()
        persistence.saveItems(items, for: username)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let selected = filterSegment.titleForSegment(at: filterSegment.selectedSegmentIndex)
        let filteredIndexes = selected == "All" ? items.indices : items.indices.filter { items[$0].category.lowercased() == selected?.lowercased() }
        let realIndex = filteredIndexes[indexPath.row]
        items.remove(at: realIndex)
        persistence.saveItems(items, for: username)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
