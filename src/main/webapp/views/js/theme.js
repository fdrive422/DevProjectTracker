/* theme.js — warm dev-tool theme
 * Loaded in <head> so the saved theme is applied before first paint (no flash).
 * Default follows the OS preference; a manual choice is persisted in localStorage
 * as a [data-theme] attribute on <html>, which locks light-dark() to one side.
 */
(function () {
	"use strict";

	var KEY = "theme";

	// --- Apply saved theme immediately (runs during <head> parse) ---
	try {
		var saved = localStorage.getItem(KEY);
		if (saved === "light" || saved === "dark") {
			document.documentElement.setAttribute("data-theme", saved);
		}
	} catch (e) { /* localStorage unavailable — fall back to OS preference */ }

	function currentTheme() {
		var attr = document.documentElement.getAttribute("data-theme");
		if (attr === "light" || attr === "dark") return attr;
		return (window.matchMedia &&
			window.matchMedia("(prefers-color-scheme: dark)").matches) ? "dark" : "light";
	}

	function refreshButton(btn) {
		if (!btn) return;
		var dark = currentTheme() === "dark";
		btn.textContent = dark ? "☀" : "☾"; // ☀ in dark mode, ☾ in light
		var label = dark ? "Switch to light theme" : "Switch to dark theme";
		btn.setAttribute("aria-label", label);
		btn.setAttribute("title", label);
	}

	function refreshAll() {
		var btns = document.querySelectorAll("[data-theme-toggle]");
		for (var i = 0; i < btns.length; i++) refreshButton(btns[i]);
	}

	// Exposed so inline handlers could call it too, if ever needed.
	window.toggleTheme = function () {
		var next = currentTheme() === "dark" ? "light" : "dark";
		document.documentElement.setAttribute("data-theme", next);
		try { localStorage.setItem(KEY, next); } catch (e) {}
		refreshAll();
	};

	document.addEventListener("DOMContentLoaded", function () {
		var btns = document.querySelectorAll("[data-theme-toggle]");
		for (var i = 0; i < btns.length; i++) {
			refreshButton(btns[i]);
			btns[i].addEventListener("click", window.toggleTheme);
		}
	});
})();
