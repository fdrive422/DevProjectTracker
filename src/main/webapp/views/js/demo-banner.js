/* demo-banner.js — "this is a demo app" notice
 * Loaded in <head> so a banner dismissed earlier in the visit never flashes on
 * screen: the dismissal is written as [data-demo-dismissed] on <html> during
 * head parse, and main.css hides .demo-banner whenever that attribute is present.
 *
 * Dismissal lives in sessionStorage, not localStorage — the notice is a
 * disclaimer, so it should come back on the visitor's next visit rather than
 * being silenced forever on that browser.
 */
(function () {
	"use strict";

	var KEY = "demoBannerDismissed";

	// --- Apply this session's dismissal immediately (runs during <head> parse) ---
	try {
		if (sessionStorage.getItem(KEY) === "1") {
			document.documentElement.setAttribute("data-demo-dismissed", "");
		}
		// Clear the key left by the earlier localStorage-backed version, which
		// would otherwise keep the banner hidden permanently for those visitors.
		localStorage.removeItem(KEY);
	} catch (e) { /* storage unavailable — banner simply stays visible */ }

	function dismiss() {
		document.documentElement.setAttribute("data-demo-dismissed", "");
		try { sessionStorage.setItem(KEY, "1"); } catch (e) {}
	}

	document.addEventListener("DOMContentLoaded", function () {
		var btns = document.querySelectorAll("[data-demo-banner-dismiss]");
		for (var i = 0; i < btns.length; i++) {
			btns[i].addEventListener("click", dismiss);
		}
	});
})();
