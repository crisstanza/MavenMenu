package io.github.crisstanza.util;

import java.io.Closeable;

/**
 * @author Cris Stanza, 19-Ago-2015
 */
public final class Closer {

	private Closer() {
	}

	public static void close(Closeable closeMe) {
		try {
			if (closeMe != null) {
				closeMe.close();
			}
		} catch (Exception exc) {
			// nada a fazer!
		}
	}

}
