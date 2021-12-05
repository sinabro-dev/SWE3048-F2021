<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="edu.skku.wpl2021f.board.BoardDAO" %>
<%@ page import="edu.skku.wpl2021f.board.BoardDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<title>Study Group</title>
</head>
<body>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Sign in to see the post!');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	int boardID = 0;
	if (request.getParameter("boardID") != null) {
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}
	BoardDTO board = new BoardDAO().getBoard(boardID);
%>

<!-- navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="board.jsp"><b>Study Group</b></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              My Page
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
<%
	if (userID == null) {
%>
              <a class="dropdown-item" href="join.jsp">Sign up</a>
              <a class="dropdown-item" href="login.jsp">Sign in</a>
<%
	}
	else {
%>
              <a class="dropdown-item" href="logoutAction.jsp">Sign out</a>
<%
	}
%>
            </div>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="#">Community<span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Q&A</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Front-End
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="#">HTML</a>
              <a class="dropdown-item" href="#">CSS</a>
              <a class="dropdown-item" href="#">JavaScript</a>
              <a class="dropdown-item" href="#">JQuery</a>
            </div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Back-End
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="#">PHP</a>
              <a class="dropdown-item" href="#">JSP</a>
              <a class="dropdown-item" href="#">Node.js</a>
              <a class="dropdown-item" href="#">MySQL</a>
            </div>
          </li>
         </ul>
      </div>
    </nav>

    <!-- content -->
    <section class="container">      
      <div class="mt-5 mb-5">
      	<table class="table" style="text-align:center;">
      		<thead>
      			<tr>
      				<th colspan="3" style="text-align:center; font-size:20px;"><%= board.getBoardTitle() %></th>
      			</tr>
      		</thead>
      		<tbody>
      			<tr>
      				<td><b>Author</b></td>
      				<td colspan="2"><%= board.getUserNickname() %></td>
      			</tr>
      			<tr>
      				<td><b>Date</b></td>
      				<td colspan="2"><%= board.getBoardDate() %></td>
      			</tr>
      			<tr>
      				<td rowspan="3"><b>Content</b></td>
      				<tr>
      					<td class="card" colspan="2" style="text-align:left;">
      						<h5 class="card-title">Card title</h5>
    						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
      					</td>
      				</tr>
      				<tr>
      					<td colspan="2" style="min-height:200px; text-align:left;"><%= board.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
      				</tr>
      			</tr>
      		</tbody>
      	</table>
      	<a href="board.jsp" class="btn btn-success">List</a>
<%
	if (userID != null && userID.equals(board.getUserID())) {
%>
		<a href="update.jsp?boardID=<%= boardID %>" class="btn btn-success">Update</a>
		<a onclick="return confirm('Are you sure you want to delete?')" href="deleteAction.jsp?boardID=<%= boardID %>" class="btn btn-success">Delete</a>
<%
	}
%>
      </div>
    </section>
    
    <!-- comment -->
    <div class="container mb-5">
		<div class="card card-header">
	        <i class="fa fa-comment">Comment</i>
		</div>
		<div class="card card-body mb-5">
			<ul class="list-group list-group-flush">
			    <li class="list-group-item">
					<textarea class="form-control" id="comment" rows="3" placeholder="Leave a comment"></textarea>
					<button type="button" class="btn btn-primary mt-3" onClick="javascript:addReply();">Post</button>
			    </li>
			</ul>
		</div>
		
		<div class="card card-header bg-light">
			<table>
				<tr>
					<td><font size="4"><%= userID %></font></td>
				</tr>
				<tr>
					<td><font size="2"><%= board.getBoardDate() %></font></td>
				</tr>
			</table>
	    </div>
	    <div class="card card-body mb-2">
			<p class="card-text">ㅇㅇㅇ</p>
		</div>
		<div class="card card-header bg-light">
			<table>
				<tr>
					<td><font size="4"><%= userID %></font></td>
				</tr>
				<tr>
					<td><font size="2"><%= board.getBoardDate() %></font></td>
				</tr>
			</table>
	    </div>
	    <div class="card card-body mb-2">
			<p class="card-text">ㅇㅇㅇ</p>
		</div>
	</div>

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>