package com.roofapp.ui.utils.messages;

public final class CrudErrorMessage {
	public static final String ENTITY_NOT_FOUND = "Выбранный объект не был найден.";

	public static final String CONCURRENT_UPDATE = "Возможно, кто-то другой обновил эти данные. Пожалуйста, обновите и повторите попытку.";

	public static final String OPERATION_PREVENTED_BY_REFERENCES = "Операция не может быть выполнена, так как в базе данных имеются ссылки на сущность.";

	public static final String REQUIRED_FIELDS_MISSING = "Пожалуйста, заполните все необходимые поля, прежде чем продолжить работу.";

	private CrudErrorMessage() {
	}
}
