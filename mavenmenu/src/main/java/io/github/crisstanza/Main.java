package io.github.crisstanza;

import io.github.crisstanza.jchron.JChron;

/**
 * @author Cris Stanza, 19-Ago-2015
 */
public final class Main {

	private Main() {
	}

	public static final void main(final String[] args) {
		System.out.println(" [start]" + "\n");
		new Main().start();
		System.out.println(" [end]");
	}

	private final void start() {
		JChron cronometro = new JChron();
		cronometro.start();
		cronometro.stop();
		System.out.println("\t" + "tempo: " + cronometro.read() + "\n");
	}

}
