package egovframework.let.member.service.impl;

import egovframework.let.member.service.MemberVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper {

	public MemberVO findId(MemberVO vo);

	public MemberVO findPassword(MemberVO vo);

	public void passwordUpdate(MemberVO vo);

}
