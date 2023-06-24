import UIKit

class User {
    var name: String
    var libraryCardNo: String
    var borrowedBooks: [Book]

    init(name: String, libraryCardNo: String) {
        self.name = name
        self.libraryCardNo = libraryCardNo
        self.borrowedBooks = []
    }
}

class Book {
    var title: String
    var author: String
    var isAvailable: Bool

    init(title: String, author: String) {
        self.title = title
        self.author = author
        self.isAvailable = true
    }
}

class LendingLibrary {
    var books: [Book]
    var users: [User]

    init(books: [Book], users: [User]) {
        self.books = books
        self.users = users
    }

    // returns true if book is available and false if not
    func checkAvailabilty(of book: Book) -> Bool {
        return book.isAvailable
    }

    // returns true if books were borrowed and false if not
    func borrow(book: Book, from user: User) -> Bool {
        if book.isAvailable, !user.borrowedBooks.contains(book) {
            book.isAvailable = false
            user.borrowedBooks.append(book)
            return true
        }
        return false
    }

    // returns true if books were returned and false if not
    func returnBook(book: Book, to user: User) -> Bool {
        if user.borrowedBooks.contains(book) {
            book.isAvailable = true
            user.borrowedBooks = user.borrowedBooks.filter { $0 != book }
            return true
        }
        return false
    }
}

// test code
let user1 = User(name: "John", libraryCardNo: "123456")
let book1 = Book(title: "Harry Potter", author: "J. K. Rowling")
let book2 = Book(title: "The Hobbit", author: "J. R. R. Tolkien")
let books = [book1, book2]
let users = [user1]
let library = LendingLibrary(books: books, users: users)

print("Book 1 is available: \(library.checkAvailabilty(of: book1))") // true
library.borrow(book: book1, from: user1)
print("Book 1 is available: \(library.checkAvailabilty(of: book1))") // false
library.returnBook(book: book1, to: user1)
print("Book 1 is available: \(library.checkAvailabilty(of: book1))") // true