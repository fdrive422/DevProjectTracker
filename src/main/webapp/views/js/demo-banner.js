/* demo-banner.js — "this is a demo app" notice
 * Loaded in <head> so a previously dismissed banner never flashes on screen:
 * the dismissal is written as [data-demo-dismissed] on <html> during head parse,
 * and main.css hides .demo-banner whenever that attribute is present.
 */
(function () {
	"use strict";

	var KEY = "demoBannerDismissed";

	// --- Apply saved dismissal immediately (runs during <head> parse) ---
	try {
		if (localStorage.getItem(KEY) === "1") {
			document.documentElement.setAttribute("data-demo-dismissed", "");
		}
	} catch (e) { /* localStorage unavailable — banner simply stays visible */ }

	function dismiss() {
		document.documentElement.setAttribute("data-demo-dismissed", "");
		try { localStorage.setItem(KEY, "1"); } catch (e) {}
	}

	document.addEventListener("DOMContentLoaded", function () {
		var btns = document.querySelectorAll("[data-demo-banner-dismiss]");
		for (var i = 0; i < btns.length; i++) {
			btns[i].addEventListener("click", dismiss);
		}
	});
})();
