<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Information</title>


</head>
<body>

	<%
        try{
		String b=request.getParameter("choice");
		out.println(b);
		switch(b)
		{
		case "2": response.sendRedirect("temp1.html");								
						break;
						
		case "1":response.sendRedirect("temp2.html");								
						break;
		default : break;
		}
        }
		catch (Exception e){
			out.println("falil");	
		}
	
	%>
</body>
</html>