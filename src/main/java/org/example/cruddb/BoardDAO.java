package org.example.cruddb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    private final String BOARD_INSERT = "insert into BOARD (name, author, date) values (?, ?, ?)";
    private final String BOARD_UPDATE = "update BOARD set name=?, author=?, date=? where seq=?";
    private final String BOARD_DELETE = "delete from BOARD where seq=?";
    private final String BOARD_GET = "select * from BOARD where seq=?";
    private final String BOARD_LIST = "select * from BOARD order by seq desc";
    private final String BOARD_SEARCH = "select * from BOARD where name like ? order by seq desc"; // 검색 쿼리 추가

    // 게시물 삽입
    public int insertBoard(BoardVO vo) {
        System.out.println("===> JDBC로 insertBoard() 기능 처리");
        int generatedSeq = 0;
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_INSERT, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, vo.getName());
            stmt.setString(2, vo.getAuthor());
            stmt.setInt(3, vo.getDate());
            stmt.executeUpdate();

            // 자동 생성된 키 가져오기
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                generatedSeq = rs.getInt(1); // 첫 번째 컬럼 값
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generatedSeq;
    }

    // 게시물 삭제
    public int deleteBoard(int seq) {
        System.out.println("===> JDBC로 deleteBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_DELETE);
            stmt.setInt(1, seq);
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 게시물 수정
    public int updateBoard(BoardVO vo) {
        System.out.println("===> JDBC로 updateBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_UPDATE);
            stmt.setString(1, vo.getName());
            stmt.setString(2, vo.getAuthor());
            stmt.setInt(3, vo.getDate());
            stmt.setInt(4, vo.getSeq()); // seq는 수정 대상 식별용
            stmt.executeUpdate();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 특정 게시물 조회
    public BoardVO getBoard(int seq) {
        System.out.println("===> JDBC로 getBoard() 기능 처리");
        BoardVO vo = null;
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_GET);
            stmt.setInt(1, seq);
            rs = stmt.executeQuery();
            if (rs.next()) {
                vo = new BoardVO();
                vo.setSeq(rs.getInt("seq"));
                vo.setName(rs.getString("name"));
                vo.setAuthor(rs.getString("author"));
                vo.setDate(rs.getInt("date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vo;
    }

    // 게시물 목록 조회
    public List<BoardVO> getBoardList() {
        System.out.println("===> JDBC로 getBoardList() 기능 처리");
        List<BoardVO> boardList = new ArrayList<>();
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_LIST);
            rs = stmt.executeQuery();
            while (rs.next()) {
                BoardVO vo = new BoardVO();
                vo.setSeq(rs.getInt("seq"));
                vo.setName(rs.getString("name"));
                vo.setAuthor(rs.getString("author"));
                vo.setDate(rs.getInt("date"));
                boardList.add(vo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return boardList;
    }

    // 검색된 게시물 목록 조회
    public List<BoardVO> searchBoardList(String search) {
        System.out.println("===> JDBC로 searchBoardList() 기능 처리");
        List<BoardVO> boardList = new ArrayList<>();
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_SEARCH);
            stmt.setString(1, "%" + search + "%"); // 검색어를 LIKE 쿼리에 적용
            rs = stmt.executeQuery();
            while (rs.next()) {
                BoardVO vo = new BoardVO();
                vo.setSeq(rs.getInt("seq"));
                vo.setName(rs.getString("name"));
                vo.setAuthor(rs.getString("author"));
                vo.setDate(rs.getInt("date"));
                boardList.add(vo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return boardList;
    }
}
