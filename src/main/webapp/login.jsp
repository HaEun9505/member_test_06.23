<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 로그인</title>
</head>
<body>
	<form action="loginOk.jsp">
		아이디 : <input type="text" name="userId"><br><br>
		비밀번호 : <input type="password" name="userPw"><br><br>
		<input type="submit" value="로그인">
		<input type="button" value="회원가입" onclick="location.href='join.jsp'">
	
	</form>
</body>
</html>