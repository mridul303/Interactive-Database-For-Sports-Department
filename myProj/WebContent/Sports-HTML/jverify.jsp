
<%@page contentType="text/html" pageEncoding="UTF-8"%> 


<!DOCTYPE html> 
<html> 
    <head> 
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
       <title>Accept User Page</title> 
    </head> 
    <body> 
<h2 align="center"> Validating User Name and Password </h2>
 
<%
  
	String str1=request.getParameter("name");
  	String str2=request.getParameter("pass");
 
  	if(str1.equalsIgnoreCase("annan") && str2.equals("1234"))
  	{
    	out.println("<h3>Thankyou, you are VALID</h3>");    
  
	response.sendRedirect("http://localhost:8081/myProj/ManagementSection/index.html");
  	}
  
  
  else
  {
    //out.println("<h3>Sorry, you are INVALID</h3>");
    
    
    response.sendRedirect("Failure.html");
  }
%>
 
  
    </body> 
</html> 