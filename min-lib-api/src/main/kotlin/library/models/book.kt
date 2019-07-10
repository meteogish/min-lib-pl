package library.models

data class Book(
    val id: Int, 
    val title: String, 
    val imageUrl: String?,
    val category: Category,
    val position: Position,
    val publisher: Publisher,
    var authors: MutableSet<Author>)