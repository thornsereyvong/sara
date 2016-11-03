package com.app.configuration.securities;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class AppSecurityConfiguration extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private CustomAuthenticationProvider authenticationProvider;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(this.authenticationProvider);
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/layout/**", "/login", "/config/**", "/database/**").permitAll();
		http.authorizeRequests().anyRequest().hasAnyAuthority("")
		.and()
		.formLogin().loginPage("/login").loginProcessingUrl("/login")
		.usernameParameter("crm_username")
		.passwordParameter("crm_password")
		.and()
		.exceptionHandling().accessDeniedPage("/login");
		http.authorizeRequests().anyRequest().authenticated();
		http.sessionManagement().maximumSessions(1);
		http.sessionManagement().sessionFixation().migrateSession();
		http.sessionManagement().invalidSessionUrl("/login");
		http.csrf().disable();
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**");
	}
	
}
