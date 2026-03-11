package com.itwillbs.project.board.service;

import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.project.board.dto.BoardCommentDTO;
import com.itwillbs.project.board.mapper.BoardCommentMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardCommentService {

    private final BoardCommentMapper boardCommentMapper;

    public void writeComment(BoardCommentDTO commentDTO) {
        boardCommentMapper.insertComment(commentDTO);
    }

    public List<BoardCommentDTO> getCommentList(Long postId, Long loginUserId) {
        List<BoardCommentDTO> commentList = boardCommentMapper.selectCommentList(postId);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm");

        if (commentList != null) {
            for (BoardCommentDTO comment : commentList) {
                if (comment.getCreatedAt() != null) {
                    comment.setCreatedAtText(comment.getCreatedAt().format(formatter));
                }

                if (loginUserId != null && loginUserId.equals(comment.getAuthorMemberId())) {
                    comment.setOwner(true);
                }
            }
        }

        return commentList;
    }

    public boolean deleteComment(Long commentId, Long loginUserId) {
        BoardCommentDTO comment = boardCommentMapper.selectComment(commentId);

        if (comment == null) return false;
        if (!loginUserId.equals(comment.getAuthorMemberId())) return false;

        return boardCommentMapper.deleteComment(commentId) > 0;
    }
}