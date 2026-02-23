package com.itwillbs.project.review.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project.review.dto.CoverLetterDTO;
import com.itwillbs.project.review.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService{
	@Autowired
	private ReviewMapper reviewMapper;

	public void registForm(CoverLetterDTO coverLetterDTO) {
		reviewMapper.insertForm(coverLetterDTO);
	}


}
