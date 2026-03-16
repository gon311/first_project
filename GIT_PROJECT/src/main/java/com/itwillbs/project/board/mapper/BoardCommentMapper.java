package com.itwillbs.project.board.mapper;

import java.util.List;

import com.itwillbs.project.board.dto.BoardCommentDTO;

public interface BoardCommentMapper {

    int insertComment(BoardCommentDTO commentDTO);

    List<BoardCommentDTO> selectCommentList(Long postId);

    BoardCommentDTO selectComment(Long commentId);

    int deleteComment(Long commentId);
    
    int deleteCommentsByPostId(Long postId); // 댓글 삭제
}