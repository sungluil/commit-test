package com.spring.board.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.AjaxFile;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;
import com.sun.org.apache.bcel.internal.util.BCELifier;

import jdk.management.resource.internal.TotalResourceContext;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	final static int pageSize = 10;	
	final static int blockSize = 5;

	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model, ComCodeVo comCodeVo
			 ,@RequestParam(defaultValue = "1")int pageNo, String[] arr)throws Exception{
		/*
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
		*/
		//여기도 검색의쿼리로 동일하게 리스트를 뿌리도록 실행 중복되는 쿼리 x 없애기
		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();
		
		Map<String, Object> list = new HashMap<String, Object>();
		list.put("list", arr);
		list.put("pageNo", pageNo);
		PageVo pageVo = new PageVo(pageNo, pageSize, boardService.searchBoardCnt(list), blockSize);
		list.put("startRow", pageVo.getStartRow());
		list.put("endRow", pageVo.getEndRow());
		List<BoardVo> boardList = boardService.searchList(list);
		
		JSONObject listObj = new JSONObject();
		JSONArray listArray = new JSONArray();
		
		
		for(int i = 0 ; i < boardList.size() ; i++) {
            JSONObject vo = new JSONObject();            
            vo.put("boardType",boardList.get(i).getBoardType());
            vo.put("boardNum",boardList.get(i).getBoardNum());
            vo.put("boardTitle",boardList.get(i).getBoardTitle());
            vo.put("boardComment",boardList.get(i).getBoardComment());
            listArray.add(i,vo);
        }		
        listObj.put("BoardVO",listArray);
        model.addAttribute("list",listObj);
        model.addAttribute("list2",boardService.searchList(list));
        System.out.println("=========================================");
        System.out.println(boardList);
        System.out.println("=========================================");
		
		
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("codeList", boardService.selectCodeList(comCodeVo));
		model.addAttribute("totalCnt", boardService.searchBoardCnt(list));
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("pageNo", pageNo);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	/**
	 * 게시글 작성 뷰페이지
	 */
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		ComCodeVo codeVo = new ComCodeVo();
		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();
		codeList = boardService.selectCodeList(codeVo);
		model.addAttribute("codeList", codeList);
		return "board/boardWrite";
	}
	/**
	 * 게시글 작성
	 */
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);

		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	/**
	 * 게시글 삭제
	 */
	@RequestMapping("/board/{boardType}/{boardNum}/boardDelete.do")
	public String boardDelete(@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum, Model model) throws Exception {
		
		boardService.boardDelete(boardType, boardNum);
		
		return "redirect:/board/boardList.do";
	}
	@RequestMapping("/board/{boardType}/{boardNum}/boardUpdate.do")
	public String boardUpdate(@PathVariable("boardType")String boardType
			,@PathVariable("boardNum") int boardNum, Model model, BoardVo boardVo) throws Exception {
		boardVo = boardService.selectBoard(boardType,boardNum);

		model.addAttribute("board", boardVo);
		return "board/boardUpdate";
	}
	/**
	 * 게시글 수정
	 */
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdateAction.do", method = RequestMethod.POST)
	public String boardUpdateAction(@PathVariable("boardType")String boardType
			,@PathVariable("boardNum") int boardNum, BoardVo boardVo) throws Exception {
		boardService.boardUpdate(boardVo);
		return "redirect:/board/boardList.do";
	}
	/**
	 * 게시글 검색
	 */
	@RequestMapping(value = "/board/searchTable.do",method = RequestMethod.POST)
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

		
		return "board/boardList";
	}
	/**
	 *  다중 게시글 작성
	 */
	@RequestMapping(value = "/board/boardInsertAll.do", method = RequestMethod.POST)
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
	@RequestMapping("/board/login.do")
	public String login() {
		return "board/login";
	}
	@RequestMapping("/board/join.do")
	public String join(Model model, ComCodeVo comCodeVo) throws Exception {
		model.addAttribute("codeList", boardService.selectCodeList(comCodeVo));
		return "board/join";
	}
	/**
	 * 로그인(세션연결)
	 */
	@RequestMapping(value = "/board/loginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public int userLogin(String id, String pw, Model model
			, HttpServletResponse response, HttpSession session
			,String idSave,String loginKeep,HttpServletRequest request) throws Exception {
		UserVo userVo = new UserVo();
		userVo.setUserId(id);
		userVo.setUserPw(pw);

		logger.info("idSave = "+idSave);
		logger.info("loginKeep = "+loginKeep);
		
		int cnt = boardService.userLogin(userVo);
		
		if(cnt == 1) { 
			session.setAttribute("userVo",boardService.selectUser(userVo.getUserId()));
			if(idSave.equals("Y")) {
				Cookie cookie = new Cookie("userCookie", session.getId());
				cookie.setMaxAge(60*60*24*7);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
//			response.setContentType("text/html; charset=UTF-8");
//            PrintWriter out = response.getWriter();
//            out.println("<script>alert('환영합니다.'); location.href='boardList.do';</script>");
//            out.flush();
		} else {
			model.addAttribute("message", "아이디 또는 비밀번호가 잘못되었습니다.");
			//return "board/login";
		}
		return cnt;
	}
	/**
	 * 로그아웃(세션아웃)
	 */
	@RequestMapping("/board/logout.do")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		Cookie loginCookie = WebUtils.getCookie(request,"userCookie");
		if(loginCookie!=null) {
        	loginCookie.setMaxAge(0);
        	loginCookie.setPath("/");
        	response.addCookie(loginCookie);
		}
		session.invalidate();
		return "redirect:/board/boardList.do";
	}
	
	/**
	 * 회원가입
	 */
	@RequestMapping(value = "/board/joinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String userJoin(UserVo userVo) throws Exception {
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
//		String hashedPw = BCrypt.hashpw(userVo.getUserPw(), BCrypt.gensalt());
//		logger.info("패스워드"+userVo.getUserPw());
//		userVo.setUserId(hashedPw);
		int resultCnt = boardService.userJoin(userVo);

		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("resultCnt = "+resultCnt);
		
		return callbackMsg;
	}
	/**
	 * 아이디 세션
	 */
	@RequestMapping(value = "/board/boardList.do")
	@ResponseBody
	public String memberLoginAction(@ModelAttribute UserVo userVo
			, Model model, HttpSession session) throws Exception {
		session.setAttribute("userVo", boardService.selectUser(userVo.getUserId()));
		return "redirect:/board/boardList.do";
	}
	@RequestMapping(value = "/board/idcheck.do", method = RequestMethod.POST)
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
	@RequestMapping(value = "/board/fileUpload.do")
	public String fileUpload() {
		
		return "board/fileUpload";
	}
	@RequestMapping(value="/board/fileAction.do", method=RequestMethod.POST)
    @ResponseBody
    public Object file(AjaxFile file) {
        List<MultipartFile> list = file.getImages();
        ArrayList<String> fileNameList = new ArrayList<String>();
        for(MultipartFile mf : list) {
            fileNameList.add(mf.getOriginalFilename()+", 용량:"+(Math.round((mf.getSize() / 1024) * 10) / 100.0)+"KB");
        }
        System.out.println(fileNameList);
        return fileNameList;
    }
	/**
	 * 파일 업로드
	 */
	@RequestMapping(value = "/board/fileUpload.do", method = RequestMethod.POST)
	public String Fileupload(MultipartFile file, MultipartHttpServletRequest request
			, Model model) throws Exception{
		

		String uploadPath = "d:\\uploadImage";//경로
		String saveName = file.getOriginalFilename();//원본파일이름
		File target = new File(uploadPath, saveName);//파일생성 file(경로,원본이름)
		
		//임시디렉토리에 저장된 파일을 지정된 위치로복사
		FileCopyUtils.copy(file.getBytes(), target);
		
		model.addAttribute("saveName", saveName);
		model.addAttribute("name", request.getParameter("name"));
		model.addAttribute("title", request.getParameter("title"));
		model.addAttribute("content", request.getParameter("content"));
		
		return "board/fileResult";
	}
	/**
	 *  검색 기능(기존에 체크박스 검색쿼리를 확장해서 사용)
	 */
	@RequestMapping(value = "/board/searchAction.do", method = RequestMethod.POST)
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
		return "board/boardList";
	}
	
	//ajax 테스트
	@ResponseBody
	@RequestMapping(value = "/board/ajaxTest.do", method = RequestMethod.POST)
	public String testAjax(String idbtn, String pwbtn) {
		System.out.println("아이디 = "+idbtn+", 비번 = "+pwbtn);
		String result="1";
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.POST, headers="Accept=application/json")
	public List<BoardVo> testListAll(String[] arr,String keyword
			, Model model,@RequestParam(defaultValue = "1")int pageNo
			,ComCodeVo comCodeVo) throws Exception {
		logger.info("show all list......................................");
		
		Map<String, Object> list = new HashMap<String, Object>();
		list.put("list", arr);
		list.put("pageNo", pageNo);
		list.put("keyword", keyword);
		PageVo pageVo = new PageVo(pageNo, pageSize, boardService.searchBoardCnt(list), blockSize);
		list.put("startRow", pageVo.getStartRow());
		list.put("endRow", pageVo.getEndRow());
		
		List<BoardVo> boadVo = boardService.searchList(list);
		JSONObject listObj = new JSONObject();
		JSONArray listArray = new JSONArray();
		
		for(int i = 0 ; i < boadVo.size() ; i++) {

            JSONObject vo = new JSONObject();

            vo.put("boardId",boadVo.get(i).getBoardNum());
            vo.put("boardTitle",boadVo.get(i).getBoardTitle());
            vo.put("boardWriter",boadVo.get(i).getBoardComment());
            vo.put("boardViewcnt",boadVo.get(i).getBoardType());
            listArray.add(i,vo);
        }
		
        listObj.put("BoardVO",list);
        model.addAttribute("list",listObj);
        
        return boardService.searchList(list);
	}
	
	
	
	
}
