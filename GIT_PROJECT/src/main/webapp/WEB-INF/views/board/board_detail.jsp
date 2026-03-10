<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/inc/head.jspf" %>
    <link rel="stylesheet" href="<c:url value='/resources/css/board/board_detail.css'/>" type="text/css">
</head>

<body>
<%@ include file="/WEB-INF/views/inc/header.jspf" %>

<c:url var="urlBoardList" value="/board"/>
<c:url var="urlBoardEdit" value="/board/edit"/>
<c:url var="urlBoardDelete" value="/board/delete"/>
<c:url var="urlBoardDownload" value="/board/download"/>

<main class="container wrap">

    <div class="card">
        <div class="content">

            <!-- 게시글 헤더 -->
            <div class="top-actions">

                <div>
                    <!-- 카테고리 -->
                    <span class="badge-cat">
                        ${post.boardType}
                    </span>

                    <!-- 제목 -->
                    <h2 class="title">
                        ${post.title}
                    </h2>

                    <!-- 메타정보 -->
                    <div class="meta">
                        <span>${post.createdAtText}</span>
                        <span class="dot">·</span>
                        <span>조회 ${post.readcount}</span>
                    </div>
                </div>

                <!-- 작성자 메뉴 -->
                <div class="menu">

                    <c:if test="${isOwner}">

                        <a class="btn-ghost"
                           href="${urlBoardEdit}?postId=${post.postId}">
                            수정
                        </a>

                        <form action="${urlBoardDelete}"
                              method="post"
                              style="margin:0;"
                              onsubmit="return confirm('삭제하시겠습니까?');">

                            <input type="hidden"
                                   name="postId"
                                   value="${post.postId}">

                            <button type="submit"
                                    class="btn-danger-soft">
                                삭제
                            </button>

                        </form>

                    </c:if>

                </div>

            </div>


            <!-- 본문 -->
            <div class="body">
                ${post.content}
            </div>


            <!-- 첨부파일 -->
            <c:if test="${not empty fileList}">
                <div class="file-wrap">

                    <div class="file-title">
                        첨부파일
                    </div>

                    <div class="file-list">

                        <c:forEach var="file" items="${fileList}">

                            <div class="file-item">

                                <a class="file-link"
                                   href="${urlBoardDownload}?fileId=${file.fileId}">
                                    ${file.originName}
                                </a>

                                <span class="file-meta">

                                    <c:if test="${not empty file.fileExt}">
                                        (${file.fileExt})
                                    </c:if>

                                </span>

                            </div>

                        </c:forEach>

                    </div>

                </div>
            </c:if>


            <!-- 하단 버튼 -->
            <div class="bottom-actions">

                <div class="actions-left">

                    <button type="button" class="btn-ghost">
                        좋아요
                    </button>

                    <button type="button" class="btn-ghost">
                        스크랩
                    </button>

                </div>

                <a class="btn-dark"
                   href="${urlBoardList}">
                    목록
                </a>

            </div>


            <!-- 댓글 영역 -->
            <div class="comment-wrap">

                <div class="comment-title">
                    댓글
                </div>


                <!-- 댓글 작성 -->
                <div class="comment-box">

                    <div class="comment-head">
                        <div class="comment-hint">
                            댓글을 작성해보세요
                        </div>
                    </div>

                    <form action="/board/comment/write"
                          method="post">

                        <input type="hidden"
                               name="postId"
                               value="${post.postId}">

                        <textarea name="content"
                                  placeholder="댓글을 입력하세요">
                        </textarea>

                        <div class="comment-actions">

                            <button type="reset"
                                    class="btn-cancel">
                                취소
                            </button>

                            <button type="submit"
                                    class="btn-submit">
                                등록
                            </button>

                        </div>

                    </form>

                </div>


                <!-- 댓글 리스트 -->
                <div class="comment-list">

                    <c:forEach var="cmt" items="${comments}">

                        <div class="comment-item">

                            <div class="comment-meta">
                                <span>${cmt.authorMemberId}</span>
                                <span class="dot">·</span>
                                <span>${cmt.createdAt}</span>
                            </div>

                            <div class="comment-body">
                                ${cmt.content}
                            </div>

                        </div>

                    </c:forEach>

                </div>

            </div>


            <!-- 하단 네비 -->
            <div class="nav-bottom">

                <a class="btn-ghost"
                   href="javascript:window.scrollTo({top:0,behavior:'smooth'});">
                    TOP
                </a>

                <a class="btn-dark"
                   href="${urlBoardList}">
                    목록
                </a>

            </div>


        </div>
    </div>

</main>

<%@ include file="/WEB-INF/views/inc/footer.jspf" %>

</body>
</html>