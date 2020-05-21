package com.spring.board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoardList(pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardInsert(boardVo);
	}

	@Override
	public int boardDelete(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		boardVo.setBoardNum(boardNum);
		boardVo.setBoardType(boardType);
		return boardDao.boardDelete(boardVo);
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public List<ComCodeVo> selectCodeList(ComCodeVo comCodeVo)
			throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectCodeList(comCodeVo);
	}

	@Override
	public List<BoardVo> searchList(Map<String, Object> list) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.searchBoardList(list);
	}

	@Override
	public Integer searchBoardCnt(Map<String, Object> list)
			throws Exception {
		// TODO Auto-generated method stub
		return boardDao.searchBoardCnt(list);
	}

	@Override
	public int boardInsertAll(List<BoardVo> boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardInsertAll(boardVo);
	}

	@Override
	public int userLogin(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.userLogin(userVo);
	}

	@Override
	public int userJoin(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.userJoin(userVo);
	}

	@Override
	public UserVo selectUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectUser(userId);
	}

	@Override
	public int idCheck(String userId) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.idCheck(userId);
	}

	@Override
	public List<BoardVo> searchBoardList(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.searchBoardList2(keyword);
	}




	
}
