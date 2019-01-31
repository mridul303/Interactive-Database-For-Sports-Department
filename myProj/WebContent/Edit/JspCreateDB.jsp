<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" import="myProj.Simple" %>
<html>
<head>
<title>Create a Database using JSP</title>
</head>
<body>
<%! String dbname; %>

<% 

Simple s  = new Simple();
dbname = s.CreateDatabase();

s.CreateTables();
s.Initialize();
session.setAttribute("dbn", dbname);
%>

</body>
</html>