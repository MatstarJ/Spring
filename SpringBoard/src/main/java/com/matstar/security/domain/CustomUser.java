package com.matstar.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.matstar.domain.MemberVO;

import lombok.Getter;
import lombok.Setter;

@Getter
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;
	
	@Setter(onMethod_=@Autowired)
	private MemberVO member;
	

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities,
			MemberVO member) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		
		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream()
				.map(auth->new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		
		this.member = vo;
	}
	
	
	
	
}
