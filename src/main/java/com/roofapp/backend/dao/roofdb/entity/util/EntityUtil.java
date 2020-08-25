package com.roofapp.backend.dao.roofdb.entity.util;

import com.roofapp.backend.dao.roofdb.entity.AbstractEntity;

public final class EntityUtil {

	public static final String getName(Class<? extends AbstractEntity> type) {
		// All main entities have simple one word names, so this is sufficient. Metadata
		// could be added to the class if necessary.
		return type.getSimpleName();
	}
}
