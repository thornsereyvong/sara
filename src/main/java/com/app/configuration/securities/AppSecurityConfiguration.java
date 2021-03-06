package com.app.configuration.securities;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.session.RegisterSessionAuthenticationStrategy;
import org.springframework.security.web.session.HttpSessionEventPublisher;

@Configuration
@EnableWebSecurity
public class AppSecurityConfiguration extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private CustomAuthenticationProvider authenticationProvider;
	
	@Autowired
	private CustomAuthenticationFailureHandler authenticationFailureHandler;
	
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
		.failureUrl("/login?error")
		.and()
		/*.exceptionHandling().accessDeniedPage("/login?error")
		.and()
		.logout().logoutSuccessUrl("/login?logout")
		.and()*/
		.addFilterBefore(authenticationFilter(), UsernamePasswordAuthenticationFilter.class)
		.sessionManagement()
		.sessionFixation().migrateSession()
        .maximumSessions(1)
        .expiredUrl("/expired")
        .maxSessionsPreventsLogin(true)
        .sessionRegistry(sessionRegistry());;
		http.authorizeRequests().anyRequest().authenticated();
		http.csrf().disable();
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**");
	}
	
	@Bean
	public UsernamePasswordAuthenticationFilter authenticationFilter() {
		CustomUsernamPasswordAuthenticationFilter authFilter = new CustomUsernamPasswordAuthenticationFilter();
	    List<AuthenticationProvider> authenticationProviderList = new ArrayList<AuthenticationProvider>();
	    authenticationProviderList.add(authenticationProvider);
	    AuthenticationManager authenticationManager = new ProviderManager(authenticationProviderList);
	    authFilter.setAuthenticationManager(authenticationManager);
	    authFilter.setAuthenticationFailureHandler(authenticationFailureHandler);
	    //authFilter.setAuthenticationSuccessHandler(successHandler);
	    authFilter.setSessionAuthenticationStrategy(new RegisterSessionAuthenticationStrategy(sessionRegistry()));
	    authFilter.setUsernameParameter("crm_username");
	    authFilter.setPasswordParameter("crm_password");
	    return authFilter;
	}
	
	@Bean
	public HttpSessionEventPublisher httpSessionEventPublisher() {
	    return new HttpSessionEventPublisher();
	}
	
	@Bean
    public SessionRegistry sessionRegistry() {
        SessionRegistry sessionRegistry = new SessionRegistryImpl();
        return sessionRegistry;
    }
}
