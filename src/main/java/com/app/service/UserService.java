package com.app.service;

import com.app.entities.CrmUser;

public interface UserService {

	CrmUser findUserByUsername(String username);
}
