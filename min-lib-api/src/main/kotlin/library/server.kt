package library

import library.models.*
import library.repositories.*
import spark.Spark.*
import com.google.gson.Gson
import com.microsoft.sqlserver.jdbc.*

fun enableCORS(origin: String, methods: String, headers:String) {
    options("/*") {
        request, response ->

        val accessControlRequestHeaders = request.headers("Access-Control-Request-Headers")
        if (accessControlRequestHeaders != null) {
            response.header("Access-Control-Allow-Headers", accessControlRequestHeaders)
        }

        val accessControlRequestMethod = request.headers("Access-Control-Request-Method")
        if (accessControlRequestMethod != null) {
            response.header("Access-Control-Allow-Methods", accessControlRequestMethod)
        }

        "OK"
    }

    before("/*") { _, response ->
        response.header("Access-Control-Allow-Origin", origin)
        response.header("Access-Control-Request-Method", methods)
        response.header("Access-Control-Allow-Headers", headers)
        // Note: this may or may not be necessary in your particular application
        response.type("application/json")
    }
}

fun main(args: Array<String>) {
    val gson = Gson()

    enableCORS("http://localhost:8080", "GET, POST, PUT, DELETE", "*/*" )

    get("/hello") { req, res -> "Hello World" }
    
    get("/books", "application/json", {
        req, res ->
            val title = req.queryParams("title")
            val authorId = req.queryParams("authorId")
            BooksRepository().getBy(title, authorId)
    }, gson::toJson)
}