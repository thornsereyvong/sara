package com.app.service;

import com.app.entities.CrmUserLogin;

public interface UserService {

	CrmUserLogin findUserByUsername(String username);
}
