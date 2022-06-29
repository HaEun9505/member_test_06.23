<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- java.sql import -->
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 완료</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");//한글깨짐 방지
		
		//getParameter(form의"name");
		String mid = request.getParameter("memberId");
		String mpw = request.getParameter("memberPw");
		String mname = request.getParameter("memberName");
		String memail = request.getParameter("memberEmail");
		String mphone = request.getParameter("memberPhone");
		String mgender = request.getParameter("memberGender");
		
		String sessionPw = (String)session.getAttribute("pw");
		
		if(sessionPw.equals(mpw)){	//비밀번호가 맞으면 실행(수정)
			//id,pw는 수정x
			String sql = "UPDATE testmember SET name='"+mname+"',email='"+memail+"',phone='"+mphone+"',gender='"+mgender + "' WHERE id = '" + mid + "'";				
			
			//data source 설정
			String driverName="com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/odbo";
			String username = "root";
			String password = "12345";
			
			//Connection 객체 생성
			Connection conn=null;
			Statement stmt=null;
			
			try{
				Class.forName(driverName);	//드라이버 로딩
				//데이터베이스 연동
				conn = DriverManager.getConnection(url, username, password);
				
				//sql을 실행해주는 Statement 객체 생성
				stmt = conn.createStatement();
				
				//SQL 실행 -> 1이 반환되면 성공, 아니면 실패
				int resultCheck = stmt.executeUpdate(sql);
				
				if(resultCheck == 1){
					response.sendRedirect("modifySucess.jsp");
				}else{
					response.sendRedirect("modify.jsp");
				}
				
			}catch(Exception e) {	//Exception: 모든 에러를 찾는 상위 클래스
				e.printStackTrace();
			}finally{	//에러가 있든 없든 무조건 실행
				try{
					if(stmt != null){	//null값이 아니면
						stmt.close();//데이터베이스 닫기
					}
					if(conn != null){
						conn.close();
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}else {	//다르면 다시 수정 페이지로 이동
			System.out.println("회원정보수정단계 실패");
			response.sendRedirect("modify.jsp");
		}
	%>
</body>
</html>