import vibe.vibe;
import vibe.http.server;

void handleRequest(scope HTTPServerRequest req, scope HTTPServerResponse res)
{
	enforce(req.method == HTTPMethod.GET);
	res.bodyWriter.write("Hello world!");
}

shared static this()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];
	settings.sessionStore = new MemorySessionStore;

	listenHTTP(settings, &handleRequest);
}
