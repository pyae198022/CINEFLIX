package com.java.spring.movie.utility;

public class ViewCountFormatter {

	public static String format(Long count) {
        if (count == null) {
            return "0";
        }
        if (count < 1000) {
            return String.valueOf(count);
        }
        if (count < 1000000) {
            return String.format("%.1fK", count / 1000.0);
        }
        if (count < 1000000000) {
            return String.format("%.1fM", count / 1000000.0);
        }
        return String.format("%.1fB", count / 1000000000.0);
    }
}
