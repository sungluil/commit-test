package com.spring.board.service;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;
	
	public List<BoardVo> searchBoardList(String keyword) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardDelete(String boardType, int boardNum) throws Exception;

	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public List<ComCodeVo> selectCodeList(ComCodeVo comCodeVo) throws Exception;
	
	public List<BoardVo> searchList(Map<String, Object> list) throws Exception;
	
	public Integer searchBoardCnt(Map<String, Object> list) throws Exception;

	public int boardInsertAll(List<BoardVo> boardVo) throws Exception;
	
	public int userLogin(UserVo userVo) throws Exception;
	
	public int userJoin(UserVo userVo) throws Exception;
	
	public UserVo selectUser(String userId) throws Exception;
	
	public int idCheck(String userId) throws Exception;


}
