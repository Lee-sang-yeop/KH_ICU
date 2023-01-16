package com.kh.icu.chat.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.kh.icu.board.model.vo.Board;
import com.kh.icu.board.model.vo.PageInfo;
import com.kh.icu.chat.model.dao.BoardDao;
import com.kh.icu.common.template.Pagination;

@Service
public class BoardServiceImpl implements BoardService{
	
	private BoardDao boardDao;
	private SqlSession sqlSession;
	private Pagination pagination;
	
	public BoardServiceImpl(BoardDao boardDao, SqlSession sqlSession, Pagination pagination) {
		this.boardDao = boardDao;
		this.sqlSession = sqlSession;
		this.pagination = pagination;
	}

	@Override
	public int selectListCount() {
		return boardDao.selectListCount(sqlSession);
	}
	
	@Override
	public Map<String, Object> selectList(int currentPage){
		Map<String, Object> map = new HashMap();
		
		// 1. 페이징처리
		int listCount = selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
					
		PageInfo pi = pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		map.put("pi", pi);
		
		ArrayList<Board> list = boardDao.selectList(sqlSession, pi);
		map.put("list", list);
		
		return map;
	}
	
	@Override
	public int selectSearchListCount(Map<String,Object> paramMap) {
		return boardDao.selectSearchListCount(sqlSession, paramMap);
	}
	@Override
	public Map<String, Object> searchSelectList(Map<String, Object> paramMap){
		
		Map<String, Object> map = new HashMap();
		
		//1. 페이징 처리
		int listCount = selectSearchListCount(paramMap);
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = pagination.getPageInfo(listCount, (Integer)paramMap.get("cpage"), pageLimit, boardLimit);
		paramMap.put("pi", pi);
		
		map.put("pi", pi);
		
		ArrayList<Board> list = boardDao.searchSelectList(sqlSession, paramMap);
		map.put("list", list);
		
		return map;
	}
	
	
	
	
}