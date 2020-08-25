package com.roofapp.app.security;

import com.roofapp.backend.dao.roofdb.entity.User;

@FunctionalInterface
public interface CurrentUser {

	User getUser();
}
