package library.repositories

import java.sql.Connection
import java.sql.DriverManager
import kotlin.collections.*
import library.models.*

class BooksRepository() {
    val connection: Connection = DriverManager.getConnection("jdbc:sqlserver://localhost;databaseName=LibraryEdu;user=sa;password=test123%")

    private val generalQuery: StringBuilder = StringBuilder().append(" select ")
            .append(" b.BookId as book_id, ").append(" b.Title as book_title, ").append(" b.imageUrl, ")
            .append(" a.AuthorId as author_id, ").append(" a.Name as author_name, ")
            .append(" a.Surname as author_surname,  ").append(" p.PositionId as position_id,  ")
            .append(" p.[Description] as [description],  ").append(" pub.PublisherId, ")
            .append(" pub.Name as publisher_name, ").append(" cat.CategoryId, ")
            .append(" cat.Name as category_name ").append(" from Book b ")
            .append(" join Authors_Books ab on b.BookId = ab.BookId ")
            .append(" join Author a on a.AuthorId = ab.AuthorId ")
            .append(" join Position p on p.PositionId = b.PositionId ")
            .append(" join Publisher pub on pub.PublisherId = b.PublisherId ")
            .append(" join Category cat on cat.CategoryId = b.CategoryId")

    fun getBy(title: String?, authorId: String?) : Set<Book> {
        val whereBuilder = mutableListOf<String>()
        if (!title.isNullOrEmpty()) {
            whereBuilder.add(" b.title like '%$title%' ")
        }

        if(!authorId.isNullOrEmpty()) {
            whereBuilder.add(" a.authorId = $authorId ")
        }

        val queryStr = if (whereBuilder.isNotEmpty()) {
            generalQuery.append(" where ").append(whereBuilder.joinToString(" and ", postfix = " ")).toString()
        } else {
            generalQuery.toString()
        }

        connection.createStatement().use {
            it.executeQuery(queryStr).use {
                println("Executed with query: ${queryStr}")
                val books = emptyMap<Int, Book>().toMutableMap()
                while (it.next()) {
                    val bookId = it.getInt("book_id")
                    var b = books.get(bookId);

                    if (b == null) {
                        val image = it.getString("imageUrl") ?: "https://zohodiscussions.com/discussions/getCustomFile.do?fileId=14737000006454738&forumGroupId=14737000000003003";
                        b = Book(
                            bookId, 
                            it.getString("book_title"), 
                            image,
                            Category(it.getInt("categoryid"), it.getString("category_name")),
                            Position(it.getInt("position_id"), it.getString("description")),
                            Publisher(it.getInt("publisherid"), it.getString("publisher_name")), 
                            authors = mutableSetOf())
                        // books.set(bookId, b)

                        books[bookId] = b
                    }

                    b.authors.add(
                        Author(
                            it.getInt("author_id"), 
                            it.getString("author_name"),
                            it.getString("author_surname")));
                }
                return books.values.toSet()
            }
        }
    }
}