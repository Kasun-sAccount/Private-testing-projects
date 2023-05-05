<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="lk.ijse.dep10.todo.model.Task" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%!
    private ArrayList<Task> toArrayList(ResultSet rst){
        ArrayList<Task> arrayList = new ArrayList<>();
        try {

            while (rst.next()) {
                int id = rst.getInt("id");
                String description = rst.getString("description");
                String status = rst.getString("status");
                arrayList.add(new Task(id, description, Task.Status.valueOf(status)));

            }

            return arrayList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
%>

<%
BasicDataSource dbcp = (BasicDataSource)application.getAttribute("dbcp");
try(Connection connection = dbcp.getConnection()){
    Statement statement = connection.createStatement();
    ResultSet resultSet1 = statement.executeQuery("Select * from Task where status='COMPLETED'");
    ArrayList<Task> completed = toArrayList(resultSet1);
    request.setAttribute("completed1",completed);
    ResultSet resultSet2 = statement.executeQuery("Select * from Task where status='NOT_COMPLETED'");
    ArrayList<Task> notCompleted = toArrayList(resultSet2);
    request.setAttribute("notCompleted1",notCompleted);

}catch (SQLException e){
    throw new SQLException(e);
}

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>MY NEW APPLICATION</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="stylesheet" href="css/style.css">

</head>
<body>
.

<header>
<h1><span class="material-symbols-outlined">
task_alt
</span>TO DO LIST</h1>
<form action="">
    <input type="text">
    <button>ADD</button>
</form>
</header>
<main>

    <c:if test="${ empty completed1 and empty notCompleted1}">
    <label>Add data to save</label>
    </c:if>
    <c:forEach var="cTask" items="${completed1}">
    <section id="Not_Completed">
        <a href="#">
            <lable><input type="checkbox">${cTask.description}</lable>
        </a>
        <a href="#"><span title="delete" class="material-symbols-outlined">
delete_forever
</span></a>
    </section>
    </c:forEach>
    <c:forEach var="nTask" items="${notCompleted1}">
    <section id="Completed">
        <a href="#">
            <lable><input type="checkbox">${nTask.description}</lable>
        </a>
        <a href="#"><span title="delete" class="material-symbols-outlined">
delete_forever
</span></a>
    </section>
    </c:forEach>

</main>

<footer>All Right Reserved</footer>

</body>
</html>