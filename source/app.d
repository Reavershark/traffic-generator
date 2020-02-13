import vibe.vibe;
import vibe.http.server;
import std.range;
import std.algorithm;

immutable ubyte[] default_data = [cast(ubyte) '0'];
immutable ulong default_size = 1_000_000;

void handleRequest(scope HTTPServerRequest req, scope HTTPServerResponse res)
{
	enforce(req.method == HTTPMethod.GET);

	immutable ubyte[] data = ("data" in req.query) ? cast(immutable ubyte[]) req
		.query["data"] : default_data;
	immutable ulong size = ("size" in req.query) ? req.query["size"].to!ulong : default_size;

	res.writeBody(data.repeat.joiner.take(size).array);
}

shared static this()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];

	listenHTTP(settings, &handleRequest);
}
