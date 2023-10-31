<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Employee</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
<%
if (request.getParameter("edit")!= null) {
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	Date date = formatter.parse(request.getParameter("date"));
	int idCompany = Integer.parseInt(request.getParameter("company"));
	Company c = DbRepository.find(Company.class, idCompany);
	Employee e = new Employee(firstName,lastName,email,gender,date,c);
	
	DbRepository.add(Employee.class, e);
}
try{
	ArrayList<Company> company = null;
	try{
		company =(ArrayList<Company>) DbRepository.findAll(Company.class);
	}catch(Exception e){
		response.sendRedirect("error.jsp?msg="+e.getMessage());
	}
	int id = Integer.parseInt(request.getParameter("id"));
	Employee e = DbRepository.find(Employee.class, id);
	%>
	<form method="post">
				<label>Name</label>
				<input name="firstName" type="text">
			
				<label>Last Name</label>
				<input name="lastName" type="text">

				<label>Email</label>
				<input name="email" type="email">

			<label>Sex</label>
			<select name="gender">
				<option value="Male">Male</option>
				<option value="Female">Female</option>
			</select>

				<label>Date Of Birth</label>
				<input name="date" type="date">

			<label>Company</label>
			<select name="company">
			<%
				for(Company c : company){
			%>
			<option value="<%=c.getId()%>"><%=c.getName()%></option>
			<%
				}
			%>
			</select>
			
			<button name="edit" type="submit">Edit</button>
		</form>
	<%
	} catch (Exception e){
		response.sendRedirect("error.jsp?msg="+e.getMessage());
	}
%>


</body>
</html>