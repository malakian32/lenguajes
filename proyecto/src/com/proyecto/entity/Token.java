package com.proyecto.entity;

public class Token {
	public String lexicalCategory;
	public String value;

	public Token() {
	}

	public Token(String lexicalCategory, String value) {
		this.lexicalCategory = lexicalCategory;
		this.value = value;
	}

	@Override
	public String toString() {
		return String.format("[%s, %s]", lexicalCategory, value);
	}

}
