<%@page import="utils.JSFunction"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String title = request.getParameter("title");
String content = request.getParameter("content");
 
BoardDTO dto = new BoardDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setId(session.getAttribute("UserId").toString());

BoardDAO dao = new BoardDAO(application);
//기존과 같이 게시물 1개를 등록할 때 사용
//int iResult = dao.inserWrite(dto);
//페이징 테스트를 위해 100개의 게시물을 한번에 입력
int iResult = 0;
for(int i=1; i<=100; i++){
	/*
	만약 제목을 "안녕하세로"로 입력했다면
	"..세요1", "..세요2" 와 같이 설정된다.
	*/
	dto.setTitle(title + i);
	iResult = dao.inserWrite(dto);
}
dao.close();

if(iResult ==1){
	//글쓰기에 성공했다면 목록으로 이동한다.
	response.sendRedirect("List.jsp");
}
else{
	//실패했다면 경고창(alert)을 띄우고, 뒤로(history) 이동한다.
	JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>
