<%@ page import="edu.skku.wpl2021f.board.BoardDAO" %>
<%@ page import="edu.skku.wpl2021f.board.BoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="edu.skku.wpl2021f.card.CardDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="edu.skku.wpl2021f.card.CardDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Main</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>

<body>
<%
    // get posts from each board for preview
    BoardDAO boardDAO = new BoardDAO();
    List<BoardDTO> freeBoardList = boardDAO.getList(1, 1);
    List<BoardDTO> qnaBoardList = boardDAO.getList(1, 2);
    List<BoardDTO> recruitBoardList = boardDAO.getList(1, 3);

    // get additional information at a recruit board post
    CardDAO cardDAO = new CardDAO();
    List<CardDTO> cardList = new ArrayList<>();
    for (BoardDTO boardDTO : recruitBoardList) {
        CardDTO cardDTO = cardDAO.getCard(boardDTO.getBoardID());
        cardList.add(cardDTO);
    }
%>

<div>
    <jsp:include page="nav.jsp" />

    <div class="contents">
        <div class="card mb-3">
            <h5 class="card-header">
                <a class="nav-link" href="board.jsp?pageNumber=1&boardIdentity=3">Recruiting</a>
            </h5>
            <div class="card-body">
                <div class="row">
                    <%
                        // add study information for preview up to 8 elements
                        int cardListLen = cardList.size();
                        if (cardListLen == 0) {
                    %>
                    <div class="col-sm-3 recruit-card">
                        <div class="card">
                            <div class="card-body">
                                There is no recruiting study
                            </div>
                        </div>
                    </div>
                    <%
                        } else {
                            if (cardListLen > 8) cardListLen = 8;

                            for (int i = 0; i < cardListLen; i++) {
                                CardDTO card = cardList.get(i);
                    %>
                    <div class="col-sm-3 recruit-card">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title"><%= card.getCardTitle() %></h5>
                                <p class="card-text"><%= card.getCardContent() %></p>
                                <a href="view.jsp?boardID=<%= card.getBoardID() %>&boardIdentity=3" class="btn btn-primary">Details</a>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="card mb-3">
                    <h5 class="card-header">
                        <a class="nav-link" href="board.jsp?pageNumber=1&boardIdentity=1">Free Board</a>
                    </h5>
                    <ul class="list-group">
                        <%
                            // add free board posts for preview up to 5 elements
                            int freeBoardListLen = freeBoardList.size();
                            if (freeBoardListLen == 0) {
                        %>
                        <li class="list-group-item">
                            <a class="nav-link disabled">There is no post</a>
                        </li>
                        <%
                        } else {
                            if (freeBoardListLen > 5) freeBoardListLen = 5;

                            for (int i = 0; i < freeBoardListLen; i++) {
                                BoardDTO board = freeBoardList.get(i);
                        %>
                        <li class="list-group-item">
                            <a class="nav-link disabled" href="view.jsp?boardID=<%= board.getBoardID()%>&boardIdentity=1"><%= board.getBoardTitle() %></a>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card mb-3">
                    <h5 class="card-header">
                        <a class="nav-link" href="board.jsp?pageNumber=1&boardIdentity=2">Q&A</a>
                    </h5>
                    <ul class="list-group">
                        <%
                            // add QnA board posts for preview up to five elements
                            int qnaBoardListLen = qnaBoardList.size();
                            if (qnaBoardListLen == 0) {
                        %>
                        <li class="list-group-item">
                            <a class="nav-link disabled">There is no post</a>
                        </li>
                        <%
                        } else {
                            if (qnaBoardListLen > 5) qnaBoardListLen = 5;

                            for (int i = 0; i < qnaBoardListLen; i++) {
                                BoardDTO board = qnaBoardList.get(i);
                        %>
                        <li class="list-group-item">
                            <a class="nav-link disabled" href="view.jsp?boardID=<%= board.getBoardID()%>&boardIdentity=2"><%= board.getBoardTitle() %></a>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>