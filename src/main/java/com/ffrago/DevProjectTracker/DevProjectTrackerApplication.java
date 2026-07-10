package com.ffrago.DevProjectTracker;

import org.apache.catalina.connector.Connector;
import org.apache.coyote.ajp.AbstractAjpProtocol;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class DevProjectTrackerApplication {

	public static void main(String[] args) {
		SpringApplication.run(DevProjectTrackerApplication.class, args);
	}

	// Extra AJP connector (for fronting by a reverse proxy). Disabled by default —
	// Cloud Run only routes one port and an unsecured AJP connector is a risk there.
	// Enable locally/behind a proxy with app.ajp.enabled=true.
	@Bean
	@ConditionalOnProperty(name = "app.ajp.enabled", havingValue = "true")
	public TomcatServletWebServerFactory servletContainer() {
		TomcatServletWebServerFactory tomcat = new TomcatServletWebServerFactory();
		Connector ajpConnector = new Connector("AJP/1.3");
		ajpConnector.setPort(9090);
		ajpConnector.setSecure(false);
		ajpConnector.setAllowTrace(false);
		ajpConnector.setScheme("http");
		((AbstractAjpProtocol<?>) ajpConnector.getProtocolHandler()).setSecretRequired(false);
		tomcat.addAdditionalTomcatConnectors(ajpConnector);
		return tomcat;
	}

}
