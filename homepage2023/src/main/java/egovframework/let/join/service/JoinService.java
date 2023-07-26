package egovframework.let.join.service;

public interface JoinService {

	// 아이디 중복체크
	public int duplicateCheck(JoinVO vo) throws Exception;

	public String insertJoin(JoinVO vo) throws Exception;

}
