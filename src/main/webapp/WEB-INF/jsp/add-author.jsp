<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Author</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/books">Books</a>
        <a href="/authors">Authors</a>
    </div>
    <div class="container">
        <h2>Add Author</h2>
        <form action="/authors/add" method="POST">
            <label>Name:</label>
            <input type="text" name="name" required>
            
            <label>Nationality:</label>
            <input type="text" name="nationality" required>
            
            <button type="submit">Save</button>
        </form>
    </div>
</body>
</html>
