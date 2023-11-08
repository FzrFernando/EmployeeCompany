<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.EmployeeProject"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="java.util.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Time Job</title>
</head>
<body>
<% 
	if(session.getAttribute("login")==null){
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesión");
		return;
	}

	Employee emp = (Employee) session.getAttribute("login");
	ArrayList <CompanyProject> listProject = new ArrayList<CompanyProject> ();
	
	listProject = (ArrayList<CompanyProject>) DbRepository.findAll(CompanyProject.class);
%>

<form>
	<select>
	<%for (CompanyProject cp : listProject) {
		if(cp.getCompany().getId() == emp.getCompany().getId()){
			%>
			<option value="<%=cp.getProject().getId()%>"><%=cp.getProject().getName()%></option>
			<%
		}
		%>
		<% 
	}
	%>
	</select>
	<label>Tiempo trabajado</label>
	<input type="text" name="time" id="time" readonly="readonly">
</form>

</body>
</html>