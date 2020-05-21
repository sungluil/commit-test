package com.spring.board.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
public class NewController {
	
	@Autowired 
	boardService boardService;
	
	final static int pageSize = 10;	
	final static int blockSize = 5;
	
	@RequestMapping("/home.do")
	public String home(@ModelAttribute("pageChange") String pageChange, Model model) {
		
		if(pageChange.equals("")) {
			pageChange = "newitem";
		}
		logger.info("pageChange = "+pageChange);
		model.addAttribute("pageChange", pageChange);
		
		return "home";
	}
	@RequestMapping("/home/bestitem.do")
	public String bestitem() {
		
		return "include/bestitem";
	}
	@RequestMapping("/home/newitem.do")
	public String newitem() {
		
		return "include/newitem";
	}
	@RequestMapping("/home/header.do")
	public String mainHeader() {
		
		return "include/header_this";
	}

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	/**
	 *  게시글 리스트
	 */
	@RequestMapping(value = "/home/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model, ComCodeVo comCodeVo
			 ,@RequestParam(defaultValue = "1")int pageNo, String[] arr)throws Exception{
		
		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();
		Map<String, Object> list = new HashMap<String, Object>();
		Integer totalCnt = boardService.searchBoardCnt(list);
		
		PageVo pageVo = new PageVo(pageNo,pageSize, totalCnt, blockSize);
		list.put("list", arr);
		list.put("pageNo", pageNo);
		
		if(pageVo.getPageNo() == 0) {
			return "redirect:/board/boardList.do?pageNo=1";
		}
		List<BoardVo> boardList = boardService.SelectBoardList(pageVo);
		codeList = boardService.selectCodeList(comCodeVo);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("codeList", codeList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("pageNo", pageNo);
		
		
		return "include/board";
	}
	@RequestMapping("/home/login.do")
	public String login() {
		return "include/login";
	}
	@RequestMapping("/home/join.do")
	public String join(Model model, ComCodeVo comCodeVo) throws Exception {
		model.addAttribute("codeList", boardService.selectCodeList(comCodeVo));
		return "include/join";
	}
	/**
	 * 게시글 검색
	 */
	@RequestMapping(value = "/home/searchTableHome.do",method = RequestMethod.POST)
	public String boardSearch(String[] arr, Model model,ComCodeVo comCodeVo
			,@RequestParam(defaultValue = "1")int pageNo) throws Exception {

		/*===============================================================*/
		Map<String, Object> list = new HashMap<String, Object>();		
		list.put("list", arr);
		list.put("pageNo", pageNo);

		PageVo pageVo = new PageVo(pageNo, pageSize, boardService.searchBoardCnt(list), blockSize);
		list.put("startRow", pageVo.getStartRow());
		list.put("endRow", pageVo.getEndRow());
		List<BoardVo> boardList = boardService.searchList(list);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", boardService.searchBoardCnt(list));
		model.addAttribute("codeList", boardService.selectCodeList(comCodeVo));
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageVo", pageVo);

		return "include/board";
	}
	/**
	 *  검색 기능(기존에 체크박스 검색쿼리를 확장해서 사용)
	 */
	@RequestMapping(value = "/home/searchHomeAction.do", method = RequestMethod.POST)
	public String search(String[] arr,String keyword
			, Model model,@RequestParam(defaultValue = "1")int pageNo
			,ComCodeVo comCodeVo) throws Exception {
	
		Map<String, Object> list = new HashMap<String, Object>();
		list.put("list", arr);
		list.put("pageNo", pageNo);
		list.put("keyword", keyword);
		PageVo pageVo = new PageVo(pageNo, pageSize, boardService.searchBoardCnt(list), blockSize);
		list.put("startRow", pageVo.getStartRow());
		list.put("endRow", pageVo.getEndRow());

		System.out.println(list);
		//List<BoardVo> boardList = boardService.searchBoardList(keyword);
		List<BoardVo> boardList = boardService.searchList(list);
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", boardService.searchBoardCnt(list));
		model.addAttribute("codeList", boardService.selectCodeList(comCodeVo));
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageVo", pageVo);
		
		return "include/board";
	}
	@RequestMapping(value = "/home/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "include/boardView";
	}
	@RequestMapping(value = "/home/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		ComCodeVo codeVo = new ComCodeVo();
		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();
		codeList = boardService.selectCodeList(codeVo);
		model.addAttribute("codeList", codeList);
		return "include/boardWrite";
	}
	/**
	 * 회원가입
	 */
	@RequestMapping(value = "/home/joinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String userJoin(UserVo userVo) throws Exception {
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.userJoin(userVo);

		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("resultCnt = "+resultCnt);
		
		return callbackMsg;
	}
	@RequestMapping(value = "/home/idcheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String idCheck(String userId) throws Exception {
		String result="";

		int cnt = boardService.idCheck(userId);
		
		if(cnt>0) {
			result+=1;			
		} else {
			result+=-1;
		}
		return result;
	}
	/**
	 *  다중 게시글 작성
	 */
	@RequestMapping(value = "/home/boardInsertAll.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardInsertAll(Locale locale,BoardVo boardVo) throws Exception{
		
		String[] boardType = boardVo.getBoardType().split(",");
		String[] boardTitle = boardVo.getBoardTitle().split(",");
		String[] boardComment = boardVo.getBoardComment().split(",");
		
		List<BoardVo> boardlist = new ArrayList<BoardVo>();
		for(int i=0;i<boardType.length;i++) {	
			BoardVo vo = new BoardVo();
			vo.setBoardType(boardType[i]);
			vo.setBoardTitle(boardTitle[i]);
			vo.setBoardComment(boardComment[i]);
			boardlist.add(vo);
		}
		HashMap<String, String> result = new HashMap<String, String>();
		int resultCnt = boardService.boardInsertAll(boardlist);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	/**
	 * 로그인(세션연결)
	 */
	@RequestMapping(value = "/home/loginAction.do", method = RequestMethod.POST)
	public String userLogin(String id, String pw, Model model
			, HttpServletResponse response, HttpSession session) throws Exception {
		UserVo userVo = new UserVo();
		userVo.setUserId(id);
		userVo.setUserPw(pw);
		int cnt = boardService.userLogin(userVo);

		if(cnt == 1) { 
			session.setAttribute("userVo",boardService.selectUser(userVo.getUserId()));
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('환영합니다.'); location.href='boardList.do';</script>");
            out.flush();
		} else {
			model.addAttribute("message", "아이디 또는 비밀번호가 잘못되었습니다.");
			return "include/login";
		}
		return "include/board";
	}
	/**
	 * 로그아웃(세션아웃)
	 */
	@RequestMapping("/home/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home/boardList.do";
	}
	/**
	 * 게시글 삭제
	 */
	@RequestMapping("/home/{boardType}/{boardNum}/boardDelete.do")
	public String boardDelete(@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum, Model model) throws Exception {
		
		boardService.boardDelete(boardType, boardNum);
		
		return "redirect:/home/boardList.do";
	}
	@RequestMapping("/home/{boardType}/{boardNum}/boardUpdate.do")
	public String boardUpdate(@PathVariable("boardType")String boardType
			,@PathVariable("boardNum") int boardNum, Model model, BoardVo boardVo) throws Exception {
		boardVo = boardService.selectBoard(boardType,boardNum);

		model.addAttribute("board", boardVo);
		return "include/boardUpdate";
	}
	/**
	 * 게시글 수정
	 */
	@RequestMapping(value = "/home/{boardType}/{boardNum}/boardUpdateAction.do", method = RequestMethod.POST)
	public String boardUpdateAction(@PathVariable("boardType")String boardType
			,@PathVariable("boardNum") int boardNum, BoardVo boardVo) throws Exception {
		boardService.boardUpdate(boardVo);
		return "redirect:/home/boardList.do";
	}
}
