package com.roofapp.app.security;

import com.roofapp.backend.data.entity.User;

@FunctionalInterface
public interface CurrentUser {

	User getUser();
}
