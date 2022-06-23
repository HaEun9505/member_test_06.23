<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- java.sql import -->
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 확인</title>
</head>
<body>
	<%	
		String id;
		String pw;
	 	String email;
	 	String name;
		String phone;
	 	String gender;
 	
		request.setCharacterEncoding("utf-8");//한글깨짐 방지
		
		String mid = request.getParameter("userId");
		String mpw = request.getParameter("userPw");
		//data source 설정
		String driverName="com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/odbo";
		String username = "root";
		String password = "12345";
		
		Connection conn=null;	//Connection 객체 생성
		Statement stmt=null;	//sql을 실행해주는 Statement 객체 생성
		ResultSet rs = null;	//ResultSet 객체 생성
		
		String sql = "SELECT * FROM testmember WHERE id = '" + mid + "' AND Pw = '" + mpw + "'";
		
		try{
			Class.forName(driverName);	//드라이버 로딩
			//데이터베이스 연동
			conn = DriverManager.getConnection(url, username, password);
			//sql 실행
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);	//SELECT
			
			//System.out.println("rs:" + rs);
			
			//로그인 했는지 체크
			int loginFlag = 0;
			
			while(rs.next()){	//next : 처음 위치 필드명에서 다음 포지션으로 이동(없으면 false)
			 	id = rs.getString("id");
			 	pw = rs.getString("pw");
			 	email = rs.getString("email");
			 	name = rs.getString("name");
			 	phone = rs.getString("phone");
			 	gender = rs.getString("gender");
			 	System.out.println("아이디: " + id);
			 	//세션에 저장(세션 생성)
			 	session.setAttribute("name", name);
			 	session.setAttribute("id", id);
				session.setAttribute("pw", pw);
				loginFlag++;
			}
			if(loginFlag == 0){	//값이 없으면
				response.sendRedirect("login.jsp");	//로그인 페이지로 이동
			}else{
				response.sendRedirect("loginSucess.jsp");	
			}
			
		}catch(Exception e) {	//Exception: 모든 에러를 찾는 상위 클래스
			e.printStackTrace();
		}finally{	//에러가 있든 없든 무조건 실행
			try{
				if(rs != null){	//null값이 아니면
					stmt.close();//데이터베이스 닫기
				}
				if(stmt != null){
					stmt.close();
				}
				if(conn != null){
					conn.close();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
	
</body>
</html>