package com.proyecto.main;

import com.proyecto.services.LexicalAnalizer;

public class Main {

	public static void main(String[] args) {
		LexicalAnalizer.getInstance().readPatterns();
	}
}
