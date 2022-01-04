package com.matstar.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.matstar.domain.MemberVO;
import com.matstar.mapper.MemberMapper;
import com.matstar.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	
	@Setter(onMethod_= @Autowired )
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		
		MemberVO vo = memberMapper.read(userName);
		
		log.warn("Load User By UserName : " + userName);
		
		return vo == null ? null : new CustomUser(vo);
	}

	
	
}
